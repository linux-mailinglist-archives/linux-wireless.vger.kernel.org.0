Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED003318557
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 07:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhBKGtL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 01:49:11 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:39411 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229577AbhBKGs6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 01:48:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613026118; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=qJImtocT1kKiu3caOORG9t/83ASBDabX8bj4mTrx8pI=;
 b=Pk4R6ngCiHCNgoXQ95hv6yNNYfZKLvA4Nfnohz5TD2+yCZ2h7qNdYF14FGKiX0UrxOVQicdV
 +oHD2ml1UHXBlmewvvQC0/BtEKaD7C9tJAlq3P+jP3RuzSL8LhmxdnD0TM3cQ6ah9XfiY2t2
 nt/5ilYSbQ0Fb0l82wE5XKh3MCY=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6024d33481f6c45dce3e4c78 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Feb 2021 06:48:20
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 81BB8C43462; Thu, 11 Feb 2021 06:48:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 13AF6C433C6;
        Thu, 11 Feb 2021 06:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13AF6C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: restore tx sk_buff of htt header for SDIO
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1612839530-2263-1-git-send-email-wgong@codeaurora.org>
References: <1612839530-2263-1-git-send-email-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong@codeaurora.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210211064819.81BB8C43462@smtp.codeaurora.org>
Date:   Thu, 11 Feb 2021 06:48:19 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> ieee80211_report_used_skb of mac80211 use the frame_control of
> ieee80211_hdr in sk_buff and indicate it to another function
> ieee80211_mgd_conn_tx_status, then it queue work ieee80211_sta_work,
> but ieee80211_is_auth(fc) in ieee80211_sta_work check fail when the
> authentication has transmitted by ath10k.
> 
> When the ath10k report it with HTT_TX_COMPL_STATE_DISCARD, it will be
> set without flag IEEE80211_TX_STAT_ACK, then mac80211 should try the
> next authentication immeditely, but in fact mac80211 wait 1 second for
> it, the reason is ieee80211_is_auth(fc) in ieee80211_sta_work check
> fail for the sk_buff which is not restored, the data of sk_buff is not
> the begin of ieee80211_hdr, in fact it is the begin of htt_cmd_hdr.
> 
> dmesg without this patch, it wait 1 second for the next retry when
> ath10k report without IEEE80211_TX_STAT_ACK for authentication:
> [ 6973.883116] wlan0: send auth to 5e:6f:2b:0d:fb:d7 (try 1/3)
> [ 6974.705471] wlan0: send auth to 5e:6f:2b:0d:fb:d7 (try 2/3)
> [ 6975.712962] wlan0: send auth to 5e:6f:2b:0d:fb:d7 (try 3/3)
> 
> Restore the sk_buff make mac8011 retry the next authentication
> immeditely which meet logic of mac80211.
> 
> dmesg with this patch, it retry the next immeditely when ath10k
> report without IEEE80211_TX_STAT_ACK for authentication:
> [  216.734813] wlan0: send auth to 5e:6f:2b:0d:fb:d7 (try 1/3)
> [  216.739914] wlan0: send auth to 5e:6f:2b:0d:fb:d7 (try 2/3)
> [  216.745874] wlan0: send auth to 5e:6f:2b:0d:fb:d7 (try 3/3)
> 
> Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

e6f1c0d26a31 ath10k: restore tx sk_buff of htt header for SDIO

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1612839530-2263-1-git-send-email-wgong@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

