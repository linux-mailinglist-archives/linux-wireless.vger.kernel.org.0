Return-Path: <linux-wireless+bounces-27408-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F01B800CE
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 16:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 302077B869C
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2242BE656;
	Tue, 16 Sep 2025 22:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="ZJJk3E3X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC3E29B78D
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061838; cv=none; b=A7dEzDC+YASzzgIwekYZ8d+BqpIpqVcssOY1GhkHmwAE+vu9AOJ1uDfST5PFVEZMAVJauOJ1W0/R8eKMn3fGAl7b38Q9VR+KC9P/ZjqF6Flst2t4kiYbHxhlXbYm8vQhL8SwFK+Z/4LHEJWpiLKU/WFz9tdm/iEN8pyb1lfDo9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061838; c=relaxed/simple;
	bh=KNydB3l/aFHw0bXFk+iP8aXVnrvUwNkUt4M6Q+s+eD8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uxpg6aAfNa7C7TO4C3MstzoKb31TxBvgpYJyqu1pInDbWNGifZ+uDBOdDdow14xODDNeRXfKReNAXNwsRbwVbKqArAYZhI9/TZIHmDHhhL3DPYNgGOVpPv9PeUYfvRzQPWKN0DdwAmkJRZnXKjT/20xOnHdt7QSYGvC8afwmrms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=ZJJk3E3X; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061836; x=1789597836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KNydB3l/aFHw0bXFk+iP8aXVnrvUwNkUt4M6Q+s+eD8=;
  b=ZJJk3E3X7NgFV8nIrctASe27owWLTzfQhMsE11tHiIvNlkcwXPjAiJkM
   bWN27Hcy6GDpE3loiXAJRXxOqacxdCpQAPIhKorMNJ5Qj6zEm8SCqPKAJ
   MJEepOmYwPs+fqiCzF+XPGmbIgIWEUIcYSawVh+xkmRXS94SHZk0oeMsU
   k=;
X-CSE-ConnectionGUID: S9cYkMuGR5CXZBBp//muBg==
X-CSE-MsgGUID: Lwom9P2xS8OYCN0xLDOzaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="64784020"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="64784020"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:30:34 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:30:33 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:30:30 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 53/57] wifi: inffmac: add chipcommon.h
Date: Wed, 17 Sep 2025 03:48:13 +0530
Message-ID: <20250916221821.4387-59-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE821.infineon.com (172.23.29.47) To
 MUCSE827.infineon.com (172.23.29.20)

Structure and MACRO definitions related to the chipcommon region inside the
Infineon Device.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../wireless/infineon/inffmac/chipcommon.h    | 566 ++++++++++++++++++
 1 file changed, 566 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/chipcommon.h

