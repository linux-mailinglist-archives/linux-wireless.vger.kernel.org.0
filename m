Return-Path: <linux-wireless+bounces-32933-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO3+JUOqsGmYlwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32933-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 00:33:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B1F259480
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 00:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 179EB30120F1
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 23:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4F522DFA4;
	Tue, 10 Mar 2026 23:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQFNUpyp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441BF1D5CFB
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 23:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773185601; cv=none; b=MAVrfybY6O1OtVfh3sRyNJUHilbTCrMs4z1bkF+HVfue69vxlm/jhubKUyQJTP+Y9BwtyJJKwv/3U7/zHLk4MkYvJzvtS+kFxZJPQjnMd57HOHV2Red4o8tSBQXxDsu/FqQaUneLJ0sAsSHk3Sxg1ft5J7FSb8i8y6M4lyMGC2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773185601; c=relaxed/simple;
	bh=+pSef1JG9Haul964EmMsvb0o/WPIvPCrdENGK7/qAMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eT2l/bipflDZByoAov1kKrdiXSS1wyF6d4FhAVci9izE62iQKUXcwSO3apd65eR9CxZnzpoUEZzC7e6FXSGxucCGSpnOCjwK1SXhS6ka9ygwMWIgWdZnYr9El1DSE5DbWeBfzO2WzBkWBBQSEzw1iO+XjrV6AfM5pDMBlpnbf6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQFNUpyp; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59de8155501so7982950e87.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 16:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773185597; x=1773790397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JuNpzPmymoQ4ibLd5iWSwPVLI6Ss0/KvYtvWwZeU0TQ=;
        b=aQFNUpyp0Jy4kCtoq9HUpd8nTJ+I6N0Hxd92PttX7pEUTUrkWnRE+K27vs41xiGZX1
         Jn95VBlk/O47oJjpY6+/btCCLRLMSEeiitVBcJZNQWwe4kcMDO6AWXsMZLl3PhGBfXM6
         sum6S2gj4xiWubrTnP7n9xqyGJlLhXA5VCTKe6X1OerNT2VmP92cF8rF528IrO8R54Bm
         7eM06xJfg9gnhgZaJSaksCD9cGU2zzn5F056gp4lyYdKvXk3nqRF5/vnxo4C3FzhFqfE
         nPZ5XfC1WFRXwflLnJprTG+P5LMMNsnIiZUinc48E6aL2LeiP2HUzcoAgLb/MpO/aWgr
         qbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773185597; x=1773790397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuNpzPmymoQ4ibLd5iWSwPVLI6Ss0/KvYtvWwZeU0TQ=;
        b=oUdJXJbt0e7p+qLMTir+0Rb5iit+iO9UXPdg9SZspb2FxXczrVTkSQptFZ1jy35cc4
         okhmsxDB+xLshMZbfmXQjcMW6oeJV0/tI7CkvuoWZ/2mMInP09GeT7M07AVzND0bi1I6
         mW31OPNpFovSCE0hF20RVRgb/lkyMN946ODOpGCgN/ACEf8AsgstjMzVZDDbd7n6aVos
         43P5EYuiY0TozdNJxyi9ioRMvjeyBIE4KU2vjPtJ4+DOOV7LYUQJKbtANJgiBGe5u69h
         GshAvB4IN4qjL8iIL9Jj03ZtINMlh2JyUIH3K9LvHfLPiuYzYWmmJVrERBmPtKu01C1F
         43mA==
X-Forwarded-Encrypted: i=1; AJvYcCWMzrOByc6W3gc7tsuu3khrNB8CbNV7vXgLOmUCwwCqcmo4PH/ggZXBNsoJ/X0utYm0zWm8cOFhtAOEdO5Q2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvBnnRSAVWaXBBriiq9OS+6P+cZg+VC+wLnIq7N08Im0Ug+qha
	TDm9fgEgPWDDlJHdKmbtDKysiR96fGRPX4XEOx1d1hVqOk+3jYXaPuuNn7btUA==
