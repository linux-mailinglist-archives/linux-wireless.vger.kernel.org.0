Return-Path: <linux-wireless+bounces-32777-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AERHFctAr2mYSwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32777-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 22:51:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA21D241E36
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 22:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD38A3151E6E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 21:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD9F368955;
	Mon,  9 Mar 2026 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1pD3V8O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D2536C0DE
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 21:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773092960; cv=pass; b=hgI5QLrMXrcHcR7r3tAnPE72xPxAA+B9P3Y8NGOpaWzXRnU2UNIEoU8iTBW6SXwYJ2FxYlD+bA7o0cmZ7T8nlPNQHJ9uhCwz8lDwplBH2SuOzBqGjrrH0prtVM5zNvDtKrnDiNC5cU+j5ZTI9IbyNNDnfdJWlyEuBQsvXKZ3MTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773092960; c=relaxed/simple;
	bh=snBdrVV45X/SQB505tIEcg2DZ2TcsvSaN5ZbyhoylTU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=b5+tT+FfxLQt8DMvWLGYxE8p868MsCIlRELaQNWasSH6fDykfrUDPhSULOjf/weu3tplbPqFsm4UrglxU32QzP/fxCk46VlQUxzC7uyoL6ANYwK/yC0iX6UlJ0I0gCoYZ3Swp1Z87QccUnXs+XgyNZgpTb8qohYwe5Rf/dBiqkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1pD3V8O; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4042fe53946so2874747fac.3
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 14:49:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773092957; cv=none;
        d=google.com; s=arc-20240605;
        b=PZNZCkq18U0TKRZldhQs4T1vGuUF4yR5SdYQXOmFh6tNC8WL3gEeDfk/wKyfb0PxbR
         rdG+oKgDPMagYLIFLmwzrDYjETI7W5V4ePGzwcSW+QKCQ1VA/kOgedLyRgUIgMnw8wt+
         YojX5KdooLeM0xJ+Jc1pNG9slcced5y5Ijm428YTDlRRwA2dd1FNMCOkfgZVq33Sx4DX
         KDs39tS/YBvFlg4X/l7yBALS22mxqSM1B4WWcYGXNKC8KXSQv9YePyEYQ054LtzZ90UI
         V6vqj+qdrZLWZmpBO4z1bio4IJJePfsIxrYz3BzvUYWeBgZsvws/V3rbxkoSkev/klV0
         Iaaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=snBdrVV45X/SQB505tIEcg2DZ2TcsvSaN5ZbyhoylTU=;
        fh=d8BCnjGeZETb1Np0WGiM8FM4igktrpkOdn/+Hby5aCk=;
        b=cF7spoRwjOeCyDaNOUqcO6gzJxlaECAFNM5liMPphMinPMWGSQ+Blqkv9KPi62x9w6
         EJt9UoosTEEwRIX5xJg6jAUw5MVYgZTfhsTChCG7SZpYmstJCyapMkAXU60A1i2F28mS
         XGR8NkcKE3viU+nKdV/7t4po9O5t4I1DoyPA61xJ7V8l4Q8X6F+2jubtl4IR7n8mRNTv
         Qf8TX4CYIOOsJ30KvOLX0Qs0y/sBVWlutkplu+BJzolnfRrGtxrua+60ATA6OJnDrVEh
         9CE0JxhwWREOBMAmZWrqlsmS2apb4RDN2Y0srzazWRlbBiKPN5GMgOXRl3cWku87CD67
         BZPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773092957; x=1773697757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=snBdrVV45X/SQB505tIEcg2DZ2TcsvSaN5ZbyhoylTU=;
        b=P1pD3V8OQuckdbb/sv0ZjSrv8YZkfA3ENgt4pfigP1XIHkx3E6vfesLaFri+Y9fijr
         qj55QMzH/lji0aBqZA4rmtlwaLP2xwFs7C5a93c3ZwGjjZi1hPEo/mCnQu2of9SFq0DD
         RuGpxIieIEjlvoXRF4pF8nZG2lldh14tXHT7fOIWydcS2jB61sX9rkZzGmhknrc0B9A/
         QAWXu0jLiUxRGfZW34N8pGr62DStKMilOriKUlqrZO7oHrIPT+5UI1szgUvEBI3SkhAH
         16fKL8WCqjfgpcIB6ga8LGIzLR0KhExXgkxo+MRkfhQ3WczuL+Ihp7MXPuTcalcDtDkR
         zgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773092957; x=1773697757;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snBdrVV45X/SQB505tIEcg2DZ2TcsvSaN5ZbyhoylTU=;
        b=X+qL2zbTt1ExaW/HU3uxwZ3aKfpR1jSGDrokeP52Phm/BmszDT30gelXUJxsm9akQf
         JoJWXzsmeri3IQTbq++kxmzqzi0dGwL9C8gtLA8Hp8EpHvgywz4GHEGM1bnt+xo2L0BT
         RWqgc1kRWaAK/a16Fx5BpreF0glUZjOxEl3JtoP1I1RsaxgCXuVBa6yEAkekfLWIAcrR
         +Pd3WIVGd0YxmBTFuldUnlnpk3n4r37rVvyRoxAELa1ISb8JCKNL7mwQfp0DSM19VhVs
         LfJJezHX/IVMSIR5kUprypkln5qWEw2s3e5gC37Rrnt5UKVKDqRv1RT9RAizzapN3CmF
         hgUQ==