diff --git a/drivers/net/wireless/infineon/inffmac/chipcommon.h b/drivers/net/wireless/infineon/inffmac/chipcommon.h
new file mode 100644
index 000000000000..4e27e1c1d36c
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chipcommon.h
@@ -0,0 +1,566 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef	INFF_CHIPCOMMON_H
+#define	INFF_CHIPCOMMON_H
+
+#include "defs.h"		/* for PAD macro */
+
+#define CHIPCREGOFFS(field)	offsetof(struct chipcregs, field)
+
+struct chipcregs {
+	u32 chipid;		/* 0x0 */
+	u32 capabilities;
+	u32 corecontrol;	/* corerev >= 1 */
+	u32 bist;
+
+	/* OTP */
+	u32 otpstatus;	/* 0x10, corerev >= 10 */
+	u32 otpcontrol;
+	u32 otpprog;
+	u32 otplayout;	/* corerev >= 23 */
+
+	/* Interrupt control */
+	u32 intstatus;	/* 0x20 */
+	u32 intmask;
+
+	/* Chip specific regs */
+	u32 chipcontrol;	/* 0x28, rev >= 11 */
+	u32 chipstatus;	/* 0x2c, rev >= 11 */
+
+	/* Jtag Master */
+	u32 jtagcmd;		/* 0x30, rev >= 10 */
+	u32 jtagir;
+	u32 jtagdr;
+	u32 jtagctrl;
+
+	/* serial flash interface registers */
+	u32 flashcontrol;	/* 0x40 */
+	u32 flashaddress;
+	u32 flashdata;
+	u32 PAD[1];
+
+	/* Silicon backplane configuration broadcast control */
+	u32 broadcastaddress;	/* 0x50 */
+	u32 broadcastdata;
+
+	/* gpio - cleared only by power-on-reset */
+	u32 gpiopullup;	/* 0x58, corerev >= 20 */
+	u32 gpiopulldown;	/* 0x5c, corerev >= 20 */
+	u32 gpioin;		/* 0x60 */
+	u32 gpioout;		/* 0x64 */
+	u32 gpioouten;	/* 0x68 */
+	u32 gpiocontrol;	/* 0x6C */
+	u32 gpiointpolarity;	/* 0x70 */
+	u32 gpiointmask;	/* 0x74 */
+
+	/* GPIO events corerev >= 11 */
+	u32 gpioevent;
+	u32 gpioeventintmask;
+
+	/* Watchdog timer */
+	u32 watchdog;	/* 0x80 */
+
+	/* GPIO events corerev >= 11 */
+	u32 gpioeventintpolarity;
+
+	/* GPIO based LED powersave registers corerev >= 16 */
+	u32 gpiotimerval;	/* 0x88 */
+	u32 gpiotimeroutmask;
+
+	/* clock control */
+	u32 clockcontrol_n;	/* 0x90 */
+	u32 clockcontrol_sb;	/* aka m0 */
+	u32 clockcontrol_pci;	/* aka m1 */
+	u32 clockcontrol_m2;	/* mii/uart/mipsref */
+	u32 clockcontrol_m3;	/* cpu */
+	u32 clkdiv;		/* corerev >= 3 */
+	u32 gpiodebugsel;	/* corerev >= 28 */
+	u32 capabilities_ext;	/* 0xac  */
+
+	/* pll delay registers (corerev >= 4) */
+	u32 pll_on_delay;	/* 0xb0 */
+	u32 fref_sel_delay;
+	u32 slow_clk_ctl;	/* 5 < corerev < 10 */
+	u32 PAD;
+
+	/* Instaclock registers (corerev >= 10) */
+	u32 system_clk_ctl;	/* 0xc0 */
+	u32 clkstatestretch;
+	u32 PAD[2];
+
+	/* Indirect backplane access (corerev >= 22) */
+	u32 bp_addrlow;	/* 0xd0 */
+	u32 bp_addrhigh;
+	u32 bp_data;
+	u32 PAD;
+	u32 bp_indaccess;
+	u32 PAD[3];
+
+	/* More clock dividers (corerev >= 32) */
+	u32 clkdiv2;
+	u32 PAD[2];
+
+	/* In AI chips, pointer to erom */
+	u32 eromptr;		/* 0xfc */
+
+	/* ExtBus control registers (corerev >= 3) */
+	u32 pcmcia_config;	/* 0x100 */
+	u32 pcmcia_memwait;
+	u32 pcmcia_attrwait;
+	u32 pcmcia_iowait;
+	u32 ide_config;
+	u32 ide_memwait;
+	u32 ide_attrwait;
+	u32 ide_iowait;
+	u32 prog_config;
+	u32 prog_waitcount;
+	u32 flash_config;
+	u32 flash_waitcount;
+	u32 SECI_config;	/* 0x130 SECI configuration */
+	u32 PAD[3];
+
+	/* Enhanced Coexistence Interface (ECI) registers (corerev >= 21) */
+	u32 eci_output;	/* 0x140 */
+	u32 eci_control;
+	u32 eci_inputlo;
+	u32 eci_inputmi;
+	u32 eci_inputhi;
+	u32 eci_inputintpolaritylo;
+	u32 eci_inputintpolaritymi;
+	u32 eci_inputintpolarityhi;
+	u32 eci_intmasklo;
+	u32 eci_intmaskmi;
+	u32 eci_intmaskhi;
+	u32 eci_eventlo;
+	u32 eci_eventmi;
+	u32 eci_eventhi;
+	u32 eci_eventmasklo;
+	u32 eci_eventmaskmi;
+	u32 eci_eventmaskhi;
+	u32 PAD[3];
+
+	/* SROM interface (corerev >= 32) */
+	u32 sromcontrol;	/* 0x190 */
+	u32 sromaddress;
+	u32 sromdata;
+	u32 PAD[17];
+
+	/* Clock control and hardware workarounds (corerev >= 20) */
+	u32 clk_ctl_st;	/* 0x1e0 */
+	u32 hw_war;
+	u32 PAD[70];
+
+	/* UARTs */
+	u8 uart0data;	/* 0x300 */
+	u8 uart0imr;
+	u8 uart0fcr;
+	u8 uart0lcr;
+	u8 uart0mcr;
+	u8 uart0lsr;
+	u8 uart0msr;
+	u8 uart0scratch;
+	u8 PAD[248];		/* corerev >= 1 */
+
+	u8 uart1data;	/* 0x400 */
+	u8 uart1imr;
+	u8 uart1fcr;
+	u8 uart1lcr;
+	u8 uart1mcr;
+	u8 uart1lsr;
+	u8 uart1msr;
+	u8 uart1scratch;
+	u32 PAD[62];
+
+	/* save/restore, corerev >= 48 */
+	u32 sr_capability;          /* 0x500 */
+	u32 sr_control0;            /* 0x504 */
+	u32 sr_control1;            /* 0x508 */
+	u32 gpio_control;           /* 0x50C */
+	u32 PAD[60];
+
+	/* PMU registers (corerev >= 20) */
+	u32 pmucontrol;	/* 0x600 */
+	u32 pmucapabilities;
+	u32 pmustatus;
+	u32 res_state;
+	u32 res_pending;
+	u32 pmutimer;
+	u32 min_res_mask;
+	u32 max_res_mask;
+	u32 res_table_sel;
+	u32 res_dep_mask;
+	u32 res_updn_timer;
+	u32 res_timer;
+	u32 clkstretch;
+	u32 pmuwatchdog;
+	u32 gpiosel;		/* 0x638, rev >= 1 */
+	u32 gpioenable;	/* 0x63c, rev >= 1 */
+	u32 res_req_timer_sel;
+	u32 res_req_timer;
+	u32 res_req_mask;
+	u32 pmucapabilities_ext; /* 0x64c, pmurev >=15 */
+	u32 chipcontrol_addr;	/* 0x650 */
+	u32 chipcontrol_data;	/* 0x654 */
+	u32 regcontrol_addr;
+	u32 regcontrol_data;
+	u32 pllcontrol_addr;
+	u32 pllcontrol_data;
+	u32 pmustrapopt;	/* 0x668, corerev >= 28 */
+	u32 pmu_xtalfreq;	/* 0x66C, pmurev >= 10 */
+	u32 retention_ctl;          /* 0x670, pmurev >= 15 */
+	u32 PAD[3];
+	u32 retention_grpidx;       /* 0x680 */
+	u32 retention_grpctl;       /* 0x684 */
+	u32 mac_res_req_timer;      /* 0x688 */
+	u32 mac_res_req_mask;       /* 0x68c */
+	u32 PAD[18];
+	u32 pmucontrol_ext;         /* 0x6d8 */
+	u32 slowclkperiod;          /* 0x6dc */
+	u32 PAD[8];
+	u32 pmuintmask0;            /* 0x700 */
+	u32 pmuintmask1;            /* 0x704 */
+	u32 PAD[14];
+	u32 pmuintstatus;           /* 0x740 */
+	u32 extwakeupstatus;        /* 0x744 */
+	u32 watchdog_res_mask;      /* 0x748 */
+	u32 swscratch;              /* 0x750 */
+	u32 PAD[3];
+	u32 extwakemask[2];         /* 0x760-0x764 */
+	u32 PAD[2];
+	u32 extwakereqmask[2];      /* 0x770-0x774 */
+	u32 PAD[2];
+	u32 pmuintctrl0;            /* 0x780 */
+	u32 pmuintctrl1;            /* 0x784 */
+	u32 PAD[2];
+	u32 extwakectrl[2];         /* 0x790 */
+};
+
+#define CHIPGCIREGOFFS(field) offsetof(struct chipgciregs, field)
+
+struct chipgciregs {
+	u32 gci_corecaps0;                             /* 0x000 */
+	u32 gci_corecaps1;                             /* 0x004 */
+	u32 gci_corecaps2;                             /* 0x008 */
+	u32 gci_corectrl;                              /* 0x00c */
+	u32 gci_corestat;                              /* 0x010 */
+	u32 gci_intstat;                               /* 0x014 */
+	u32 gci_intmask;                               /* 0x018 */
+	u32 gci_wakemask;                              /* 0x01c */
+	u32 gci_levelintstat;                          /* 0x020 */
+	u32 gci_eventintstat;                          /* 0x024 */
+	u32 gci_wakelevelintstat;                      /* 0x028 */
+	u32 gci_wakeeventintstat;                      /* 0x02c */
+	u32 semaphoreintstatus;                        /* 0x030 */
+	u32 semaphoreintmask;                          /* 0x034 */
+	u32 semaphorerequest;                          /* 0x038 */
+	u32 semaphorereserve;                          /* 0x03c */
+	u32 gci_indirect_addr;                         /* 0x040 */
+	u32 gci_gpioctl;                               /* 0x044 */
+	u32 gci_gpiostatus;                            /* 0x048 */
+	u32 gci_gpiomask;                              /* 0x04c */
+	u32 eventsummary;                              /* 0x050 */
+	u32 gci_miscctl;                               /* 0x054 */
+	u32 gci_gpiointmask;                           /* 0x058 */
+	u32 gci_gpiowakemask;                          /* 0x05c */
+	u32 gci_input[32];                             /* 0x060 */
+	u32 gci_event[32];                             /* 0x0e0 */
+	u32 gci_output[4];                             /* 0x160 */
+	u32 gci_control_0;                             /* 0x170 */
+	u32 gci_control_1;                             /* 0x174 */
+	u32 gci_intpolreg;                             /* 0x178 */
+	u32 gci_levelintmask;                          /* 0x17c */
+	u32 gci_eventintmask;                          /* 0x180 */
+	u32 wakelevelintmask;                          /* 0x184 */
+	u32 wakeeventintmask;                          /* 0x188 */
+	u32 hwmask;                                    /* 0x18c */
+	u32 PAD;
+	u32 gci_inbandeventintmask;                    /* 0x194 */
+	u32 PAD;
+	u32 gci_inbandeventstatus;                     /* 0x19c */
+	u32 gci_seciauxtx;                             /* 0x1a0 */
+	u32 gci_seciauxrx;                             /* 0x1a4 */
+	u32 gci_secitx_datatag;                        /* 0x1a8 */
+	u32 gci_secirx_datatag;                        /* 0x1ac */
+	u32 gci_secitx_datamask;                       /* 0x1b0 */
+	u32 gci_seciusef0tx_reg;                       /* 0x1b4 */
+	u32 gci_secif0tx_offset;                       /* 0x1b8 */
+	u32 gci_secif0rx_offset;                       /* 0x1bc */
+	u32 gci_secif1tx_offset;                       /* 0x1c0 */
+	u32 gci_rxfifo_common_ctrl;                    /* 0x1c4 */
+	u32 gci_rxfifoctrl;                            /* 0x1c8 */
+	u32 gci_hw_sema_status;                        /* 0x1cc */
+	u32 gci_seciuartescval;                        /* 0x1d0 */
+	u32 gic_seciuartautobaudctr;                   /* 0x1d4 */
+	u32 gci_secififolevel;                         /* 0x1d8 */
+	u32 gci_seciuartdata;                          /* 0x1dc */
+	u32 gci_secibauddiv;                           /* 0x1e0 */
+	u32 gci_secifcr;                               /* 0x1e4 */
+	u32 gci_secilcr;                               /* 0x1e8 */
+	u32 gci_secimcr;                               /* 0x1ec */
+	u32 gci_secilsr;                               /* 0x1f0 */
+	u32 gci_secimsr;                               /* 0x1f4 */
+	u32 gci_baudadj;                               /* 0x1f8 */
+	u32 gci_inbandintmask;                         /* 0x1fc */
+	u32 gci_chipctrl;                              /* 0x200 */
+	u32 gci_chipsts;                               /* 0x204 */
+	u32 gci_gpioout;                               /* 0x208 */
+	u32 gci_gpioout_read;                          /* 0x20C */
+	u32 gci_mpwaketx;                              /* 0x210 */
+	u32 gci_mpwakedetect;                          /* 0x214 */
+	u32 gci_seciin_ctrl;                           /* 0x218 */
+	u32 gci_seciout_ctrl;                          /* 0x21C */
+	u32 gci_seciin_auxfifo_en;                     /* 0x220 */
+	u32 gci_seciout_txen_txbr;                     /* 0x224 */
+	u32 gci_seciin_rxbrstatus;                     /* 0x228 */
+	u32 gci_seciin_rxerrstatus;                    /* 0x22C */
+	u32 gci_seciin_fcstatus;                       /* 0x230 */
+	u32 gci_seciout_txstatus;                      /* 0x234 */
+	u32 gci_seciout_txbrstatus;                    /* 0x238 */
+	u32 wlan_mem_info;                             /* 0x23C */
+	u32 wlan_bankxinfo;                            /* 0x240 */
+	u32 bt_smem_select;                            /* 0x244 */
+	u32 bt_smem_stby;                              /* 0x248 */
+	u32 bt_smem_status;                            /* 0x24C */
+	u32 wlan_bankxactivepda;                       /* 0x250 */
+	u32 wlan_bankxsleeppda;                        /* 0x254 */
+	u32 wlan_bankxkill;                            /* 0x258 */
+	u32 PAD[41];
+	u32 gci_chipid;                                /* 0x300 */
+	u32 PAD[3];
+	u32 otpstatus;                                 /* 0x310 */
+	u32 otpcontrol;                                /* 0x314 */
+	u32 otpprog;                                   /* 0x318 */
+	u32 otplayout;                                 /* 0x31c */
+	u32 otplayoutextension;                        /* 0x320 */
+	u32 otpcontrol1;                               /* 0x324 */
+	u32 otpprogdata;                               /* 0x328 */
+	u32 PAD[52];
+	u32 otp_ecc_status;                            /* 0x3FC */
+	u32 PAD[512];
+	u32 lhl_core_capab_adr;                        /* 0xC00 */
+	u32 lhl_main_ctl_adr;                          /* 0xC04 */
+	u32 lhl_pmu_ctl_adr;                           /* 0xC08 */
+	u32 lhl_extlpo_ctl_adr;                        /* 0xC0C */
+	u32 lpo_ctl_adr;                               /* 0xC10 */
+	u32 lhl_lpo2_ctl_adr;                          /* 0xC14 */
+	u32 lhl_osc32k_ctl_adr;                        /* 0xC18 */
+	u32 lhl_clk_status_adr;                        /* 0xC1C */
+	u32 lhl_clk_det_ctl_adr;                       /* 0xC20 */
+	u32 lhl_clk_sel_adr;                           /* 0xC24 */
+	u32 hidoff_cnt_adr[2];                         /* 0xC28-0xC2C */
+	u32 lhl_autoclk_ctl_adr;                       /* 0xC30 */
+	u32 PAD;
+	u32 lhl_hibtim_adr;                            /* 0xC38 */
+	u32 lhl_wl_ilp_val_adr;                        /* 0xC3C */
+	u32 lhl_wl_armtim0_intrp_adr;                  /* 0xC40 */
+	u32 lhl_wl_armtim0_st_adr;                     /* 0xC44 */
+	u32 lhl_wl_armtim0_adr;                        /* 0xC48 */
+	u32 PAD[9];
+	u32 lhl_wl_mactim0_intrp_adr;                  /* 0xC70 */
+	u32 lhl_wl_mactim0_st_adr;                     /* 0xC74 */
+	u32 lhl_wl_mactim_int0_adr;                    /* 0xC78 */
+	u32 lhl_wl_mactim_frac0_adr;                   /* 0xC7C */
+	u32 lhl_wl_mactim1_intrp_adr;                  /* 0xC80 */
+	u32 lhl_wl_mactim1_st_adr;                     /* 0xC84 */
+	u32 lhl_wl_mactim_int1_adr;                    /* 0xC88 */
+	u32 lhl_wl_mactim_frac1_adr;                   /* 0xC8C */
+	u32 PAD[8];
+	u32 gpio_int_en_port_adr[4];                   /* 0xCB0-0xCBC */
+	u32 gpio_int_st_port_adr[4];                   /* 0xCC0-0xCCC */
+	u32 gpio_ctrl_iocfg_p_adr[64];                 /* 0xCD0-0xDCC */
+	u32 gpio_gctrl_iocfg_p0_p39_adr;               /* 0xDD0 */
+	u32 gpio_gdsctrl_iocfg_p0_p25_p30_p39_adr;     /* 0xDD4 */
+	u32 gpio_gdsctrl_iocfg_p26_p29_adr;            /* 0xDD8 */
+	u32 PAD[8];
+	u32 lhl_gpio_din0_adr;                         /* 0xDFC */
+	u32 lhl_gpio_din1_adr;                         /* 0xE00 */
+	u32 lhl_wkup_status_adr;                       /* 0xE04 */
+	u32 lhl_ctl_adr;                               /* 0xE08 */
+	u32 lhl_adc_ctl_adr;                           /* 0xE0C */
+	u32 lhl_qdxyz_in_dly_adr;                      /* 0xE10 */
+	u32 lhl_optctl_adr;                            /* 0xE14 */
+	u32 lhl_optct2_adr;                            /* 0xE18 */
+	u32 lhl_scanp_cntr_init_val_adr;               /* 0xE1C */
+	u32 lhl_opt_togg_val_adr[6];                   /* 0xE20-0xE34 */
+	u32 lhl_optx_smp_val_adr;                      /* 0xE38 */
+	u32 lhl_opty_smp_val_adr;                      /* 0xE3C */
+	u32 lhl_optz_smp_val_adr;                      /* 0xE40 */
+	u32 lhl_hidoff_keepstate_adr[3];               /* 0xE44-0xE4C */
+	u32 lhl_bt_slmboot_ctl0_adr[4];                /* 0xE50-0xE5C */
+	u32 lhl_wl_fw_ctl;                             /* 0xE60 */
+	u32 lhl_wl_hw_ctl_adr[2];                      /* 0xE64-0xE68 */
+	u32 lhl_bt_hw_ctl_adr;                         /* 0xE6C */
+	u32 lhl_top_pwrseq_en_adr;                     /* 0xE70 */
+	u32 lhl_top_pwrdn_ctl_adr;                     /* 0xE74 */
+	u32 lhl_top_pwrup_ctl_adr;                     /* 0xE78 */
+	u32 lhl_top_pwrseq_ctl_adr;                    /* 0xE7C */
+	u32 lhl_top_pwrdn2_ctl_adr;                    /* 0xE80 */
+	u32 lhl_top_pwrup2_ctl_adr;                    /* 0xE84 */
+	u32 wpt_regon_intrp_cfg_adr;                   /* 0xE88 */
+	u32 bt_regon_intrp_cfg_adr;                    /* 0xE8C */
+	u32 wl_regon_intrp_cfg_adr;                    /* 0xE90 */
+	u32 regon_intrp_st_adr;                        /* 0xE94 */
+	u32 regon_intrp_en_adr;                        /* 0xE98 */
+
+};
+
+/* chipid */
+#define	CID_ID_MASK		0x0000ffff	/* Chip Id mask */
+#define	CID_REV_MASK		0x000f0000	/* Chip Revision mask */
+#define	CID_REV_SHIFT		16	/* Chip Revision shift */
+#define	CID_PKG_MASK		0x00f00000	/* Package Option mask */
+#define	CID_PKG_SHIFT		20	/* Package Option shift */
+#define	CID_CC_MASK		0x0f000000	/* CoreCount (corerev >= 4) */
+#define CID_CC_SHIFT		24
+#define	CID_TYPE_MASK		0xf0000000	/* Chip Type */
+#define CID_TYPE_SHIFT		28
+
+/* capabilities */
+#define	CC_CAP_UARTS_MASK	0x00000003	/* Number of UARTs */
+#define CC_CAP_MIPSEB		0x00000004	/* MIPS is in big-endian mode */
+#define CC_CAP_UCLKSEL		0x00000018	/* UARTs clock select */
+/* UARTs are driven by internal divided clock */
+#define CC_CAP_UINTCLK		0x00000008
+#define CC_CAP_UARTGPIO		0x00000020	/* UARTs own GPIOs 15:12 */
+#define CC_CAP_EXTBUS_MASK	0x000000c0	/* External bus mask */
+#define CC_CAP_EXTBUS_NONE	0x00000000	/* No ExtBus present */
+#define CC_CAP_EXTBUS_FULL	0x00000040	/* ExtBus: PCMCIA, IDE & Prog */
+#define CC_CAP_EXTBUS_PROG	0x00000080	/* ExtBus: ProgIf only */
+#define	CC_CAP_FLASH_MASK	0x00000700	/* Type of flash */
+#define	CC_CAP_PLL_MASK		0x00038000	/* Type of PLL */
+#define CC_CAP_PWR_CTL		0x00040000	/* Power control */
+#define CC_CAP_OTPSIZE		0x00380000	/* OTP Size (0 = none) */
+#define CC_CAP_OTPSIZE_SHIFT	19	/* OTP Size shift */
+#define CC_CAP_OTPSIZE_BASE	5	/* OTP Size base */
+#define CC_CAP_JTAGP		0x00400000	/* JTAG Master Present */
+#define CC_CAP_ROM		0x00800000	/* Internal boot rom active */
+#define CC_CAP_BKPLN64		0x08000000	/* 64-bit backplane */
+#define	CC_CAP_PMU		0x10000000	/* PMU Present, rev >= 20 */
+#define	CC_CAP_SROM		0x40000000	/* Srom Present, rev >= 32 */
+/* Nand flash present, rev >= 35 */
+#define	CC_CAP_NFLASH		0x80000000
+
+#define	CC_CAP2_SECI		0x00000001	/* SECI Present, rev >= 36 */
+/* GSIO (spi/i2c) present, rev >= 37 */
+#define	CC_CAP2_GSIO		0x00000002
+
+/* sr_control0, rev >= 48 */
+#define CC_SR_CTL0_ENABLE_MASK			BIT(0)
+#define CC_SR_CTL0_ENABLE_SHIFT		0
+#define CC_SR_CTL0_EN_SR_ENG_CLK_SHIFT	1 /* sr_clk to sr_memory enable */
+#define CC_SR_CTL0_RSRC_TRIGGER_SHIFT	2 /* Rising edge resource trigger 0 to
+					   * sr_engine
+					   */
+#define CC_SR_CTL0_MIN_DIV_SHIFT	6 /* Min division value for fast clk
+					   * in sr_engine
+					   */
+#define CC_SR_CTL0_EN_SBC_STBY_SHIFT		16
+#define CC_SR_CTL0_EN_SR_ALP_CLK_MASK_SHIFT	18
+#define CC_SR_CTL0_EN_SR_HT_CLK_SHIFT		19
+#define CC_SR_CTL0_ALLOW_PIC_SHIFT	20 /* Allow pic to separate power
+					    * domains
+					    */
+#define CC_SR_CTL0_MAX_SR_LQ_CLK_CNT_SHIFT	25
+#define CC_SR_CTL0_EN_MEM_DISABLE_FOR_SLEEP	30
+
+/* pmucapabilities */
+#define PCAP_REV_MASK	0x000000ff
+#define PCAP_RC_MASK	0x00001f00
+#define PCAP_RC_SHIFT	8
+#define PCAP_TC_MASK	0x0001e000
+#define PCAP_TC_SHIFT	13
+#define PCAP_PC_MASK	0x001e0000
+#define PCAP_PC_SHIFT	17
+#define PCAP_VC_MASK	0x01e00000
+#define PCAP_VC_SHIFT	21
+#define PCAP_CC_MASK	0x1e000000
+#define PCAP_CC_SHIFT	25
+#define PCAP5_PC_MASK	0x003e0000	/* PMU corerev >= 5 */
+#define PCAP5_PC_SHIFT	17
+#define PCAP5_VC_MASK	0x07c00000
+#define PCAP5_VC_SHIFT	22
+#define PCAP5_CC_MASK	0xf8000000
+#define PCAP5_CC_SHIFT	27
+/* pmucapabilites_ext PMU rev >= 15 */
+#define PCAPEXT_SR_SUPPORTED_MASK       BIT(1)
+/* retention_ctl PMU rev >= 15 */
+#define PMU_RCTL_MACPHY_DISABLE_MASK    BIT(26)
+#define PMU_RCTL_LOGIC_DISABLE_MASK     BIT(27)
+
+/*
+ * Maximum delay for the PMU state transition in us.
+ * This is an upper bound intended for spinwaits etc.
+ */
+#define PMU_MAX_TRANSITION_DLY	15000
+
+#define DEFAULT_43022_MIN_RES_MASK 0x0f8bfe77
+
+/* Chip Common registers */
+/* PMU registers (rev >= 20) */
+#define INF_CC_PMU_CTL                 0x0600 /* PMU control */
+#define  INF_CC_PMU_CTL_ILP_DIV        0xFFFF0000 /* ILP div mask */
+#define  INF_CC_PMU_CTL_ILP_DIV_SHIFT  16
+#define  INF_CC_PMU_CTL_RES            0x00006000 /* reset control mask */
+#define  INF_CC_PMU_CTL_RES_SHIFT      13
+#define  INF_CC_PMU_CTL_RES_RELOAD     0x2     /* reload POR values */
+#define  INF_CC_PMU_CTL_PLL_UPD        0x00000400
+#define  INF_CC_PMU_CTL_NOILPONW       0x00000200 /* No ILP on wait */
+#define  INF_CC_PMU_CTL_HTREQEN        0x00000100 /* HT req enable */
+#define  INF_CC_PMU_CTL_ALPREQEN       0x00000080 /* ALP req enable */
+#define  INF_CC_PMU_CTL_XTALFREQ       0x0000007C /* Crystal freq */
+#define  INF_CC_PMU_CTL_XTALFREQ_SHIFT 2
+#define  INF_CC_PMU_CTL_ILPDIVEN       0x00000002 /* ILP div enable */
+#define  INF_CC_PMU_CTL_LPOSEL         0x00000001 /* LPO sel */
+
+#define INF_CC_CAP_EXT                 0x00AC          /* Capabilities */
+#define  INF_CC_CAP_EXT_SECI_PRESENT   0x00000001
+#define  INF_CC_CAP_EXT_GSIO_PRESENT   0x00000002
+#define  INF_CC_CAP_EXT_GCI_PRESENT    0x00000004
+#define  INF_CC_CAP_EXT_SECI_PUART_PRESENT             0x00000008    /* UART present */
+#define  INF_CC_CAP_EXT_SRENG_REG_PRESENT              0x00000010
+#define  INF_CC_CAP_EXT_ASCU_PRESENT   0x00000020
+#define  INF_CC_CAP_EXT_AOB_PRESENT    0x00000040
+
+#define INF_CC_SROM_CONTROL            0x0190
+#define  INF_CC_SROM_CONTROL_START     0x80000000
+#define  INF_CC_SROM_CONTROL_BUSY      0x80000000
+#define  INF_CC_SROM_CONTROL_OPCODE    0x60000000
+#define  INF_CC_SROM_CONTROL_OP_READ   0x00000000
+#define  INF_CC_SROM_CONTROL_OP_WRITE  0x20000000
+#define  INF_CC_SROM_CONTROL_OP_WRDIS  0x40000000
+#define  INF_CC_SROM_CONTROL_OP_WREN   0x60000000
+#define  INF_CC_SROM_CONTROL_OTPSEL    0x00000010
+#define  INF_CC_SROM_CONTROL_OTP_PRESENT       0x00000020
+#define  INF_CC_SROM_CONTROL_LOCK      0x00000008
+#define  INF_CC_SROM_CONTROL_SIZE_MASK 0x00000006
+#define  INF_CC_SROM_CONTROL_SIZE_1K   0x00000000
+#define  INF_CC_SROM_CONTROL_SIZE_4K   0x00000002
+#define  INF_CC_SROM_CONTROL_SIZE_16K  0x00000004
+#define  INF_CC_SROM_CONTROL_SIZE_SHIFT        1
+#define  INF_CC_SROM_CONTROL_PRESENT   0x00000001
+
+/* Core-ID values. */
+#define INF_CORE_CHIPCOMMON            0x800
+#define INF_CORE_INTERNAL_MEM          0x80E
+#define INF_CORE_80211                 0x812
+#define INF_CORE_PMU                   0x827
+#define INF_CORE_SDIO_DEV              0x829
+#define INF_CORE_ARM_CM3               0x82A
+#define INF_CORE_PCIE2                 0x83C    /* PCI Express Gen2 */
+#define INF_CORE_ARM_CR4               0x83E
+#define INF_CORE_GCI                   0x840
+#define INF_CORE_SR                    0x841
+#define INF_CORE_SYS_MEM               0x849
+#define INF_CORE_DEFAULT               0xFFF
+#define INF_CORE_CHIPCOMMON		0x800
+
+#define INF_MAX_NR_CORES               16
+#define INF_CORE_SIZE                  0x1000
+
+#endif /* INFF_CHIPCOMMON_H */
-- 
2.25.1