X-Gm-Gg: ATEYQzx5XRJsuEQKFl7ba+eGa7J1vyq+yZrow8qeQsYg/xnKizIMOQGK/8TnZyW/Q1n
	FhdK5LQd5t8/LHEKThUD/HINyXVwy6QLqfFeUEjhmUAOITbywiQ+kCFXB87waIXuVhqfibDyq2w
	rUThKEAQ1tJY4EChgup/GtLZtu5s0QcS53KJdaffrnMSdxkLeCXIXz1862xy8CIa8sq1abZKgDb
	OHJgMOmT8xSPPGK1u1mqVTk8+ARYYXudV1sx58MMBBhnDa5MYsYeVhNTxQtYK1Pre0QqTX9HQfO
	KrKfRuY+s166vouTr4WOYizCyMuAOR5/P0h1WLCftNdlXPhunaTKXX2mNT39oKr5gKx6DoT7OUg
	Sxhon0pFAaXtGsJTiq8fqovLsUWYOLXTuz8hSI/bgywZe8qspnFcDIZz9zQxnwJAYfg/S1P9ob0
	ngrSUgK4mPSztxjrYdJJVr4MFdr8DOVA==
X-Received: by 2002:ac2:57ce:0:b0:5a1:427d:93ea with SMTP id 2adb3069b0e04-5a156dcda50mr72306e87.37.1773185597068;
        Tue, 10 Mar 2026 16:33:17 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156162aadsm93661e87.43.2026.03.10.16.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 16:33:16 -0700 (PDT)
Message-ID: <6cd52588-b498-4239-9980-b3c659206866@gmail.com>
Date: Wed, 11 Mar 2026 01:33:14 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/21] wifi: rtl8xxxu: add hw crypto support for AP
 mode
To: Martin Kaistra <martin.kaistra@linutronix.de>,
 linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20231222101442.626837-1-martin.kaistra@linutronix.de>
 <20231222101442.626837-20-martin.kaistra@linutronix.de>
 <b47a1c95-60c4-468d-9944-c59546e082bf@gmail.com>
 <b8e9ad0c-c148-40a2-b114-5558e74942b0@linutronix.de>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <b8e9ad0c-c148-40a2-b114-5558e74942b0@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 16B1F259480
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32933-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,linutronix.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,realtek.com:email,linutronix.de:email]
X-Rspamd-Action: no action

