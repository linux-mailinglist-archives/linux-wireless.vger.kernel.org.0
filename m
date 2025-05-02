Return-Path: <linux-wireless+bounces-22321-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07961AA6C70
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 10:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D94616AE92
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 08:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185E721FF36;
	Fri,  2 May 2025 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b="d/CZUXOS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972BF1F426C
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746173976; cv=none; b=jlCoCWwcRYdC4AoQLLHmDXcqkJ8rM+eLktehdK4k2pZQRnsMGxPp7a1QQftly1O8i+S5OuJoZ7gRwZwuBjisFzrow1c4xdlji0AWaJAC/e7lBmioiKVG7s80vgqUhgdxUD5qDAcD82TELAviShA2DNJ/GvlCywpBNtE2zziGkVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746173976; c=relaxed/simple;
	bh=8g4TbmNuMXF5jh9qs0mhhAAEIeRmD/ozVvtRr+WYpzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctj8YTvrXRpXPw9Ub0iqBbDOqK+mtuL4vRMsoy/L+vTLp/fiJObKEgkV4Cw6ruxP7o1xsrmWRXPmCWfFHLYN5OcRm9RUVDxakAHkMWnC8Ra7sQreEfiLvdiTNnPjoMwdzkWO0jXoQwzSVZ50RAfR9y1LiODMCvv+/i6BIZKNJgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech; spf=pass smtp.mailfrom=moment.tech; dkim=pass (2048-bit key) header.d=moment-tech.20230601.gappssmtp.com header.i=@moment-tech.20230601.gappssmtp.com header.b=d/CZUXOS; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moment.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moment.tech
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5241abb9761so523985e0c.1
        for <linux-wireless@vger.kernel.org>; Fri, 02 May 2025 01:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=moment-tech.20230601.gappssmtp.com; s=20230601; t=1746173971; x=1746778771; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=84CrWQUO3MnFFPefMzxpDlQeyVctJsJF0WYn/k9T0Jc=;
        b=d/CZUXOSpre82vLBdEfRtB8PD5lN5dU2UfVV2sU2nBo1WZJ23K/a2FPhStPoYWNNGE
         ookzjFfrpXQyd6OKyTUrKrtYzdBOwium+YOPaTRMeT02zpFgeNGA7bQrVtyxxFl0a1s/
         3U6aBe2s8fOaJuT0EiJtwfGahFNtFE6+p2v2c+Qgy3WvIJ6i/BeizZxZ5D06Ch9SLJeZ
         UADo4SoZuXZwqvniwcgJS34aDOKzh9swR2Fqjz/EhpcBJgRwH+wnNtrVLeXeQyqviWKd
         xkSiBO1rRa5cogH82jS9kEQy1lfSADX7dkGUNO8meUTwotKZlOCJsT23fEojHipUe3Hc
         Bv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746173971; x=1746778771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84CrWQUO3MnFFPefMzxpDlQeyVctJsJF0WYn/k9T0Jc=;
        b=rZW9eywAsJFTlQnNw76J2oerLL3/zO8VAb7OxZMWBC2RxSglDpajmnbLUyrJ/hsJxm
         n3va+we8Xe/szcGP0rETuvJf8/m4YPO4BrDcTLtHEm5okgvnWxstyGf3/8kFuHPZAhp1
         sR4G1uRMc459iyhZAsnAWGuTsO/8QoVQFevtEE8LKASBumC2V0oQdFDyqxzYltfvfunj
         IqsJg1ohcK3HXKNdit7jgjS9oHEeU+USuXz/BR3ogwK7aV2L6rMjTZHQl0j/mrgxc5dK
         d++TmTVpAIXzhHrIgWFdCL7Ifqr0ESH10MgiQYwH+rc+a+QetxtoafXK7HuN7joNKjds
         vVpg==
X-Forwarded-Encrypted: i=1; AJvYcCWt3swrKP4xWB8jFwV7oqFRfgaWJfWSWDSRVJ76C4AvYKVOOIquZ0exNVc96oYobCkjURyR1Urw/XVIraSUlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRhm1Xe5E37V2deKL339PgU/L9/NrdmisFlB9RKpejJUCY2V6u
	a1b7dSBRrBHtYaYWYTvQ9WJAT3yhjnpzAhbmbPv3W5tZ2lvd1vQt9sRQTbFolg04t2ZdInN/UTA
	0WrrcSwOEUpuod70jbMR+nxDj27qJ5Rxjsj8dIxIcpzOZs793qQrHyw==
X-Gm-Gg: ASbGnctODCnOJniOGJ75svYTLTr0L8GxtdO2GMjWtdSxvoiPAJksutp+RetEUw+5mkd
	z6fbP2+jB8Jd1mYycCAwurdrjYa/ufP3jE8LcxckkvMpk2nsjvvCdI8+1pTLYoc9anWdB/hsh8f
	PGOnu729oHFXuguuY2PcxhyXo=
