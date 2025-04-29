Return-Path: <linux-wireless+bounces-22201-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86418AA10E7
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 17:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E172A1BA2362
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 15:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191B823DE80;
	Tue, 29 Apr 2025 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiTZd18j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6D823D2A3
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941684; cv=none; b=hIB9VDnOnyAhzZQfdg1kKDVrLqVAXyUTFdU8Oyq2gtS2HsQ45L8EZd5TUgPeHwz5hKVIxG/Co8CURxa8/SsJFBP2jr/67+KJNlv7e86kcEhEJBs0rUyNgzvG4UCjjj/EwpZAPqfQJlJUjoSZvYtB+3vLk4u608Wjq3Z3EzMW3pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941684; c=relaxed/simple;
	bh=K85QFtLIjck/gX3IFcEjM53AOM/CBweK5gB7emPaJNM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=R2+5QtCBK563kLaJXOe25YfcF8lj7r6LXFtAiwsT1JFAtjNfzT/XEUJBd38fQM7T1Qvqmn47duvYz7CRDZ+hkJxK/t8JMxZIngdQ0/y+DvuOv8sX//biQjjCb2oWK0CPBIUcDaEt/5tf5Ad2ZAQpCJbyPuaGwlHWK/htMHb5Ios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiTZd18j; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30effbfaf61so70271931fa.0
        for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 08:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745941680; x=1746546480; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJ2Uu4wviK+ET+a1Q/3hHUMgJ+PVwDch+yPdKu89LDM=;
        b=iiTZd18j5Hb/y7n38dRzf1m6nhzGVFJRnJ58WLBFZnQhveA5U5/Y6MsLDf9d2CGMFD
         cMXbuM6saTY66137F6prSuqTQGYmbMdHXY/j+GQ6FgCIxX2/GjZZKj+efdg94GcJyXkI
         f8oG1QwFiLaqRyfdahLv5SFE+E0/OqnNJQwMEUc1PvcfvlcF/IPGK64o5EFnD6F3nLWn
         PHM3TGWHntV1WjJE+t2yQWO+7/pWSKoVO6bPAx6PNu9cFWw4Kb3l2toFu3cR6Oek6z4+
         4SbxozB0ToOUCPtm1ahn/6myGUfZVJVb8z98FclCaB5a8ikOeMs7JSKY7sqa5m/LQHW+
         Drkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745941680; x=1746546480;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RJ2Uu4wviK+ET+a1Q/3hHUMgJ+PVwDch+yPdKu89LDM=;
        b=teuoFUMJd0Hp1H43MkKsOECJLQj7LlY9Wi5NMzMUM8dmSY9aEGnO62drQc8qpibBex
         ZJpQWw4D9q1xnV/XY4Kj4/zrXWPsqo60C3PTQWzSVWoN2j7MIzDBupq34ZBjgzIbe3oR
         U6k+Jx/ZDyhQqjsy+Hywjur8KtwMWnkwUBxcZ5LUFsaj4UCArmHkLgMjkGBt7WUm/pLg
         4bZFaQ1KUeayJURAMsB3/AiYpZQHXLz2WPq3oIVLaR8U14WIKa+mWv7xjfY7LGvlIGCq
         uTZgHZZP1CAnCyQUqOXaBSu3mSU5y2B8hxdpK8cRehuBeoMK5X/Wb40fAKKyK8v0iQEy
         xTMw==
X-Gm-Message-State: AOJu0YxRuUHp7l6wTqCg45I2kochtihpz1VlqCXzMSgV/JLYAwFuRrlh
	kXEMglfoxqGDlrF7iGOnWuo/IMHqqek6kxisP4QAoxy0rtql/o6Q
X-Gm-Gg: ASbGncv/nxxxPmQaxz828w077yW2tMZF+A7XlDou0FTEZODFl/xPU/i16YRzAZW/l1S
	du+QKirQ53EbSmFeoJZqmpodm1nBYDn5ugg2MgxRhuaqGLVEU+Au+GVHJzbaQ5im7x4sXYDfFe9
	OJukqef1/Id4pyBoyygrJjxIlDRKsr0Gq4huLQIjQxDanFnl+/Lqq6cKDK4bu2MsPv3qC6rG0ty
	MwyfuKKbTu574uv5bV4aFkpbiJ6MKUz4sV1L6+4ZWYx9h8BVy4KLk5W7/RKp6jHofvAqHIWlhzV
	KO+bdwXIJYL/8Bem2CCJxtcRaSmdIk7JpZzMRbyfrI6IkYOzY6Pv/GT6j1U=
