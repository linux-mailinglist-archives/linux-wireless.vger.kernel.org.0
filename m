Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEA0348838
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2019 18:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfFQQDr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jun 2019 12:03:47 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:49560 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfFQQDr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jun 2019 12:03:47 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 934D3137560;
        Mon, 17 Jun 2019 09:03:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 934D3137560
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1560787426;
        bh=qihpQ4YKC1KRJjLDZybHBWXT8408PGMnM4qg5Rm7KFA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rfDc/qpVAlPnKwIZc1ZWo9TY/Op2f2us3q7+pIKREi7w3andOvWefCRLNTTtEhjaE
         0pGlm+pVSEiUTIPVZ/28S3z0fSWrrXYw0GeXCi6NwdHMuSiId7UlyBtZprJgT01Kw0
         kcv5oUkw4ucKhfTLrCbRh7nFbH1WrRGohXI77Z1c=
Subject: Re: [PATCH] ath10k: add mic bytes for pmf management packet
To:     Wen Gong <wgong@codeaurora.org>, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <1560757079-19266-1-git-send-email-wgong@codeaurora.org>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <136d04d4-671b-8dde-2abd-63070b07bd26@candelatech.com>
Date:   Mon, 17 Jun 2019 09:03:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1560757079-19266-1-git-send-email-wgong@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/17/19 12:37 AM, Wen Gong wrote:
> For PMF case, the action,deauth,disassoc management need to encrypt
> by hardware, it need to reserve 8 bytes for encryption, otherwise
> the packet will be sent out with error format, then PMF case will
> fail.
> 
> After add the 8 bytes, it will pass the PMF case.
> 
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00005-QCARMSWP-1.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> ---
>   drivers/net/wireless/ath/ath10k/htt_tx.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
> index d8e9cc0..7bef9d9 100644
> --- a/drivers/net/wireless/ath/ath10k/htt_tx.c
> +++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
> @@ -1236,6 +1236,7 @@ static int ath10k_htt_tx_hl(struct ath10k_htt *htt, enum ath10k_hw_txrx_mode txm
>   	struct ath10k *ar = htt->ar;
>   	int res, data_len;
>   	struct htt_cmd_hdr *cmd_hdr;
> +	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)msdu->data;
>   	struct htt_data_tx_desc *tx_desc;
>   	struct ath10k_skb_cb *skb_cb = ATH10K_SKB_CB(msdu);
>   	struct sk_buff *tmp_skb;
> @@ -1245,6 +1246,13 @@ static int ath10k_htt_tx_hl(struct ath10k_htt *htt, enum ath10k_hw_txrx_mode txm
>   	u8 flags0 = 0;
>   	u16 flags1 = 0;
>   
> +	if ((ieee80211_is_action(hdr->frame_control) ||
> +	     ieee80211_is_deauth(hdr->frame_control) ||
> +	     ieee80211_is_disassoc(hdr->frame_control)) &&
> +	     ieee80211_has_protected(hdr->frame_control)) {
> +		skb_put(msdu, IEEE80211_CCMP_MIC_LEN);
> +	}

I was looking at mac80211 code recently, and it seems some action
frames are NOT supposed to be protected.  I added my own helper
method to my local ath10k.  Maybe you want to use this?


/* Copied from ieee80211_is_robust_mgmt_frame, but disable the check for has_protected
  * since we do tx hw crypt, and it won't actually be encrypted even when this flag is
  * set.
  */
bool ieee80211_is_robust_mgmt_frame_tx(struct ieee80211_hdr *hdr)
{
         if (ieee80211_is_disassoc(hdr->frame_control) ||
             ieee80211_is_deauth(hdr->frame_control))
                 return true;

         if (ieee80211_is_action(hdr->frame_control)) {
                 u8 *category;

                 /*
                  * Action frames, excluding Public Action frames, are Robust
                  * Management Frames. However, if we are looking at a Protected
                  * frame, skip the check since the data may be encrypted and
                  * the frame has already been found to be a Robust Management
                  * Frame (by the other end).
                  */
		/*
		if (ieee80211_has_protected(hdr->frame_control))
                         return true;
		*/
                 category = ((u8 *) hdr) + 24;
                 return *category != WLAN_CATEGORY_PUBLIC &&
                         *category != WLAN_CATEGORY_HT &&
                         *category != WLAN_CATEGORY_WNM_UNPROTECTED &&
                         *category != WLAN_CATEGORY_SELF_PROTECTED &&
                         *category != WLAN_CATEGORY_UNPROT_DMG &&
                         *category != WLAN_CATEGORY_VHT &&
                         *category != WLAN_CATEGORY_VENDOR_SPECIFIC;
         }

         return false;
}

Thanks,
Ben

> +
>   	data_len = msdu->len;
>   
>   	switch (txmode) {
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