X-Google-Smtp-Source: AGHT+IHxsA6UkxMOVUH65tG13GkZAPDMxSJgtyY4IzL6w+Y4D8uNT7W+U7Dgze8ywmQoBbZnpmnrL/sRVsMfSWUhbYE=
X-Received: by 2002:a05:6122:82a7:b0:520:61ee:c814 with SMTP id
 71dfb90a1353d-52aed675ebdmr976892e0c.1.1746173971118; Fri, 02 May 2025
 01:19:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416100939.282481-1-balsam.chihi@moment.tech>
 <0e129e2a-67fc-48cc-9773-efbea3f7391d@quicinc.com> <fa16bad6-305f-77c1-3f56-703564e2dfee@quicinc.com>
 <CAONkfw6m9O_6FZHBrPYdpv+=AxSgsbh1T7+GaS+U+bnjyVVJvQ@mail.gmail.com>
 <3da5d47b-993c-405e-841f-1d16d8715610@quicinc.com> <1d0682c0-ee5d-f2d4-199d-4ebc4e71f9ef@quicinc.com>
 <3660fcfb-be29-422b-a352-3996ad3fc41f@quicinc.com> <CAONkfw5-bfYRwHZ9iHhgJP2f8Zqyz5SZVbdL4n9EPhKU+=ONPg@mail.gmail.com>
 <CAONkfw7xjJjMAZSfHg5avEV=Bc5aJZqrRxMDvKWK4g14bLNjRQ@mail.gmail.com>
 <d4b01807-0770-439a-a77b-1e0f078687e3@quicinc.com> <07013bbc-296a-2403-a6ca-70de220495c5@quicinc.com>
 <fd6c118b-90ea-4d11-13d0-d8f49f9325e3@quicinc.com> <CAONkfw7z3QZORCMxOJAnzF0bLNmsZKfV3rOYEhStAK628dpq+g@mail.gmail.com>
 <15edfacb-4eeb-bc3f-72cd-4b7744c9da13@quicinc.com>
In-Reply-To: <15edfacb-4eeb-bc3f-72cd-4b7744c9da13@quicinc.com>
From: Balsam Chihi <balsam.chihi@moment.tech>
Date: Fri, 2 May 2025 10:18:54 +0200
X-Gm-Features: ATxdqUF4R3CpScbdGnvNfMuGve0rFItJnL4807hw3x4RQybCmb1AmtLCdqx_x3Y
Message-ID: <CAONkfw5=Ze5TrGf1ZYrgDsWhGzOrK8oj4vPGf=xL9UDuLTYx6g@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath11k: pci: Fix msi_irq crash on driver unload
 with QCN9074 PCIe WiFi 6 modules
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>, jjohnson@kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

I had to skip all "ath11k_pcic_read32()" calls to avoid the kernel crash.
When booting and loading the driver the  "ath11k_pcic_read32()" does
not cause any issues, only when unloading, rebooting and poweroff the
problem appears.
I will send the boot and reboot logs as soon as possible (probably
monday, when i get my hands on the target device).
and this is the diff that worked for me, that replaces the initial patch :

--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -201,16 +201,18 @@ static void ath11k_pci_soc_global_reset(
  ath11k_warn(ab, "link down error during global reset\n");
 }

-static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab)
+static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab,
bool power_on)
 {
- u32 val;
+ if (power_on) {
+ u32 val;

- /* read cookie */
- val = ath11k_pcic_read32(ab, PCIE_Q6_COOKIE_ADDR);
- ath11k_dbg(ab, ATH11K_DBG_PCI, "pcie_q6_cookie_addr 0x%x\n", val);
+ /* read cookie */
+ val = ath11k_pcic_read32(ab, PCIE_Q6_COOKIE_ADDR);
+ ath11k_dbg(ab, ATH11K_DBG_PCI, "pcie_q6_cookie_addr 0x%x\n", val);

- val = ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
- ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", val);
+ val = ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
+ ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", val);
+ }

  /* TODO: exact time to sleep is uncertain */
  mdelay(10);
@@ -221,14 +223,18 @@ static void ath11k_pci_clear_dbg_registe
  ath11k_pcic_write32(ab, WLAON_WARM_SW_ENTRY, 0);
  mdelay(10);

- val = ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
- ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", val);
+ if (power_on) {
+ u32 val;

- /* A read clear register. clear the register to prevent
- * Q6 from entering wrong code path.
- */
- val = ath11k_pcic_read32(ab, WLAON_SOC_RESET_CAUSE_REG);
- ath11k_dbg(ab, ATH11K_DBG_PCI, "soc reset cause %d\n", val);
+ val = ath11k_pcic_read32(ab, WLAON_WARM_SW_ENTRY);
+ ath11k_dbg(ab, ATH11K_DBG_PCI, "wlaon_warm_sw_entry 0x%x\n", val);
+
+ /* A read clear register. clear the register to prevent
+ * Q6 from entering wrong code path.
+ */
+ val = ath11k_pcic_read32(ab, WLAON_SOC_RESET_CAUSE_REG);
+ ath11k_dbg(ab, ATH11K_DBG_PCI, "soc reset cause %d\n", val);
+ }
 }

 static int ath11k_pci_set_link_reg(struct ath11k_base *ab,
@@ -366,7 +372,7 @@ static void ath11k_pci_sw_reset(struct a
  }

  ath11k_mhi_clear_vector(ab);
- ath11k_pci_clear_dbg_registers(ab);
+ ath11k_pci_clear_dbg_registers(ab, power_on);
  ath11k_pci_soc_global_reset(ab);
  ath11k_mhi_set_mhictrl_reset(ab);
 }