X-Google-Smtp-Source: AGHT+IH9b85HibhvPJXHR+VJVotRVVPQyUVww3aNhG6Xb5/qwDd3JtHBnySrsUnnvkQRO8EKycfQHQ==
X-Received: by 2002:a2e:a553:0:b0:30b:c328:3cdc with SMTP id 38308e7fff4ca-31d45a3ce50mr17371591fa.2.1745941680000;
        Tue, 29 Apr 2025 08:48:00 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-317cf659b1esm24819241fa.20.2025.04.29.08.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 08:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Apr 2025 17:47:58 +0200
Message-Id: <D9J8O65N947J.Y0LSNAOS0AYG@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH ath-next] wifi: ath12k: allow beacon protection keys to
 be installed in hardware
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Karthikeyan Kathirvel" <karthikeyan.kathirvel@oss.qualcomm.com>,
 <ath12k@lists.infradead.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250421114711.3660911-1-karthikeyan.kathirvel@oss.qualcomm.com>
In-Reply-To: <20250421114711.3660911-1-karthikeyan.kathirvel@oss.qualcomm.com>

On Mon Apr 21, 2025 at 1:47 PM CEST, Karthikeyan Kathirvel wrote:
> Install beacon protection keys in hardware for AP modes only if hardware
> supports it, as indicated by the WMI service bit
> WMI_TLV_SERVICE_BEACON_PROTECTION_SUPPORT. Allow keyidx up to 7, since
> beacon protection uses keyidx 6 and 7.
>
> Control this feature by setting bit 0 of feature_enable_bitmap when sendi=
ng
> the WMI_BCN_TMPL_CMDID command to firmware.
>
> Check for the beacon protection enabled bit in both tx and non-tx profile=
s
> for MBSSID cases. If set in either profile, enable the beacon protection
> feature in firmware for transmitted vif.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.=
com>
[...]
> @@ -4964,14 +4994,6 @@ static int ath12k_mac_op_set_key(struct ieee80211_=
hw *hw, enum set_key_cmd cmd,
> =20
>  	lockdep_assert_wiphy(hw->wiphy);
> =20
> -	/* BIP needs to be done in software */
> -	if (key->cipher =3D=3D WLAN_CIPHER_SUITE_AES_CMAC ||
> -	    key->cipher =3D=3D WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
> -	    key->cipher =3D=3D WLAN_CIPHER_SUITE_BIP_GMAC_256 ||
> -	    key->cipher =3D=3D WLAN_CIPHER_SUITE_BIP_CMAC_256) {
> -		return 1;
> -	}
> -
>  	if (key->keyidx > WMI_MAX_KEY_INDEX)
>  		return -ENOSPC;
> =20

This hunk seems to break station mode on QCN9274. Maybe on WCN7850 too ? I =
see
that it was not tested against that HW.

With that hunk I cannot receive broadcast trafic sent by the ap anymore.
Generated by a simple "arping -b X.X.X.X -I br0" in my case.

Replacing that hunk with something similar as what is done in CLO [0] seems=
 to
fix the issue:

@@ -5575,13 +5605,9 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw=
 *hw, enum set_key_cmd cmd,
=20
 	lockdep_assert_wiphy(hw->wiphy);
=20
-	/* BIP needs to be done in software */
-	if (key->cipher =3D=3D WLAN_CIPHER_SUITE_AES_CMAC ||
-	    key->cipher =3D=3D WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
-	    key->cipher =3D=3D WLAN_CIPHER_SUITE_BIP_GMAC_256 ||
-	    key->cipher =3D=3D WLAN_CIPHER_SUITE_BIP_CMAC_256) {
+	/* IGTK needs to be done in host software */
+	if (key->keyidx =3D=3D 4 || key->keyidx =3D=3D 5)
 		return 1;
-	}
=20
 	if (key->keyidx > WMI_MAX_KEY_INDEX)
 		return -ENOSPC;


PS: I tested that with firmware PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ=
-1

[0] https://git.codelinaro.org/clo/qsdk/oss/system/feeds/wlan-open/-/blob/w=
in.wlan_host_opensource.3.0/patches/ath12k/726-ath12k-add-beacon-protection=
-support-for-ath12k.patch?ref_type=3Dheads

