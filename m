Return-Path: <linux-wireless+bounces-21606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7836FA90BF8
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 21:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36EE07AD3D0
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 19:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382782236F4;
	Wed, 16 Apr 2025 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b="bJQPjaEh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330C32045B7
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 19:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.84.6.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744830665; cv=none; b=qoe74uxCwlnmHYr56kVp0CygG2A3JrjJZYisnnT1u89LwodH9zPJRBv3/ShaoMFPKYR3poor5nDHTbm7zzbM2diRwnm/Ku42OsJYUjxxjioXLzkb3XsrduPmxLNo1pG78j51ZClcq87y3QgaMxEKPfQrIQnnlc05OnoSiOOCfXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744830665; c=relaxed/simple;
	bh=eH3Bn53YiyGLDnAZwdKK8XPlFtceUS61pLnGtW6Lmvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OP1MbyC3xQCjOJ1/3ZQyDD5DYiggiYSx4Gpb3cCdG7XkUJ0SPHwvRrJWS5j0NgV3E6esb6GMlgYbiymJ0ZMlpupudPkTpH7YDC6nPHa9ipG2S71wa/OWWzXlrTXnFzFVqRvR2124wLxZ1FyLuBeHFqj/XS0MyRAcLPh+LPzwjaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com; spf=pass smtp.mailfrom=dd-wrt.com; dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b=bJQPjaEh; arc=none smtp.client-ip=185.84.6.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dd-wrt.com
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:59630 helo=webmail.newmedia-net.de)
	by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.97.1)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1u587K-000000004Xa-0AeI;
	Wed, 16 Apr 2025 21:08:14 +0200
X-SASI-Hits: BODY_SIZE_10000_PLUS 0.000000, CTE_8BIT 0.000000,
	DKIM_ALIGNS 0.000000, DKIM_SIGNATURE 0.000000, HTML_00_01 0.050000,
	HTML_00_10 0.050000, IN_REP_TO 0.000000, LEGITIMATE_SIGNS 0.000000,
	MSGID_SAMEAS_FROM_HEX_844412 0.100000, MSG_THREAD 0.000000,
	NO_CTA_URI_FOUND 0.000000, NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000,
	OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000, REFERENCES 0.000000,
	SENDER_NO_AUTH 0.000000, SUSP_DH_NEG 0.000000, USER_AGENT 0.000000,
	__ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000,
	__BOUNCE_CHALLENGE_SUBJ 0.000000, __BOUNCE_NDR_SUBJ_EXEMPT 0.000000,
	__BULK_NEGATE 0.000000, __COURIER_PHRASE 0.000000,
	__CRYPTO_ADDRESS_OBFU 0.000000, __CT 0.000000, __CTE 0.000000,
	__CT_TEXT_PLAIN 0.000000, __DKIM_ALIGNS_1 0.000000, __DKIM_ALIGNS_2 0.000000,
	__DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
	__FORWARDED_MSG 0.000000, __FRAUD_MONEY_BIG_COIN 0.000000,
	__FRAUD_MONEY_BIG_COIN_DIG 0.000000, __FROM_DOMAIN_NOT_IN_BODY 0.000000,
	__FROM_NAME_NOT_IN_BODY 0.000000, __FUR_RDNS_SOPHOS 0.000000,
	__HAS_FROM 0.000000, __HAS_MSGID 0.000000, __HAS_REFERENCES 0.000000,
	__HEADER_ORDER_FROM 0.000000, __HIGHBITS 0.000000, __IN_REP_TO 0.000000,
	__MAIL_CHAIN 0.000000, __MIME_BOUND_CHARSET 0.000000,
	__MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000,
	__MIME_VERSION 0.000000, __MOZILLA_USER_AGENT 0.000000,
	__MSGID_HEX_844412 0.000000, __MULTIPLE_RCPTS_TO_X2 0.000000,
	__NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS_FUR 0.000000,
	__OUTBOUND_SOPHOS_FUR_IP 0.000000, __OUTBOUND_SOPHOS_FUR_RDNS 0.000000,
	__RCVD_PASS 0.000000, __REFERENCES 0.000000, __SANE_MSGID 0.000000,
	__SCAN_D_NEG 0.000000, __SCAN_D_NEG2 0.000000, __SCAN_D_NEG_HEUR 0.000000,
	__SCAN_D_NEG_HEUR2 0.000000, __SUBJ_ALPHA_END 0.000000,
	__SUBJ_ALPHA_NEGATE 0.000000, __SUBJ_REPLY 0.000000,
	__TO_MALFORMED_2 0.000000, __TO_NAME 0.000000,
	__TO_NAME_DIFF_FROM_ACC 0.000000, __TO_REAL_NAMES 0.000000,
	__URI_NO_MAILTO 0.000000, __URI_NO_WWW 0.000000, __USER_AGENT 0.000000,
	__X_MAILSCANNER 0.000000