X-Gm-Message-State: AOJu0YywppsUE5NlEOQ4vZZQvL9y346/dqBv5RDNzP2ag79ntMBeBvml
	PaDqc6Aoaa427L1amy4zglmbsbK1bucWi32WIm91DcZOJzIrqxIHONKSQdpY8NNtIfj0YYe4Qw3
	VU3vfj/bmq1IaDuIPQ4Jea9LRcY2b+wverqobC2beGnvlGdw=
X-Gm-Gg: ATEYQzwYyv5xgI1Lx/t06ZE7YPUX5NL5aHHuAv5ypfnZf3g8yKKs8KGBVSWe2RKA8hL
	0d4vSj6pzvuxPdhMzI0Ml/UlTkFDp1oumTP6aAVyFqApP+7A+Af82LOVjIiRmt9uMYLXT2frouf
	68OVku108IqFHukSVNOqxKTPUielrmQcPgMvkCZqdr7dBM4lLmN6kVylVmLRWxgE30qg6/JxU1X
	YNRYJ5UVSkL4xgetk9D+2Lw3WDwYAHwHSNXrVWNdx2BWrQCTIKsrCiLD0GhalS7yNmLS87OJR9o
	q01PlHHW91WOt0Aza6GgBnkBa178btmtcFA=
X-Received: by 2002:a05:6871:2894:b0:40e:dadc:4a05 with SMTP id
 586e51a60fabf-416e3e8495cmr7542519fac.8.1773092956735; Mon, 09 Mar 2026
 14:49:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: LB F <goainwo@gmail.com>
Date: Mon, 9 Mar 2026 23:48:40 +0200
X-Gm-Features: AaiRm53ODi1ilOkfswM2O1JJXvOtIRlUAH6PUKNLP6FARCooUHedTa_7UF-6n4Q
Message-ID: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
Subject: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when power_save is
 enabled (LPS/ASPM conflict)
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: AA21D241E36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32777-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Ping-Ke,

I am writing to formally report a critical bug that causes a hard
system freeze on laptops equipped with the RTL8821CE WiFi module, and
to propose solutions.

Description:
On an HP laptop equipped with a Realtek RTL8821CE 802.11ac PCIe
adapter (PCI ID: 10ec:c821), the system experiences a hard lockup
(complete freeze of the UI and kernel, sysrq doesn't work, requires
holding the power button) when the WiFi adapter enters the power
saving state.

