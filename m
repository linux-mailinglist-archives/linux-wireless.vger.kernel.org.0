Return-Path: <linux-wireless+bounces-23157-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BF5ABC1C7
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 17:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59F9718909F6
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 15:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970CE284B40;
	Mon, 19 May 2025 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xzq9OBK+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34665283FEE
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747667492; cv=none; b=buwzELvHgcc6COTVFEkPr2ciHNE4CJXEn5Cs6STXYZ3pBFgFxic47WRWD74dfW+jtJ1Z1wVHieuMQzgJT8GJPZ7Wyk7zHyQ2MRrx6kVd5ds6XhaVx5H62Ow+ekbTaRoR2sGPlYAn9XJiNCxpnikw0cGkniJIDsibNrC4ad4FyzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747667492; c=relaxed/simple;
	bh=ipCJPVedwHjI4QLsxFqW3FavNfzJ1WEN8VZ2TRVwhA4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=S8a7TeLBXui8JxcrxuPd/a8KGspj9QwT0nWB572SFiDyLqxSyO9Yefi7/eD6+dJS4Whk7UIWX10RzgDO1n2FORCqK7KtjzKvLB4f7B9FDecWv5eyu7qq6Rb4VYS+nXGGwd4yE3w6eFHN5/BFHxQ4So1gY6axn2QjYiVWdj5T93A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xzq9OBK+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-442ccf0e1b3so55530055e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 08:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747667488; x=1748272288; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p311D//fNmx/GnFe2BD77SqJxf5TY8Y/xCia91MxfcY=;
        b=Xzq9OBK+sYymG7RmUMi7boriSQh8c9IdNb/JMRNlqWMta/aSGL0htZurMcHM5NGOjm
         yxgHLJaBB94/R8n7Z0Zvp69ACPN6+MA1kL28UC3MmGuMZ+5+ME9XtaJqibhb15U2eKoD
         lqf/AB3ATpnL9TiPQQGbmXtbZ9cmmAdMRJMFZz0LjqfVVuoza06ZvMq7LWD9k07d9Zro
         1XugFwqUKQthnNOgRaWM3VH9O0ewbRiPOMUG36xKMK7wdG4DZT4VLjlZ+2/idYAkpWIj
         cCHmGspxZoLTdRjRJEhz25Te2KnzBCyWWinkABsXnxtszcLPFndchX8DV/omLVzwOb6U
         6hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747667488; x=1748272288;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p311D//fNmx/GnFe2BD77SqJxf5TY8Y/xCia91MxfcY=;
        b=N8Co6vTfJmmlF/OpBWc+MFmoctJ7euTq4jTbn6cC3JTX4Dayb4YUgdeSwMREcHQfbQ
         VntLnlbiemtDAmkDKwqmcY86QV6Ssx0OrvmEmxbHRALWbRc6zHHRbdUea2O5EPwaeBBv
         +pQjG1oQsK9UP45ktVbqXpQ4cq/4FfTIWBn5McYqdgT5puiCH+kscNId+pVaybZZdEUc
         m6yR51sd40+PXS2ShsXYOpylT0jN+gaAs3ekCpmqtu4E3d1EPaHwFhG9PDBSNMQ9jD/O
         2VzksfiquACjltef8NI5Ro7lHM5IVjGbdpqWVajJ+WcvO4c+GKcvOUJYBHO83h1N4/bc
         0Uyw==
X-Gm-Message-State: AOJu0YwtiOtF2bJx3dmQ0/EHmmGYsPBpVxTYzYtuj+zh3aBFcecjDCnU
	kbocowxLr5YHx9dMJYnuzertEh8IxGk+yhhgx9NYjESV5RliBmjpAa+s
X-Gm-Gg: ASbGnctfFgi941R1MqVWW8/HgWZEcfp8u2KcE53t5tNP56ovzja0sssJqyhAJoIMeQP
	A7WAG5jvwS3jMfzWqcRFfjYfGoug43PpDOWUtJVQKUMcDe8Lq8T6KmavJJ82N+jP8NkMzz3eJEr
	3QcTTsRQjuce0ej2sixMfrhRLt7geG2Lw/vXW17My8ItrqrrwCzpN4sdbIhMKP0KFKpWUoQGt+j
	wgcQMmyG7s0tnRUPzrrFaY8u7DHgO5o179CHz8hTVa0FOhmvLN88bSg8GZSJz4JaI6keevGW2lY
	bSfPX4xVVLWwWisWdLd+C2usrGFUZfKbbBfv+qkzcFFM0YWBbWNOtYwUR4+l+QLR3hYfEKrI325
	uRPoF