X-SASI-Probability: 8%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2025.4.16.181228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID; bh=i8LnURJpuRJzxMjS+qlDwzuPuzUglcE9ImEiNHlCOaA=;
	b=bJQPjaEhfP5WhCfjh5SGonb7vETvGp50Q8OvSqhX89zRdZnOvgD0c5cbaz5kmpDsC18/EQxJXvokvclYZVZ40zbtmNh0L73yJL3RcKr6zc/97OnT1TVrRZ3pki2KjYiQtmV8TyBR/uE7dYnKMcvLS9L6hHJJU6Zwt5gqSwwb0Y4=;
Message-ID: <32bdd5b2-cfee-4d49-9df1-b92b9c71ddcd@dd-wrt.com>
Date: Wed, 16 Apr 2025 21:08:09 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: RFC: Proposed modularization of ath12k
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <4a17d730-ede8-463e-98d8-9b0291d0ca45@oss.qualcomm.com>
From: Sebastian Gottschall <s.gottschall@dd-wrt.com>
In-Reply-To: <4a17d730-ede8-463e-98d8-9b0291d0ca45@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass (webmail.newmedia-net.de: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=s.gottschall@dd-wrt.com; helo=webmail.newmedia-net.de;
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: s.gottschall@dd-wrt.com
X-SA-Exim-Scanned: No (on webmail.newmedia-net.de); SAEximRunCond expanded to false
X-NMN-MailScanner-Information: Please contact the ISP for more information
X-NMN-MailScanner-ID: 1u587I-00027H-IZ
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: s.gottschall@dd-wrt.com
X-Received:  from localhost ([127.0.0.1] helo=webmail.newmedia-net.de)
	by webmail.newmedia-net.de with esmtp (Exim 4.72)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1u587I-00027H-IZ; Wed, 16 Apr 2025 21:08:12 +0200

why not do it for all the drivers. ath10k, 11k and 12k. alot of code can 
be shared.

Am 16.04.2025 um 17:15 schrieb Jeff Johnson:
> BACKGROUND
>
> Historically, for each generation of Qualcomm Atheros Wi-Fi chipset, there has
> been a separate driver, the most recent being ath10k for 802.11ac (Wi-Fi 5),
> ath11k for 802.11ax (Wi-Fi 6/6E), and ath12k for 802.11be (Wi-Fi 7). But there
> is common functionality and code across these drivers due to firmware and
> hardware architecture leverage across generations.
>
> In the existing development model, code leverage is achieved via code
> duplication. When a new driver is created from the prior driver, it is first
> stripped down to basic features to allow for easier public review, and then,
> over time, features are added back to bring the new driver up to parity with
> the previous generation driver. So there is a period where existing
> functionality in the previous driver is not present in the new driver. In
> addition, introduction of new functionality requires porting across the
> different generations of drivers.
>
> We are now looking ahead at how to support 802.11bn (Wi-Fi 8). And within
> Qualcomm there is consensus that the old way is not the best way forward.
> Therefore we are seeking feedback on the following.
>
> PROPOSAL
>
> For better leverage, refactor ath12k into common and generation-specific
> modules. The common module will contain the logic that is shared across
> multiple architectures, and the generation-specific modules will contain the
> logic that is specific for that generation (and specific to the chipsets
> supporting that generation). Hence there will be one driver that supports
> Wi-Fi 7, Wi-Fi 8, and hopefully all future generations of Wi-Fi. Previous
> drivers (ath11k, ath10k, etc) are unchanged.
>
> Firmware interface, core initialization and de-initialization sequences are
> usually common across different device families. Hardware register
> definitions, Copy engine mappings, MHI config, WMI resource config and
> hardware abstractions are usually generation-specific.
>
> Common components includes following
>        mac80211 interface: Control path ops are mostly common across different
>        generations. Handlers will be shared as much as possible.
>
>        Firmware interface (WMI, HTT, HTC, QMI): Firmware interfacing messages
>        and sequence is common and kept backward/forward compatible using TLVs.
>
>        Common Datapath flow: Buffer replenish, Processing of RAW packets,
>        delivering frames to mac80211 and similar common path not dependent on
>        hardware TLVs and registers.
>
>        core init sequences, reset sequence & recovery sequence in shared code.
>
> Generation specific code includes.
>        Some mac80211 handlers that are very close to device like tx will be
>        moved to generation specific components.
>
>        Hardware configs: Hardware capabilities, configs, MHI configuration, WMI
>        resource configuration, HAL and other architecture specific code.
>
>        Data path flow: specific to hardware and TLV integrations like,
>        processing of RX and TX flow that involves hardware register and TLV
>        interactions.
>
> It is proposed that ath12k.ko will be the common module. It is proposed that
> ath12k_wifi7.ko will be the generation-specific module for Wi-Fi 7 devices.
>
> The current ath12k.ko will be refactored as depicted below.
>
>                                          +-----------------+
>                                          |                 |
>                                          |   ath12k.ko     |
>                                          |    (common)     |
>        +---------------+                 |                 |
>        |               |                 +-----------------+
>        |   ath12k.ko   | ===========>
>        |               |                 +------------------+
>        +---------------+                 |                  |
>                                          | ath12k_wifi7.ko  |
>                                          | (wifi7 family)   |
>                                          |                  |
>                                          +------------------+
>
> Going forward, wifi8 can be added as a new module including all device
> specific code and new common functionalities will be added in common ath12k.ko
> that can be leveraged. It will look something like below
>
>                      +-----------------+
>                      |                 |
>                      |   ath12k.ko     |
>                      |    (common)     |
>                      |                 |
>                      +-----------------+
>
>      +------------------+           +------------------+
>      |                  |           |                  |
>      | ath12k_wifi7.ko  |           | ath12k_wifi8.ko  |
>      | (wifi7 family)   |           | (wifi8 family)   |
>      |                  |           |                  |
>      +------------------+           +------------------+
>
>
> Proposed directory structure
> Existing                            New
> .                                   .
> ├── acpi.c                          ├── acpi.c
> ├── acpi.h                          ├── acpi.h
> ├── ce.c                            ├── ce.c
> ├── ce.h                            ├── ce.h
> ├── core.c                          ├── core.c
> ├── coredump.c                      ├── coredump.c
> ├── coredump.h                      ├── coredump.h
> ├── core.h                          ├── core.h
> ├── dbring.c                        ├── dbring.c
> ├── dbring.h                        ├── dbring.h
> ├── debug.c                         ├── debug.c
> ├── debugfs.c                       ├── debugfs.c
> ├── debugfs.h                       ├── debugfs.h
> ├── debugfs_htt_stats.c             ├── debugfs_htt_stats.c
> ├── debugfs_htt_stats.h             ├── debugfs_htt_stats.h
> ├── debugfs_sta.c                   ├── debugfs_sta.c
> ├── debugfs_sta.h                   ├── debugfs_sta.h
> ├── debug.h                         ├── debug.h
> ├── dp.c                            ├── dp.c
> ├── dp.h                            ├── dp_cmn.h
> ├── dp_mon.c                        ├── dp.h
> ├── dp_mon.h                        ├── dp_htt.c
> ├── dp_rx.c                         ├── dp_htt.h
> ├── dp_rx.h                         ├── dp_mon.c
> ├── dp_tx.c                         ├── dp_mon.h
> ├── dp_tx.h                         ├── dp_peer.c
> ├── fw.c                            ├── dp_peer.h
> ├── fw.h                            ├── dp_rx.c
> ├── hal.c                           ├── dp_rx.h
> ├── hal_desc.h                      ├── dp_tx.c
> ├── hal.h                           ├── dp_tx.h
> ├── hal_rx.c                        ├── fw.c
> ├── hal_rx.h                        ├── fw.h
> ├── hal_tx.c                        ├── hal.c
> ├── hal_tx.h                        ├── hal.h
> ├── hif.h                           ├── hif.h
> ├── htc.c                           ├── htc.c
> ├── htc.h                           ├── htc.h
> ├── hw.c                            ├── hw.h
> ├── hw.h                            ├── Kconfig
> ├── Kconfig                         ├── mac.c
> ├── mac.c                           ├── mac.h
> ├── mac.h                           ├── Makefile
> ├── Makefile                        ├── mhi.c
> ├── mhi.c                           ├── mhi.h
> ├── mhi.h                           ├── p2p.c
> ├── p2p.c                           ├── p2p.h
> ├── p2p.h                           ├── pci.c
> ├── pci.c                           ├── pci.h
> ├── pci.h                           ├── peer.c
> ├── peer.c                          ├── peer.h
> ├── peer.h                          ├── qmi.c
> ├── qmi.c                           ├── qmi.h
> ├── qmi.h                           ├── reg.c
> ├── reg.c                           ├── reg.h
> ├── reg.h                           ├── testmode.c
> ├── rx_desc.h                       ├── testmode.h
> ├── testmode.c                      ├── trace.c
> ├── testmode.h                      ├── trace.h
> ├── trace.c                         ├── wmi.c
> ├── trace.h                         ├── wmi.h
> ├── wmi.c                           ├── wow.c
> ├── wmi.h                           ├── wow.h
> ├── wow.c                           +── wifi7
> +── wow.h                               ├── dp.c
>                                          ├── dp.h
>                                          ├── dp_rx.c
>                                          ├── dp_rx.h
>                                          ├── dp_tx.c
>                                          ├── dp_tx.h
>                                          ├── hal.c
>                                          ├── hal_desc.h
>                                          ├── hal.h
>                                          ├── hal_qcn9274.c
>                                          ├── hal_qcn9274.h
>                                          ├── hal_rx.c
>                                          ├── hal_rx_desc.h
>                                          ├── hal_rx.h
>                                          ├── hal_tx.c
>                                          ├── hal_tx.h
>                                          ├── hal_wcn7850.c
>                                          ├── hal_wcn7850.h
>                                          ├── hw.c
>                                          ├── hw.h
>                                          ├── Makefile
>                                          ├── mhi.c
>                                          ├── pci.c
>                                          ├── wmi.c
>                                          └── wmi.h
>
> A proof-of-concept is already being developed in parallel with the current
> ath12k development in the ath12k-ng (Next Generation) branch in our public
> ath.git. In order to not interfere with the review of current ath12k
> development, we will not be posting ath12k-ng patches on the mailing lists.
> However, it will be easy to tell when new patches have been pushed to the
> branch since the Intel 0-DAY CI Kernel Test Service will run on this branch
> and publish the test result to the ath12k list.
>
> Public branch:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/log/?h=ath12k-ng
>
> First Intel 0-DAY build result:
> https://lore.kernel.org/all/202503300031.2IK6j4IS-lkp@intel.com/
>
> Public comment on this proposal are welcomed.
>
> /jeff
>
>