This issue occurs consistently across multiple Linux distributions and
kernel versions (reproduced on upstream kernel 6.13 and 6.19-rc).

Steps to Reproduce:
1. Use a system with RTL8821CE (pci:10ec:c821).
2. Ensure NetworkManager is configured with wifi.powersave = 3 (or
power saving is enabled via TLP/iw).
3. Connect to a WiFi network and let the system idle.
4. The system will eventually freeze completely.

Workarounds that successfully prevent the freeze:
* Passing disable_lps_deep=y to rtw88_core.
* Passing disable_aspm=y to rtw88_pci (or pcie_aspm=off).
* Disabling WiFi power save via NetworkManager.

Technical Analysis:
The root cause appears to be an unhandled race condition or hardware
bug between the adapter's Low Power State (LPS) Deep mode
(LPS_DEEP_MODE_LCLK) and the PCIe Active State Power Management (ASPM
L1) mechanism.

When the firmware drops into LPS_DEEP_MODE_LCLK concurrently with the
PCIe bus entering ASPM L1, the chip fails to handle PCIe Wake
signaling correctly. While there is an existing workaround in
rtw_pci_napi_poll (pci.c:1806) that sets `rtwpci->rx_no_aspm = true`
during NAPI poll for 8821CE, this polling wrapper is insufficient. The
deadlock often occurs during idle states when polling isn't actively
disabling ASPM, but the system suddenly needs to wake the radio.

Proposed Solutions:
Given that LPS_DEEP_MODE_LCLK seems fundamentally unreliable on 8821ce
PCIe variants when paired with standard Windows-era ASPM
implementations on laptops (HP, Lenovo, ASUS are all affected), the
most robust solution is to strip the unsupported deep sleep flag from
the hardware spec.

```diff
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1999,7 +1999,7 @@ struct rtw_chip_info rtw8821c_hw_spec = {
.bt_supported = true,
.fbtc_has_ext_ctrl = true,
.coex_info_hw_supported = true,
- .lps_deep_mode_supported = BIT(LPS_DEEP_MODE_LCLK),
+ .lps_deep_mode_supported = 0, /* Disabled due to ASPM L1 hard locks */
.dpk_supported = true,
.pstdma_type = COEX_PSTDMA_FORCE_LPSOFF,
.bfee_support = false,
```

Alternatively, a PCI Subsystem-based quirk should be introduced in
rtw_pci_aspm_set() to refuse ASPM BIT_L1_SW_EN transitions for
affected hardware IDs, similar to how CLKREQ issues are handled for
8822C via efuse->rfe_option.

Cross-Reference Analysis of other RTL8821CE Bugs:
After aggregating recent open bug reports for the 8821ce chip on
Bugzilla (https://bugzilla.kernel.org), it is apparent that almost all
of them are victims of the exact same underlying race condition.
1. Bug 215131: System freeze preceded by 'pci bus timeout, check dma
status'. Workaround used: disable_aspm=1.
2. Bug 219830: Log shows 'firmware failed to leave lps state' and
'failed to send h2c command'. A direct smoking gun for LPS Deep mode
freezing.
3. Bug 218697 & Bug 217491: Endless 'timed out to flush queue' floods.
4. Bug 217781 & Bug 216685: Random dropouts and low wireless speed.

Given the volume and age of these unresolved reports, disabling
.lps_deep_mode_supported (or restricting ASPM L1) specifically for
10ec:c821 is desperately needed.

System Information:
- Hardware: HP Notebook (SKU: P3S95EA#ACB, Family: 103C_5335KV)
- CPU: Intel Core i3-5005U
- WiFi PCI ID: 10ec:c821, Subsystem: 103c:831a
- Kernel: 6.13 / 6.19
- Driver module: rtw88_8821ce

I am happy to test any patches provided or formally submit the patch
above if maintainers agree it is the right approach. Thank you!