X-Google-Smtp-Source: AGHT+IHFyZHIyrcYe/USleuAgTaUwD4OgFsuo7BATAmi0EMS/lWwD3Aj2fSBu9c73EXwKsCdHYts7A==
X-Received: by 2002:a05:600c:5305:b0:441:b19c:96fe with SMTP id 5b1f17b1804b1-442fd622eb4mr158353615e9.10.1747667488104;
        Mon, 19 May 2025 08:11:28 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f395166fsm214209205e9.18.2025.05.19.08.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 08:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 17:11:27 +0200
Message-Id: <DA08F3TG062A.151WKWWF5OPL0@gmail.com>
Subject: Re: [PATCH V13 8/9] wifi: ath12k: add support for 160 MHz bandwidth
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Pradeep Kumar Chitrapu" <quic_pradeepc@quicinc.com>,
 <ath12k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>, "P Praneesh"
 <quic_ppranees@quicinc.com>, "Jeff Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250418174818.3336510-1-quic_pradeepc@quicinc.com>
 <20250418174818.3336510-9-quic_pradeepc@quicinc.com>
In-Reply-To: <20250418174818.3336510-9-quic_pradeepc@quicinc.com>

On Fri Apr 18, 2025 at 7:48 PM CEST, Pradeep Kumar Chitrapu wrote:
> Add support to configure maximum NSS in 160 MHz bandwidth.
> Firmware advertises support for handling NSS ratio information
> as a part of service ready ext event using nss_ratio_enabled
> flag. Save this information in ath12k_pdev_cap to calculate
> NSS ratio.
>
> Additionally, reorder the code by moving
> ath12k_peer_assoc_h_phymode() before ath12k_peer_assoc_h_vht()
> to ensure that arg->peer_phymode correctly reflects the bandwidth
> in the max NSS calculation.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
[...]

Hello,

With this patch set we sometimes see the following warning shortly followed=
 by a
firmware crash on QCN9274 running WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1