On 24/02/2026 17:43, Martin Kaistra wrote:
> Am 21.02.26 um 23:09 schrieb Bitterblue Smith:
>> On 22/12/2023 12:14, Martin Kaistra wrote:
>>> Add a custom function for allocating entries in the sec cam. This allows
>>> us to store multiple keys with the same keyidx.
>>>
>>> The maximum number of sec cam entries for 8188f is 16 according to the
>>> vendor driver. Add the number to rtl8xxxu_fileops, so that other chips
>>> which might support more entries, can set a different number there.
>>>
>>> Set the bssid as mac address for group keys instead of just using the
>>> ethernet broadcast address and use BIT(6) in the sec cam ctrl entry
>>> for differentiating them from pairwise keys like in the vendor driver.
>>>
>>> Add the TXDESC_EN_DESC_ID bit and the hw_key_idx to tx
>>> broadcast/multicast packets in AP mode.
>>>
>>> Finally, allow the usage of rtl8xxxu_set_key() for AP mode.
>>>
>>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>>> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
>>> ---
>>>   .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  5 ++
>>>   .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |  1 +
>>>   .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 48 +++++++++++++++----
>>>   3 files changed, 44 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>>> index c5e6d8f7d26bd..62e6318bc0924 100644
>>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>>> @@ -498,6 +498,7 @@ struct rtl8xxxu_txdesc40 {
>>>   #define DESC_RATE_ID_SHIFT        16
>>>   #define DESC_RATE_ID_MASK        0xf
>>>   #define TXDESC_NAVUSEHDR        BIT(20)
>>> +#define TXDESC_EN_DESC_ID        BIT(21)
>>>   #define TXDESC_SEC_RC4            0x00400000
>>>   #define TXDESC_SEC_AES            0x00c00000
>>>   #define TXDESC_PKT_OFFSET_SHIFT        26
>>> @@ -1775,6 +1776,7 @@ struct rtl8xxxu_cfo_tracking {
>>>   #define RTL8XXXU_MAX_MAC_ID_NUM    128
>>>   #define RTL8XXXU_BC_MC_MACID    0
>>>   #define RTL8XXXU_BC_MC_MACID1    1
>>> +#define RTL8XXXU_MAX_SEC_CAM_NUM    64
>>>     struct rtl8xxxu_priv {
>>>       struct ieee80211_hw *hw;
>>> @@ -1908,6 +1910,7 @@ struct rtl8xxxu_priv {
>>>       char led_name[32];
>>>       struct led_classdev led_cdev;
>>>       DECLARE_BITMAP(mac_id_map, RTL8XXXU_MAX_MAC_ID_NUM);
>>> +    DECLARE_BITMAP(cam_map, RTL8XXXU_MAX_SEC_CAM_NUM);
>>>   };
>>>     struct rtl8xxxu_sta_info {
>>> @@ -1919,6 +1922,7 @@ struct rtl8xxxu_sta_info {
>>>     struct rtl8xxxu_vif {
>>>       int port_num;
>>> +    u8 hw_key_idx;
>>>   };
>>>     struct rtl8xxxu_rx_urb {
>>> @@ -1993,6 +1997,7 @@ struct rtl8xxxu_fileops {
>>>       u16 max_aggr_num;
>>>       u8 supports_ap:1;
>>>       u16 max_macid_num;
>>> +    u16 max_sec_cam_num;
>>>       u32 adda_1t_init;
>>>       u32 adda_1t_path_on;
>>>       u32 adda_2t_path_on_a;
>>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
>>> index 1e1c8fa194cb8..574a5fe951543 100644
>>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
>>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
>>> @@ -1751,6 +1751,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
>>>       .max_aggr_num = 0x0c14,
>>>       .supports_ap = 1,
>>>       .max_macid_num = 16,
>>> +    .max_sec_cam_num = 16,
>>>       .adda_1t_init = 0x03c00014,
>>>       .adda_1t_path_on = 0x03c00014,
>>>       .trxff_boundary = 0x3f7f,
>>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>> index ecf54eb8dba61..7aafae9fe76b8 100644
>>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>> @@ -4559,8 +4559,10 @@ static void rtl8xxxu_cam_write(struct rtl8xxxu_priv *priv,
>>>        * This is a bit of a hack - the lower bits of the cipher
>>>        * suite selector happens to match the cipher index in the CAM
>>>        */
>>> -    addr = key->keyidx << CAM_CMD_KEY_SHIFT;
>>> +    addr = key->hw_key_idx << CAM_CMD_KEY_SHIFT;
>>>       ctrl = (key->cipher & 0x0f) << 2 | key->keyidx | CAM_WRITE_VALID;
>>> +    if (!(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
>>> +        ctrl |= BIT(6);
>>>         for (j = 5; j >= 0; j--) {
>>>           switch (j) {
>>> @@ -5546,13 +5548,14 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>>>       struct rtl8xxxu_tx_urb *tx_urb;
>>>       struct ieee80211_sta *sta = NULL;
>>>       struct ieee80211_vif *vif = tx_info->control.vif;
>>> +    struct rtl8xxxu_vif *rtlvif = (struct rtl8xxxu_vif *)vif->drv_priv;
>>>       struct device *dev = &priv->udev->dev;
>>>       u32 queue, rts_rate;
>>>       u16 pktlen = skb->len;
>>>       int tx_desc_size = priv->fops->tx_desc_size;
>>>       u8 macid;
>>>       int ret;
>>> -    bool ampdu_enable, sgi = false, short_preamble = false;
>>> +    bool ampdu_enable, sgi = false, short_preamble = false, bmc = false;
>>>         if (skb_headroom(skb) < tx_desc_size) {
>>>           dev_warn(dev,
>>> @@ -5594,10 +5597,14 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>>>           tx_desc->txdw0 =
>>>               TXDESC_OWN | TXDESC_FIRST_SEGMENT | TXDESC_LAST_SEGMENT;
>>>       if (is_multicast_ether_addr(ieee80211_get_DA(hdr)) ||
>>> -        is_broadcast_ether_addr(ieee80211_get_DA(hdr)))
>>> +        is_broadcast_ether_addr(ieee80211_get_DA(hdr))) {
>>>           tx_desc->txdw0 |= TXDESC_BROADMULTICAST;
>>> +        bmc = true;
>>> +    }
>>> +
>>>         tx_desc->txdw1 = cpu_to_le32(queue << TXDESC_QUEUE_SHIFT);
>>> +    macid = rtl8xxxu_get_macid(priv, sta);
>>>         if (tx_info->control.hw_key) {
>>>           switch (tx_info->control.hw_key->cipher) {
>>> @@ -5612,6 +5619,10 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>>>           default:
>>>               break;
>>>           }
>>> +        if (bmc && rtlvif->hw_key_idx != 0xff) {
>>> +            tx_desc->txdw1 |= TXDESC_EN_DESC_ID;
>>> +            macid = rtlvif->hw_key_idx;
>>> +        }
>>>       }
>>>         /* (tx_info->flags & IEEE80211_TX_CTL_AMPDU) && */
>>> @@ -5655,7 +5666,6 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>>>       else
>>>           rts_rate = 0;
>>>   -    macid = rtl8xxxu_get_macid(priv, sta);
>>>       priv->fops->fill_txdesc(hw, hdr, tx_info, tx_desc, sgi, short_preamble,
>>>                   ampdu_enable, rts_rate, macid);
>>>   @@ -6667,6 +6677,7 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
>>>         priv->vifs[port_num] = vif;
>>>       rtlvif->port_num = port_num;
>>> +    rtlvif->hw_key_idx = 0xff;
>>>         rtl8xxxu_set_linktype(priv, vif->type, port_num);
>>>       ether_addr_copy(priv->mac_addr, vif->addr);
>>> @@ -6843,11 +6854,19 @@ static int rtl8xxxu_set_rts_threshold(struct ieee80211_hw *hw, u32 rts)
>>>       return 0;
>>>   }
>>>   +static int rtl8xxxu_get_free_sec_cam(struct ieee80211_hw *hw)
>>> +{
>>> +    struct rtl8xxxu_priv *priv = hw->priv;
>>> +
>>> +    return find_first_zero_bit(priv->cam_map, priv->fops->max_sec_cam_num);
>>> +}
>>> +
>>>   static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>>>                   struct ieee80211_vif *vif,
>>>                   struct ieee80211_sta *sta,
>>>                   struct ieee80211_key_conf *key)
>>>   {
>>> +    struct rtl8xxxu_vif *rtlvif = (struct rtl8xxxu_vif *)vif->drv_priv;
>>>       struct rtl8xxxu_priv *priv = hw->priv;
>>>       struct device *dev = &priv->udev->dev;
>>>       u8 mac_addr[ETH_ALEN];
>>> @@ -6859,9 +6878,6 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>>>       dev_dbg(dev, "%s: cmd %02x, cipher %08x, index %i\n",
>>>           __func__, cmd, key->cipher, key->keyidx);
>>>   -    if (vif->type != NL80211_IFTYPE_STATION)
>>> -        return -EOPNOTSUPP;
>>> -
>>>       if (key->keyidx > 3)
>>>           return -EOPNOTSUPP;
>>>   @@ -6885,7 +6901,7 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>>>           ether_addr_copy(mac_addr, sta->addr);
>>>       } else {
>>>           dev_dbg(dev, "%s: group key\n", __func__);
>>> -        eth_broadcast_addr(mac_addr);
>>> +        ether_addr_copy(mac_addr, vif->bss_conf.bssid);
>>>       }
>>>         val16 = rtl8xxxu_read16(priv, REG_CR);
>>> @@ -6899,16 +6915,28 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>>>         switch (cmd) {
>>>       case SET_KEY:
>>> -        key->hw_key_idx = key->keyidx;
>>> +
>>> +        retval = rtl8xxxu_get_free_sec_cam(hw);
>>> +        if (retval < 0)
>>> +            return -EOPNOTSUPP;
>>> +
>>> +        key->hw_key_idx = retval;
>>> +
>>> +        if (vif->type == NL80211_IFTYPE_AP && !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
>>> +            rtlvif->hw_key_idx = key->hw_key_idx;
>>> +
>>>           key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV;
>>>           rtl8xxxu_cam_write(priv, key, mac_addr);
>>> +        set_bit(key->hw_key_idx, priv->cam_map);
>>
>> Hi Martin,
> 
> Hi Bitterblue,
> 
>>
>> It turns out RTL8188CUS and RTL8192CU don't like this patch, specifically
>> when we use iwd. After the WPA2 handshake no more data is transmitted.
>>
>> Before this patch, key->hw_key_idx was the same as key->keyidx. After
>> this patch, when we use iwd, the group key is installed first. It has
>> key->keyidx = 1, but it gets key->hw_key_idx = 0. The pairwise key is
>> installed second. It has key->keyidx = 0, but it gets key->hw_key_idx = 1.
>> Both keyidx and hw_key_idx are passed to the chip in rtl8xxxu_cam_write().
>>
>> It's fine with wpa_supplicant. wpa_supplicant installs the pairwise key
>> first, with key->keyidx = 0, then the group key, with key->keyidx = 1.
>>
>> This patch imitating rtw88 makes the old chips work again with iwd.
>> What do you think?
> 
> So you reserve the first 4 entries for group keys and use key->keyidx as key->hw_key_idx directly for those, right? Does that work if 2 virtual interfaces are used at the same time?

Yes. I don't know if that works with 2 interfaces. How can I test?
I never tried to use 2 interfaces at the same time.

> I will do some tests in the next days, but I suspect this be an issue.
> 
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> index ee278f0548e4..f7b35655bec5 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
>> @@ -6942,7 +6942,8 @@ static int rtl8xxxu_get_free_sec_cam(struct ieee80211_hw *hw)
>>   {
>>       struct rtl8xxxu_priv *priv = hw->priv;
>>   -    return find_first_zero_bit(priv->cam_map, priv->fops->max_sec_cam_num);
>> +    return find_next_zero_bit(priv->cam_map, priv->fops->max_sec_cam_num,
>> +                  RTL8XXXU_SEC_DEFAULT_KEY_NUM);
>>   }
>>     static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>> @@ -6999,12 +7000,15 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>>         switch (cmd) {
>>       case SET_KEY:
>> +        if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE) {
>> +            retval = rtl8xxxu_get_free_sec_cam(hw);
>> +            if (retval < 0)
>> +                return -EOPNOTSUPP;
>>   -        retval = rtl8xxxu_get_free_sec_cam(hw);
>> -        if (retval < 0)
>> -            return -EOPNOTSUPP;
>> -
>> -        key->hw_key_idx = retval;
>> +            key->hw_key_idx = retval;
>> +        } else {
>> +            key->hw_key_idx = key->keyidx;
>> +        }
>>             if (vif->type == NL80211_IFTYPE_AP && !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
>>               rtlvif->hw_key_idx = key->hw_key_idx;
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> index 4b05dba22e67..188f4bbe99cd 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> @@ -1788,6 +1788,7 @@ struct rtl8xxxu_cfo_tracking {
>>   #define RTL8XXXU_BC_MC_MACID    0
>>   #define RTL8XXXU_BC_MC_MACID1    1
>>   #define RTL8XXXU_MAX_SEC_CAM_NUM    64
>> +#define RTL8XXXU_SEC_DEFAULT_KEY_NUM    4
>>     struct rtl8xxxu_priv {
>>       struct ieee80211_hw *hw;
> 