[  242.416516] ------------[ cut here ]------------
[  242.423608] WARNING: CPU: 2 PID: 1427 at drivers/net/wireless/ath/ath12k=
/mac.c:3224 ath12k_peer_assoc_h_phymode+0xd4/0x800 [ath12k]
[  242.428475] Modules linked in: dvb_usb_af9035 dvb_usb_dib0700 dib0070 di=
b7000m dibx000_common at24 ath12k qmi_helpers nf_nat_sip nf_conntrack_sip d=
wc3_qcom nf_nat_pptp nf_conntrack_pptp ipq_lpass
[  242.444176] CPU: 2 UID: 0 PID: 1427 Comm: memcheck-arm64- Not tainted 6.=
13.0-02013-gd424b7b9a373-dirty #140
[  242.466407] Hardware name: XXX (DT)
[  242.476124] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  242.480639] pc : ath12k_peer_assoc_h_phymode+0xd4/0x800 [ath12k]
[  242.487584] lr : ath12k_peer_assoc_h_phymode+0x540/0x800 [ath12k]
[  242.493834] sp : ffffffc08588b4b0
[  242.499820] x29: ffffffc08588b4b0 x28: 0000000000000008 x27: ffffff80278=
1bb60
[  242.503123] x26: ffffff802cfa9af0 x25: ffffff802781bb60 x24: ffffff8016f=
38be0
[  242.510241] x23: ffffff802cfa9fb0 x22: ffffff802781bce0 x21: ffffff802d5=
0dc00
[  242.517360] x20: ffffff8016f38be0 x19: ffffff802781bce0 x18: fffffffffff=
fffff
[  242.524477] x17: 30363120726f6620 x16: 6f666e6920797469 x15: 6c696261706=
16320
[  242.531595] x14: 5948502054485620 x13: 0000000000000001 x12: 00000000000=
00060
[  242.538714] x11: ffffffc08126c6b0 x10: 0000000000000274 x9 : ffffffc0801=
0468c
[  242.545832] x8 : 00000000ffffdfff x7 : 00000000ffffe000 x6 : 00000000000=
00001
[  242.552949] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000000=
00000
[  242.560067] x2 : ffffff80bff6de70 x1 : ffffff80bff640c8 x0 : 00000000000=
00021
[  242.567186] Call trace:
[  242.574299]  ath12k_peer_assoc_h_phymode+0xd4/0x800 [ath12k] (P)
[  242.576560]  ath12k_peer_assoc_prepare+0x5d4/0x1608 [ath12k]
[  242.582809]  ath12k_mac_op_sta_state+0x1f4/0x1100 [ath12k]
[  242.588451]  drv_sta_state+0xa0/0x5e0
[  242.593745]  _sta_info_move_state+0x20c/0x4b8
[  242.597477]  sta_info_move_state+0x18/0x28
[  242.601817]  sta_apply_auth_flags.isra.0+0x190/0x1c0
[  242.605812]  sta_apply_parameters+0x240/0x5e0
[  242.610933]  ieee80211_change_station+0x164/0x200
[  242.615187]  nl80211_set_station+0x3bc/0x520
[  242.619874]  genl_family_rcv_msg_doit+0xbc/0x128
[  242.624215]  genl_rcv_msg+0x1c0/0x260
[  242.628815]  netlink_rcv_skb+0x40/0x100
[  242.632373]  genl_rcv+0x3c/0x60
[  242.636018]  netlink_unicast+0x2d8/0x338
[  242.639144]  netlink_sendmsg+0x158/0x398
[  242.643311]  ____sys_sendmsg+0x104/0x290
[  242.647217]  ___sys_sendmsg+0x70/0xa0
[  242.651123]  __sys_sendmsg+0x64/0xb0
[  242.654682]  __arm64_sys_sendmsg+0x28/0x38
[  242.658329]  do_el0_svc+0x70/0x100
[  242.662234]  el0_svc+0x18/0x60
[  242.665619]  el0t_64_sync_handler+0x104/0x130
[  242.668659]  el0t_64_sync+0x154/0x158
[  242.673086] ---[ end trace 0000000000000000 ]---

It's probably there since v1 of thies series but I just finally got to the
bottom of this now and I've tracked it down to the following hunk:

> @@ -2822,11 +2883,12 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_v=
ht(struct ath12k *ar,
>  						    struct ieee80211_link_sta *link_sta)
>  {
>  	if (link_sta->bandwidth =3D=3D IEEE80211_STA_RX_BW_160) {
> -		if (link_sta->vht_cap.cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ)
> +		if (link_sta->vht_cap.cap & (IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ =
|
> +		    IEEE80211_VHT_CAP_EXT_NSS_BW_MASK))
>  			return MODE_11AC_VHT160;
> =20
>  		/* not sure if this is a valid case? */
> -		return MODE_11AC_VHT160;
> +		return MODE_UNKNOWN;
>  	}
> =20
>  	if (link_sta->bandwidth =3D=3D IEEE80211_STA_RX_BW_80)

Which led me to understand that a sta that supports both VHT 160 and 80+80 =
ie
IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ will end up with a phy mo=
de
MODE_UNKNOWN send to the firmware. Which I guess is the reason of the crash=
.

I understand that VHT 80+80 is not supported by this chipset, but shouldn't=
 we
just allow the sta to connect using VHT 160 right ? Something like this may=
be ?

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/a=
th/ath12k/mac.c
index 048d62a48c88..d3a87af076e7 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3041,7 +3041,7 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_vht(s=
truct ath12k *ar,
 						    struct ieee80211_link_sta *link_sta)
 {
 	if (link_sta->bandwidth =3D=3D IEEE80211_STA_RX_BW_160) {
-		if (link_sta->vht_cap.cap & (IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
+		if (link_sta->vht_cap.cap & (IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK |
 		    IEEE80211_VHT_CAP_EXT_NSS_BW_MASK))
 			return MODE_11AC_VHT160;

