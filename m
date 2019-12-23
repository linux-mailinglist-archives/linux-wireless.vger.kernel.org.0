Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 734C012962D
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2019 13:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfLWM6K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Dec 2019 07:58:10 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33100 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfLWM6J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Dec 2019 07:58:09 -0500
Received: by mail-qt1-f193.google.com with SMTP id d5so15346337qto.0;
        Mon, 23 Dec 2019 04:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=INtHuo+wFXQma24QAkn0TfbvzcoxzBz6nVO1FdAjjCQ=;
        b=BrdfwjK7s1zpLOfhGMfjArZ9vofFEfQ727CjAeLxNLYTUHiqNcB8RjmjUJbQijjiQN
         3xSKIL59QY5hJqyO6gE8+p4saksFqLFHjU6Z55NgLbBHncI82tK9q9EwBpvzYm/39X2r
         bylI2yVvutbhUrbfSVWKZmqzw4alIj3TsvrXf0Jo9Lt/Om5KnefmebMJX8tEp5Cy+B4X
         /e3UEb8YnOfwZL99LQDbtQVuzITV2e2D83aHsy5Br/rX9TJGWPj6S/nkJ5kS/3rsyobY
         UcbaAkdb8OY9tmbQuTMgaW3XSUclyqVhaaKRGfqqaJY6Fh/dYhVeJagT45TJVhYVAsMK
         KIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=INtHuo+wFXQma24QAkn0TfbvzcoxzBz6nVO1FdAjjCQ=;
        b=BHOssOX/ZustLTIj91i8BAGths8mYPKouj0yAm05LN1ZkvrFoStDRUmBsDl0U1lRLn
         UGJQ28sgFu6Q4EYFqWR5ZkTyAi7R2kiEWyvr3IJkqsv/5HizWQCHVJ1yT5xC5Wyt+n/1
         eudPnt0/4BGs0FsZTvTd9lRTc76SKZ9iKBTjRbRRYCT/fTZ0Z41Eti+VBguV3dK7lKQ5
         KhrwXunLgt6PO7VnDQGAK444dc6iassH2e364TvGXo/5YptC8L6F+clDjZ9m86ix6KBI
         nZBIXW4ytXqa2uaL/QJ5Ei/xeH50kHnC++XD7Pw0YTuWgGpVbwCJjuKTbV3wqPHY+pb/
         Qj4w==
X-Gm-Message-State: APjAAAUIQ6O6D5dS1Kg/YdlyzexqRGuBft4u9KKx+ifP461mK54+s+Wd
        kf4lIS0p9VxHJkzsUe7YQSg=
X-Google-Smtp-Source: APXvYqyRrb9Qy9qcM3CVq5FObZ3/6f2hU+MYHUVxZXjvk/Jg5Fld4FMUoZ2UQhQQ/YF9FE18FrgviQ==
X-Received: by 2002:aed:2725:: with SMTP id n34mr20927903qtd.333.1577105864710;
        Mon, 23 Dec 2019 04:57:44 -0800 (PST)
Received: from system76-pc.localdomain (pool-68-133-6-220.bflony.fios.verizon.net. [68.133.6.220])
        by smtp.gmail.com with ESMTPSA id n1sm5665606qkk.122.2019.12.23.04.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Dec 2019 04:57:43 -0800 (PST)
Date:   Mon, 23 Dec 2019 07:57:42 -0500
From:   Stuart Little <achirvasub@gmail.com>
To:     Luciano Coelho <luciano.coelho@intel.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        linux-wireless@vger.kernel.org
Subject: Re: PROBLEM: iwlwifi in 5.4 does not load firmware for Intel device
 9560
Message-ID: <20191223125742.GA2586@system76-pc.localdomain>
References: <20190817041258.GA1641@chirva-slack.chirva-slack>
 <20191208203810.GA2920@system76-pc.localdomain>
 <20191222224207.GA2408@system76-pc.localdomain>
 <ec9092a28196f24c39051b89f9dc87b40942b6de.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec9092a28196f24c39051b89f9dc87b40942b6de.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 23, 2019 at 02:52:11PM +0200, Luciano Coelho wrote:
> Hi,
> 
> The fix for this is already in v5.5-rc3:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=db5cce1afc8d2475d2c1c37c2a8267dd0e151526
> 

I was actually going to write just now to report this: I've checked that the very latest 5.5.0-rc3 works fine on this machine.

> I'm going to sent it for v5.4 explicitly now, so hopefully it will be
> included in the next v5.4 stable release that comes out.
> 
> The reason for this bug was that we had two conflicting patches, one
> for v5.3 during the rc series and one for v5.4 when it was still
> "next".  When these two were merged, one patch canceled the other,
> causing this bug.
> 
> Sorry for the trouble. :(
> 
> --
> Cheers,
> Luca.
> 
> 
> On Sun, 2019-12-22 at 17:42 -0500, Stuart Little wrote:
> > I have now done a git bisect on this. I am attaching
> > 
> > (1) the final output of the bisect
> > (2) the bisect log at the end of the procedure
> > 
> > The outcome: the first bad commit is
> > 
> > --- cut here ---
> > 
> > commit aa0cc7dde17bb6b8cc533bbcfe3f53d70e0dd269
> > Author: Luca Coelho <luciano.coelho@intel.com>
> > Date:   Tue Oct 8 13:21:02 2019 +0300
> > 
> >     iwlwifi: pcie: change qu with jf devices to use qu configuration
> > 
> >     There were a bunch of devices with qu and jf that were loading the
> >     configuration with pu and jf, which is wrong.  Fix them all
> >     accordingly.  Additionally, remove 0x1010 and 0x1210 subsytem IDs from
> >     the list, since they are obviously wrong, and 0x0044 and 0x0244, which
> >     were duplicate.
> > 
> >     Cc: stable@vger.kernel.org # 5.1+
> >     Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> > 
> > :040000 040000 eb49c26606bfbedf9c8e5e84b16b9018376d2b5a 30e7f6ab4f0369c2a6723818fa915353820641ed M      drivers
> > 
> > --- done ---
> > 
> > Just in case it was lost way down inside the dmesg in my earlier long message: the device is
> > 
> > Intel(R) Wireless-AC 9560 160MHz, REV=0x354
> > 
> > On Sun, Dec 08, 2019 at 03:38:10PM -0500, Stuart Little wrote:
> > > I am on an
> > > 
> > > Intel(R) Core(TM) i7-10510U CPU @ 1.80GHz
> > > 
> > > with an Intel wifi card, currently running Ubuntu 18.04 with that distro's 5.3.0-22 kernel (config attached under the obvious name). The wifi info provided by 'lspci -vv -s 00:14.3' is
> > > 
> > > 00:14.3 Network controller: Intel Corporation Device 02f0
> > >         Subsystem: Intel Corporation Device 0034
> > >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> > >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >         Latency: 0, Cache Line Size: 64 bytes
> > >         Interrupt: pin A routed to IRQ 16
> > >         Region 0: Memory at d1c10000 (64-bit, non-prefetchable) [size=16K]
> > >         Capabilities: <access denied>
> > >         Kernel driver in use: iwlwifi
> > >         Kernel modules: iwlwifi
> > > 
> > > I tried to compile the latest 5.4 from Linus' tree[0] by simply copying over the current config and making oldconfig in the source directory (the resulting file is also attached).
> > > 
> > > The issue: after a number of failed attempts to load firmware the iwlwifi driver errors out massively as you can see in the attached 'dmesg' output.
> > > 
> > > In the end the wifi card is not recognized (i.e. not displayed by 'ip a').
> > > 
> > > The problematic section of dmesg that eventually ends in failure to recognize the card is
> > > 
> > > --- cut here ---
> > > 
> > > [    4.871101] iwlwifi 0000:00:14.3: Collecting data: trigger 15 fired.
> > > [    4.871194] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
> > > [    4.871219] iwlwifi 0000:00:14.3: Status: 0x00000000, count: 64440511
> > > [    4.871241] iwlwifi 0000:00:14.3: Loaded firmware version: 48.4fa0041f.0
> > > [    4.871264] iwlwifi 0000:00:14.3: 0xBC0C8B90 | ADVANCED_SYSASSERT          
> > > [    4.871287] iwlwifi 0000:00:14.3: 0x8BB5013B | trm_hw_status0
> > > [    4.871307] iwlwifi 0000:00:14.3: 0x3782DEDA | trm_hw_status1
> > > [    4.871326] iwlwifi 0000:00:14.3: 0xB2693FEE | branchlink2
> > > [    4.871345] iwlwifi 0000:00:14.3: 0xF2827B49 | interruptlink1
> > > [    4.871365] iwlwifi 0000:00:14.3: 0x847E55B8 | interruptlink2
> > > [    4.871385] iwlwifi 0000:00:14.3: 0x7D9EFB86 | data1
> > > [    4.871402] iwlwifi 0000:00:14.3: 0xCA6DF7D7 | data2
> > > [    4.871419] iwlwifi 0000:00:14.3: 0xBBA4E8FF | data3
> > > [    4.871442] iwlwifi 0000:00:14.3: 0x05D7D912 | beacon time
> > > [    4.871461] iwlwifi 0000:00:14.3: 0x3E988BC8 | tsf low
> > > [    4.871479] iwlwifi 0000:00:14.3: 0xFBF4CBDD | tsf hi
> > > [    4.871496] iwlwifi 0000:00:14.3: 0xA77169BD | time gp1
> > > [    4.871514] iwlwifi 0000:00:14.3: 0xFB901860 | time gp2
> > > [    4.871532] iwlwifi 0000:00:14.3: 0x5CFCAA70 | uCode revision type
> > > [    4.871553] iwlwifi 0000:00:14.3: 0x5F085914 | uCode version major
> > > [    4.871574] iwlwifi 0000:00:14.3: 0x795F9B7B | uCode version minor
> > > [    4.871600] iwlwifi 0000:00:14.3: 0x2C781766 | hw version
> > > [    4.871619] iwlwifi 0000:00:14.3: 0xBDB0CB0F | board version
> > > [    4.871638] iwlwifi 0000:00:14.3: 0xFF00CCF1 | hcmd
> > > [    4.871655] iwlwifi 0000:00:14.3: 0x2C71EBDF | isr0
> > > [    4.871672] iwlwifi 0000:00:14.3: 0x7EBED69F | isr1
> > > [    4.871689] iwlwifi 0000:00:14.3: 0x0A4A0EC2 | isr2
> > > [    4.871706] iwlwifi 0000:00:14.3: 0x9527018B | isr3
> > > [    4.871723] iwlwifi 0000:00:14.3: 0xA9AE681D | isr4
> > > [    4.871740] iwlwifi 0000:00:14.3: 0x7DC4F7F4 | last cmd Id
> > > [    4.871759] iwlwifi 0000:00:14.3: 0x9AE7B6DC | wait_event
> > > [    4.871778] iwlwifi 0000:00:14.3: 0x6F3E8495 | l2p_control
> > > [    4.871797] iwlwifi 0000:00:14.3: 0x6FA4177E | l2p_duration
> > > [    4.871816] iwlwifi 0000:00:14.3: 0x9FAC4C30 | l2p_mhvalid
> > > [    4.871835] iwlwifi 0000:00:14.3: 0xF785BA8D | l2p_addr_match
> > > [    4.871854] iwlwifi 0000:00:14.3: 0xDA555345 | lmpm_pmg_sel
> > > [    4.871874] iwlwifi 0000:00:14.3: 0xED6318B4 | timestamp
> > > [    4.871892] iwlwifi 0000:00:14.3: 0x1AF65EBE | flow_handler
> > > [    4.871965] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
> > > [    4.871984] iwlwifi 0000:00:14.3: Status: 0x00000000, count: 7
> > > [    4.872004] iwlwifi 0000:00:14.3: 0x201013F1 | ADVANCED_SYSASSERT
> > > [    4.872025] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
> > > [    4.872045] iwlwifi 0000:00:14.3: 0xC008CF5C | umac branchlink2
> > > [    4.872065] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink1
> > > [    4.872091] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
> > > [    4.872112] iwlwifi 0000:00:14.3: 0x00000003 | umac data1
> > > [    4.872131] iwlwifi 0000:00:14.3: 0x20000302 | umac data2
> > > [    4.872149] iwlwifi 0000:00:14.3: 0x01300202 | umac data3
> > > [    4.872168] iwlwifi 0000:00:14.3: 0x00000030 | umac major
> > > [    4.872187] iwlwifi 0000:00:14.3: 0x4FA0041F | umac minor
> > > [    4.872205] iwlwifi 0000:00:14.3: 0x00005D02 | frame pointer
> > > [    4.872225] iwlwifi 0000:00:14.3: 0xC0887F58 | stack pointer
> > > [    4.872244] iwlwifi 0000:00:14.3: 0x00000000 | last host cmd
> > > [    4.872263] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
> > > [    4.872298] iwlwifi 0000:00:14.3: Fseq Registers:
> > > [    4.872325] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_ERROR_CODE
> > > [    4.872356] iwlwifi 0000:00:14.3: 0x00000000 | FSEQ_TOP_INIT_VERSION
> > > [    4.872919] iwlwifi 0000:00:14.3: 0xD744ED07 | FSEQ_CNVIO_INIT_VERSION
> > > [    4.873477] iwlwifi 0000:00:14.3: 0x0000A384 | FSEQ_OTP_VERSION
> > > [    4.874033] iwlwifi 0000:00:14.3: 0xAAD04292 | FSEQ_TOP_CONTENT_VERSION
> > > [    4.874602] iwlwifi 0000:00:14.3: 0xF5842307 | FSEQ_ALIVE_TOKEN
> > > [    4.875174] iwlwifi 0000:00:14.3: 0x1D7BFF8E | FSEQ_CNVI_ID
> > > [    4.875755] iwlwifi 0000:00:14.3: 0x8141BAF3 | FSEQ_CNVR_ID
> > > [    4.876333] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
> > > [    4.876889] iwlwifi 0000:00:14.3: 0x01300202 | CNVR_AUX_MISC_CHIP
> > > [    4.877429] iwlwifi 0000:00:14.3: 0x0000485B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
> > > [    4.877986] iwlwifi 0000:00:14.3: 0xA5A5A5A2 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
> > > [    4.878588] iwlwifi 0000:00:14.3: SecBoot CPU1 Status: 0x5c72, CPU2 Status: 0x3
> > > [    4.879130] iwlwifi 0000:00:14.3: Failed to start RT ucode: -110
> > > [    4.879672] iwlwifi 0000:00:14.3: Firmware not running - cannot dump error
> > > [    4.892174] iwlwifi 0000:00:14.3: Failed to run INIT ucode: -110
> > > 
> > > --- end ---
> > > 
> > > ---
> > > 
> > > References:
> > > 
> > > [0] https://github.com/torvalds/linux
> > > #
> > > # Automatically generated file; DO NOT EDIT.
> > > # Linux/x86 5.3.0-22-generic Kernel Configuration
> > > #
> > > 
> > > #
> > > # Compiler: gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
> > > #
> > > CONFIG_CC_IS_GCC=y
> > > CONFIG_GCC_VERSION=70400
> > > CONFIG_CLANG_VERSION=0
> > > CONFIG_CC_CAN_LINK=y
> > > CONFIG_CC_HAS_ASM_GOTO=y
> > > CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
> > > CONFIG_IRQ_WORK=y
> > > CONFIG_BUILDTIME_EXTABLE_SORT=y
> > > CONFIG_THREAD_INFO_IN_TASK=y
> > > 
> > > #
> > > # General setup
> > > #
> > > CONFIG_INIT_ENV_ARG_LIMIT=32
> > > # CONFIG_COMPILE_TEST is not set
> > > # CONFIG_HEADER_TEST is not set
> > > CONFIG_LOCALVERSION=""
> > > # CONFIG_LOCALVERSION_AUTO is not set
> > > CONFIG_BUILD_SALT=""
> > > CONFIG_HAVE_KERNEL_GZIP=y
> > > CONFIG_HAVE_KERNEL_BZIP2=y
> > > CONFIG_HAVE_KERNEL_LZMA=y
> > > CONFIG_HAVE_KERNEL_XZ=y
> > > CONFIG_HAVE_KERNEL_LZO=y
> > > CONFIG_HAVE_KERNEL_LZ4=y
> > > CONFIG_KERNEL_GZIP=y
> > > # CONFIG_KERNEL_BZIP2 is not set
> > > # CONFIG_KERNEL_LZMA is not set
> > > # CONFIG_KERNEL_XZ is not set
> > > # CONFIG_KERNEL_LZO is not set
> > > # CONFIG_KERNEL_LZ4 is not set
> > > CONFIG_DEFAULT_HOSTNAME="(none)"
> > > CONFIG_VERSION_SIGNATURE="Ubuntu 5.3.0-22.24+system76~1573660262~18.04~d11b582~dev-generic 5.3.7"
> > > CONFIG_SWAP=y
> > > CONFIG_SYSVIPC=y
> > > CONFIG_SYSVIPC_SYSCTL=y
> > > CONFIG_POSIX_MQUEUE=y
> > > CONFIG_POSIX_MQUEUE_SYSCTL=y
> > > CONFIG_CROSS_MEMORY_ATTACH=y
> > > CONFIG_USELIB=y
> > > CONFIG_AUDIT=y
> > > CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> > > CONFIG_AUDITSYSCALL=y
> > > 
> > > #
> > > # IRQ subsystem
> > > #
> > > CONFIG_GENERIC_IRQ_PROBE=y
> > > CONFIG_GENERIC_IRQ_SHOW=y
> > > CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
> > > CONFIG_GENERIC_PENDING_IRQ=y
> > > CONFIG_GENERIC_IRQ_MIGRATION=y
> > > CONFIG_GENERIC_IRQ_CHIP=y
> > > CONFIG_IRQ_DOMAIN=y
> > > CONFIG_IRQ_DOMAIN_HIERARCHY=y
> > > CONFIG_GENERIC_MSI_IRQ=y
> > > CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
> > > CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> > > CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> > > CONFIG_IRQ_FORCED_THREADING=y
> > > # CONFIG_IRQ_FORCED_THREADING_DEFAULT is not set
> > > CONFIG_SPARSE_IRQ=y
> > > # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> > > # end of IRQ subsystem
> > > 
> > > CONFIG_CLOCKSOURCE_WATCHDOG=y
> > > CONFIG_ARCH_CLOCKSOURCE_DATA=y
> > > CONFIG_ARCH_CLOCKSOURCE_INIT=y
> > > CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> > > CONFIG_GENERIC_TIME_VSYSCALL=y
> > > CONFIG_GENERIC_CLOCKEVENTS=y
> > > CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> > > CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> > > CONFIG_GENERIC_CMOS_UPDATE=y
> > > 
> > > #
> > > # Timers subsystem
> > > #
> > > CONFIG_TICK_ONESHOT=y
> > > CONFIG_NO_HZ_COMMON=y
> > > # CONFIG_HZ_PERIODIC is not set
> > > CONFIG_NO_HZ_IDLE=y
> > > # CONFIG_NO_HZ_FULL is not set
> > > CONFIG_NO_HZ=y
> > > CONFIG_HIGH_RES_TIMERS=y
> > > # end of Timers subsystem
> > > 
> > > # CONFIG_PREEMPT_NONE is not set
> > > CONFIG_PREEMPT_VOLUNTARY=y
> > > # CONFIG_PREEMPT is not set
> > > 
> > > #
> > > # CPU/Task time and stats accounting
> > > #
> > > CONFIG_TICK_CPU_ACCOUNTING=y
> > > # CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
> > > # CONFIG_IRQ_TIME_ACCOUNTING is not set
> > > CONFIG_BSD_PROCESS_ACCT=y
> > > CONFIG_BSD_PROCESS_ACCT_V3=y
> > > CONFIG_TASKSTATS=y
> > > CONFIG_TASK_DELAY_ACCT=y
> > > CONFIG_TASK_XACCT=y
> > > CONFIG_TASK_IO_ACCOUNTING=y
> > > CONFIG_PSI=y
> > > # CONFIG_PSI_DEFAULT_DISABLED is not set
> > > # end of CPU/Task time and stats accounting
> > > 
> > > CONFIG_CPU_ISOLATION=y
> > > 
> > > #
> > > # RCU Subsystem
> > > #
> > > CONFIG_TREE_RCU=y
> > > # CONFIG_RCU_EXPERT is not set
> > > CONFIG_SRCU=y
> > > CONFIG_TREE_SRCU=y
> > > CONFIG_TASKS_RCU=y
> > > CONFIG_RCU_STALL_COMMON=y
> > > CONFIG_RCU_NEED_SEGCBLIST=y
> > > # end of RCU Subsystem
> > > 
> > > CONFIG_BUILD_BIN2C=y
> > > # CONFIG_IKCONFIG is not set
> > > CONFIG_IKHEADERS=m
> > > CONFIG_LOG_BUF_SHIFT=18
> > > CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> > > CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> > > CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> > > 
> > > #
> > > # Scheduler features
> > > #
> > > CONFIG_UCLAMP_TASK=y
> > > CONFIG_UCLAMP_BUCKETS_COUNT=5
> > > # end of Scheduler features
> > > 
> > > CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
> > > CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> > > CONFIG_ARCH_SUPPORTS_INT128=y
> > > CONFIG_NUMA_BALANCING=y
> > > CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
> > > CONFIG_CGROUPS=y
> > > CONFIG_PAGE_COUNTER=y
> > > CONFIG_MEMCG=y
> > > CONFIG_MEMCG_SWAP=y
> > > # CONFIG_MEMCG_SWAP_ENABLED is not set
> > > CONFIG_MEMCG_KMEM=y
> > > CONFIG_BLK_CGROUP=y
> > > CONFIG_CGROUP_WRITEBACK=y
> > > CONFIG_CGROUP_SCHED=y
> > > CONFIG_FAIR_GROUP_SCHED=y
> > > CONFIG_CFS_BANDWIDTH=y
> > > # CONFIG_RT_GROUP_SCHED is not set
> > > CONFIG_CGROUP_PIDS=y
> > > CONFIG_CGROUP_RDMA=y
> > > CONFIG_CGROUP_FREEZER=y
> > > CONFIG_CGROUP_HUGETLB=y
> > > CONFIG_CPUSETS=y
> > > CONFIG_PROC_PID_CPUSET=y
> > > CONFIG_CGROUP_DEVICE=y
> > > CONFIG_CGROUP_CPUACCT=y
> > > CONFIG_CGROUP_PERF=y
> > > CONFIG_CGROUP_BPF=y
> > > # CONFIG_CGROUP_DEBUG is not set
> > > CONFIG_SOCK_CGROUP_DATA=y
> > > CONFIG_NAMESPACES=y
> > > CONFIG_UTS_NS=y
> > > CONFIG_IPC_NS=y
> > > CONFIG_USER_NS=y
> > > CONFIG_PID_NS=y
> > > CONFIG_NET_NS=y
> > > CONFIG_CHECKPOINT_RESTORE=y
> > > CONFIG_SCHED_AUTOGROUP=y
> > > # CONFIG_SYSFS_DEPRECATED is not set
> > > CONFIG_RELAY=y
> > > CONFIG_BLK_DEV_INITRD=y
> > > CONFIG_INITRAMFS_SOURCE=""
> > > CONFIG_RD_GZIP=y
> > > CONFIG_RD_BZIP2=y
> > > CONFIG_RD_LZMA=y
> > > CONFIG_RD_XZ=y
> > > CONFIG_RD_LZO=y
> > > CONFIG_RD_LZ4=y
> > > CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> > > # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> > > CONFIG_SYSCTL=y
> > > CONFIG_HAVE_UID16=y
> > > CONFIG_SYSCTL_EXCEPTION_TRACE=y
> > > CONFIG_HAVE_PCSPKR_PLATFORM=y
> > > CONFIG_BPF=y
> > > CONFIG_EXPERT=y
> > > CONFIG_UID16=y
> > > CONFIG_MULTIUSER=y
> > > CONFIG_SGETMASK_SYSCALL=y
> > > CONFIG_SYSFS_SYSCALL=y
> > > # CONFIG_SYSCTL_SYSCALL is not set
> > > CONFIG_FHANDLE=y
> > > CONFIG_POSIX_TIMERS=y
> > > CONFIG_PRINTK=y
> > > CONFIG_PRINTK_NMI=y
> > > CONFIG_BUG=y
> > > CONFIG_ELF_CORE=y
> > > CONFIG_PCSPKR_PLATFORM=y
> > > CONFIG_BASE_FULL=y
> > > CONFIG_FUTEX=y
> > > CONFIG_FUTEX_PI=y
> > > CONFIG_EPOLL=y
> > > CONFIG_SIGNALFD=y
> > > CONFIG_TIMERFD=y
> > > CONFIG_EVENTFD=y
> > > CONFIG_SHMEM=y
> > > CONFIG_AIO=y
> > > CONFIG_IO_URING=y
> > > CONFIG_ADVISE_SYSCALLS=y
> > > CONFIG_MEMBARRIER=y
> > > CONFIG_KALLSYMS=y
> > > CONFIG_KALLSYMS_ALL=y
> > > CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
> > > CONFIG_KALLSYMS_BASE_RELATIVE=y
> > > CONFIG_BPF_SYSCALL=y
> > > CONFIG_BPF_JIT_ALWAYS_ON=y
> > > CONFIG_USERFAULTFD=y
> > > CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> > > CONFIG_RSEQ=y
> > > # CONFIG_DEBUG_RSEQ is not set
> > > # CONFIG_EMBEDDED is not set
> > > CONFIG_HAVE_PERF_EVENTS=y
> > > CONFIG_PC104=y
> > > 
> > > #
> > > # Kernel Performance Events And Counters
> > > #
> > > CONFIG_PERF_EVENTS=y
> > > # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> > > # end of Kernel Performance Events And Counters
> > > 
> > > CONFIG_VM_EVENT_COUNTERS=y
> > > CONFIG_SLUB_DEBUG=y
> > > CONFIG_SLUB_MEMCG_SYSFS_ON=y
> > > # CONFIG_COMPAT_BRK is not set
> > > # CONFIG_SLAB is not set
> > > CONFIG_SLUB=y
> > > # CONFIG_SLOB is not set
> > > CONFIG_SLAB_MERGE_DEFAULT=y
> > > CONFIG_SLAB_FREELIST_RANDOM=y
> > > CONFIG_SLAB_FREELIST_HARDENED=y
> > > CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
> > > CONFIG_SLUB_CPU_PARTIAL=y
> > > CONFIG_SYSTEM_DATA_VERIFICATION=y
> > > CONFIG_PROFILING=y
> > > CONFIG_TRACEPOINTS=y
> > > # end of General setup
> > > 
> > > CONFIG_64BIT=y
> > > CONFIG_X86_64=y
> > > CONFIG_X86=y
> > > CONFIG_INSTRUCTION_DECODER=y
> > > CONFIG_OUTPUT_FORMAT="elf64-x86-64"
> > > CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
> > > CONFIG_LOCKDEP_SUPPORT=y
> > > CONFIG_STACKTRACE_SUPPORT=y
> > > CONFIG_MMU=y
> > > CONFIG_ARCH_MMAP_RND_BITS_MIN=28
> > > CONFIG_ARCH_MMAP_RND_BITS_MAX=32
> > > CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> > > CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> > > CONFIG_GENERIC_ISA_DMA=y
> > > CONFIG_GENERIC_BUG=y
> > > CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
> > > CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> > > CONFIG_GENERIC_CALIBRATE_DELAY=y
> > > CONFIG_ARCH_HAS_CPU_RELAX=y
> > > CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> > > CONFIG_ARCH_HAS_FILTER_PGPROT=y
> > > CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> > > CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> > > CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> > > CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> > > CONFIG_ARCH_SUSPEND_POSSIBLE=y
> > > CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> > > CONFIG_ZONE_DMA32=y
> > > CONFIG_AUDIT_ARCH=y
> > > CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> > > CONFIG_HAVE_INTEL_TXT=y
> > > CONFIG_X86_64_SMP=y
> > > CONFIG_ARCH_SUPPORTS_UPROBES=y
> > > CONFIG_FIX_EARLYCON_MEM=y
> > > CONFIG_DYNAMIC_PHYSICAL_MASK=y
> > > CONFIG_PGTABLE_LEVELS=4
> > > CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> > > 
> > > #
> > > # Processor type and features
> > > #
> > > CONFIG_ZONE_DMA=y
> > > CONFIG_SMP=y
> > > CONFIG_X86_FEATURE_NAMES=y
> > > CONFIG_X86_X2APIC=y
> > > CONFIG_X86_MPPARSE=y
> > > # CONFIG_GOLDFISH is not set
> > > CONFIG_RETPOLINE=y
> > > CONFIG_X86_CPU_RESCTRL=y
> > > CONFIG_X86_EXTENDED_PLATFORM=y
> > > CONFIG_X86_NUMACHIP=y
> > > # CONFIG_X86_VSMP is not set
> > > # CONFIG_X86_UV is not set
> > > # CONFIG_X86_GOLDFISH is not set
> > > # CONFIG_X86_INTEL_MID is not set
> > > CONFIG_X86_INTEL_LPSS=y
> > > CONFIG_X86_AMD_PLATFORM_DEVICE=y
> > > CONFIG_IOSF_MBI=y
> > > CONFIG_IOSF_MBI_DEBUG=y
> > > CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
> > > CONFIG_SCHED_OMIT_FRAME_POINTER=y
> > > CONFIG_HYPERVISOR_GUEST=y
> > > CONFIG_PARAVIRT=y
> > > CONFIG_PARAVIRT_XXL=y
> > > # CONFIG_PARAVIRT_DEBUG is not set
> > > CONFIG_PARAVIRT_SPINLOCKS=y
> > > CONFIG_X86_HV_CALLBACK_VECTOR=y
> > > CONFIG_XEN=y
> > > CONFIG_XEN_PV=y
> > > CONFIG_XEN_PV_SMP=y
> > > CONFIG_XEN_DOM0=y
> > > CONFIG_XEN_PVHVM=y
> > > CONFIG_XEN_PVHVM_SMP=y
> > > CONFIG_XEN_512GB=y
> > > CONFIG_XEN_SAVE_RESTORE=y
> > > # CONFIG_XEN_DEBUG_FS is not set
> > > CONFIG_XEN_PVH=y
> > > CONFIG_KVM_GUEST=y
> > > CONFIG_PVH=y
> > > CONFIG_KVM_DEBUG_FS=y
> > > # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> > > CONFIG_PARAVIRT_CLOCK=y
> > > CONFIG_JAILHOUSE_GUEST=y
> > > CONFIG_ACRN_GUEST=y
> > > # CONFIG_MK8 is not set
> > > # CONFIG_MPSC is not set
> > > # CONFIG_MCORE2 is not set
> > > # CONFIG_MATOM is not set
> > > CONFIG_GENERIC_CPU=y
> > > CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> > > CONFIG_X86_L1_CACHE_SHIFT=6
> > > CONFIG_X86_TSC=y
> > > CONFIG_X86_CMPXCHG64=y
> > > CONFIG_X86_CMOV=y
> > > CONFIG_X86_MINIMUM_CPU_FAMILY=64
> > > CONFIG_X86_DEBUGCTLMSR=y
> > > CONFIG_PROCESSOR_SELECT=y
> > > CONFIG_CPU_SUP_INTEL=y
> > > CONFIG_CPU_SUP_AMD=y
> > > CONFIG_CPU_SUP_HYGON=y
> > > CONFIG_CPU_SUP_CENTAUR=y
> > > CONFIG_CPU_SUP_ZHAOXIN=y
> > > CONFIG_HPET_TIMER=y
> > > CONFIG_HPET_EMULATE_RTC=y
> > > CONFIG_DMI=y
> > > CONFIG_GART_IOMMU=y
> > > CONFIG_CALGARY_IOMMU=y
> > > CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT=y
> > > CONFIG_MAXSMP=y
> > > CONFIG_NR_CPUS_RANGE_BEGIN=8192
> > > CONFIG_NR_CPUS_RANGE_END=8192
> > > CONFIG_NR_CPUS_DEFAULT=8192
> > > CONFIG_NR_CPUS=8192
> > > CONFIG_SCHED_SMT=y
> > > CONFIG_SCHED_MC=y
> > > CONFIG_SCHED_MC_PRIO=y
> > > CONFIG_X86_LOCAL_APIC=y
> > > CONFIG_X86_IO_APIC=y
> > > CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
> > > CONFIG_X86_MCE=y
> > > CONFIG_X86_MCELOG_LEGACY=y
> > > CONFIG_X86_MCE_INTEL=y
> > > CONFIG_X86_MCE_AMD=y
> > > CONFIG_X86_MCE_THRESHOLD=y
> > > CONFIG_X86_MCE_INJECT=m
> > > CONFIG_X86_THERMAL_VECTOR=y
> > > 
> > > #
> > > # Performance monitoring
> > > #
> > > CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> > > CONFIG_PERF_EVENTS_INTEL_RAPL=m
> > > CONFIG_PERF_EVENTS_INTEL_CSTATE=m
> > > # CONFIG_PERF_EVENTS_AMD_POWER is not set
> > > # end of Performance monitoring
> > > 
> > > CONFIG_X86_16BIT=y
> > > CONFIG_X86_ESPFIX64=y
> > > CONFIG_X86_VSYSCALL_EMULATION=y
> > > CONFIG_I8K=m
> > > CONFIG_MICROCODE=y
> > > CONFIG_MICROCODE_INTEL=y
> > > CONFIG_MICROCODE_AMD=y
> > > CONFIG_MICROCODE_OLD_INTERFACE=y
> > > CONFIG_X86_MSR=m
> > > CONFIG_X86_CPUID=m
> > > # CONFIG_X86_5LEVEL is not set
> > > CONFIG_X86_DIRECT_GBPAGES=y
> > > # CONFIG_X86_CPA_STATISTICS is not set
> > > CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> > > CONFIG_AMD_MEM_ENCRYPT=y
> > > # CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
> > > CONFIG_NUMA=y
> > > CONFIG_AMD_NUMA=y
> > > CONFIG_X86_64_ACPI_NUMA=y
> > > CONFIG_NODES_SPAN_OTHER_NODES=y
> > > # CONFIG_NUMA_EMU is not set
> > > CONFIG_NODES_SHIFT=10
> > > CONFIG_ARCH_SPARSEMEM_ENABLE=y
> > > CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> > > CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> > > CONFIG_ARCH_MEMORY_PROBE=y
> > > CONFIG_ARCH_PROC_KCORE_TEXT=y
> > > CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
> > > CONFIG_X86_PMEM_LEGACY_DEVICE=y
> > > CONFIG_X86_PMEM_LEGACY=y
> > > CONFIG_X86_CHECK_BIOS_CORRUPTION=y
> > > CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
> > > CONFIG_X86_RESERVE_LOW=64
> > > CONFIG_MTRR=y
> > > CONFIG_MTRR_SANITIZER=y
> > > CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
> > > CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
> > > CONFIG_X86_PAT=y
> > > CONFIG_ARCH_USES_PG_UNCACHED=y
> > > CONFIG_ARCH_RANDOM=y
> > > CONFIG_X86_SMAP=y
> > > CONFIG_X86_INTEL_UMIP=y
> > > CONFIG_X86_INTEL_MPX=y
> > > CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
> > > CONFIG_X86_INTEL_TSX_MODE_OFF=y
> > > # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> > > # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> > > CONFIG_EFI=y
> > > CONFIG_EFI_STUB=y
> > > CONFIG_EFI_MIXED=y
> > > CONFIG_SECCOMP=y
> > > # CONFIG_HZ_100 is not set
> > > CONFIG_HZ_250=y
> > > # CONFIG_HZ_300 is not set
> > > # CONFIG_HZ_1000 is not set
> > > CONFIG_HZ=250
> > > CONFIG_SCHED_HRTICK=y
> > > CONFIG_KEXEC=y
> > > CONFIG_KEXEC_FILE=y
> > > CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
> > > CONFIG_KEXEC_SIG=y
> > > # CONFIG_KEXEC_SIG_FORCE is not set
> > > CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y
> > > CONFIG_CRASH_DUMP=y
> > > CONFIG_KEXEC_JUMP=y
> > > CONFIG_PHYSICAL_START=0x1000000
> > > CONFIG_RELOCATABLE=y
> > > CONFIG_RANDOMIZE_BASE=y
> > > CONFIG_X86_NEED_RELOCS=y
> > > CONFIG_PHYSICAL_ALIGN=0x200000
> > > CONFIG_DYNAMIC_MEMORY_LAYOUT=y
> > > CONFIG_RANDOMIZE_MEMORY=y
> > > CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
> > > CONFIG_HOTPLUG_CPU=y
> > > # CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
> > > # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
> > > # CONFIG_COMPAT_VDSO is not set
> > > # CONFIG_LEGACY_VSYSCALL_EMULATE is not set
> > > CONFIG_LEGACY_VSYSCALL_XONLY=y
> > > # CONFIG_LEGACY_VSYSCALL_NONE is not set
> > > # CONFIG_CMDLINE_BOOL is not set
> > > CONFIG_MODIFY_LDT_SYSCALL=y
> > > CONFIG_HAVE_LIVEPATCH=y
> > > CONFIG_LIVEPATCH=y
> > > # end of Processor type and features
> > > 
> > > CONFIG_ARCH_HAS_ADD_PAGES=y
> > > CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> > > CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
> > > CONFIG_USE_PERCPU_NUMA_NODE_ID=y
> > > CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> > > CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
> > > CONFIG_ARCH_ENABLE_THP_MIGRATION=y
> > > 
> > > #
> > > # Power management and ACPI options
> > > #
> > > CONFIG_ARCH_HIBERNATION_HEADER=y
> > > CONFIG_SUSPEND=y
> > > CONFIG_SUSPEND_FREEZER=y
> > > # CONFIG_SUSPEND_SKIP_SYNC is not set
> > > CONFIG_HIBERNATE_CALLBACKS=y
> > > CONFIG_HIBERNATION=y
> > > CONFIG_PM_STD_PARTITION=""
> > > CONFIG_PM_SLEEP=y
> > > CONFIG_PM_SLEEP_SMP=y
> > > # CONFIG_PM_AUTOSLEEP is not set
> > > CONFIG_PM_WAKELOCKS=y
> > > CONFIG_PM_WAKELOCKS_LIMIT=100
> > > CONFIG_PM_WAKELOCKS_GC=y
> > > CONFIG_PM=y
> > > CONFIG_PM_DEBUG=y
> > > CONFIG_PM_ADVANCED_DEBUG=y
> > > # CONFIG_PM_TEST_SUSPEND is not set
> > > CONFIG_PM_SLEEP_DEBUG=y
> > > # CONFIG_DPM_WATCHDOG is not set
> > > CONFIG_PM_TRACE=y
> > > CONFIG_PM_TRACE_RTC=y
> > > CONFIG_PM_CLK=y
> > > CONFIG_PM_GENERIC_DOMAINS=y
> > > CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
> > > CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
> > > # CONFIG_ENERGY_MODEL is not set
> > > CONFIG_ARCH_SUPPORTS_ACPI=y
> > > CONFIG_ACPI=y
> > > CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> > > CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> > > CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> > > CONFIG_ACPI_DEBUGGER=y
> > > CONFIG_ACPI_DEBUGGER_USER=y
> > > CONFIG_ACPI_SPCR_TABLE=y
> > > CONFIG_ACPI_LPIT=y
> > > CONFIG_ACPI_SLEEP=y
> > > # CONFIG_ACPI_PROCFS_POWER is not set
> > > CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> > > CONFIG_ACPI_EC_DEBUGFS=m
> > > CONFIG_ACPI_AC=y
> > > CONFIG_ACPI_BATTERY=y
> > > CONFIG_ACPI_BUTTON=y
> > > CONFIG_ACPI_VIDEO=m
> > > CONFIG_ACPI_FAN=y
> > > CONFIG_ACPI_TAD=m
> > > CONFIG_ACPI_DOCK=y
> > > CONFIG_ACPI_CPU_FREQ_PSS=y
> > > CONFIG_ACPI_PROCESSOR_CSTATE=y
> > > CONFIG_ACPI_PROCESSOR_IDLE=y
> > > CONFIG_ACPI_CPPC_LIB=y
> > > CONFIG_ACPI_PROCESSOR=y
> > > CONFIG_ACPI_IPMI=m
> > > CONFIG_ACPI_HOTPLUG_CPU=y
> > > CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
> > > CONFIG_ACPI_THERMAL=y
> > > CONFIG_ACPI_NUMA=y
> > > CONFIG_ACPI_CUSTOM_DSDT_FILE=""
> > > CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> > > CONFIG_ACPI_TABLE_UPGRADE=y
> > > CONFIG_ACPI_DEBUG=y
> > > CONFIG_ACPI_PCI_SLOT=y
> > > CONFIG_ACPI_CONTAINER=y
> > > CONFIG_ACPI_HOTPLUG_MEMORY=y
> > > CONFIG_ACPI_HOTPLUG_IOAPIC=y
> > > CONFIG_ACPI_SBS=m
> > > CONFIG_ACPI_HED=y
> > > # CONFIG_ACPI_CUSTOM_METHOD is not set
> > > CONFIG_ACPI_BGRT=y
> > > # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> > > CONFIG_ACPI_NFIT=m
> > > # CONFIG_NFIT_SECURITY_DEBUG is not set
> > > CONFIG_ACPI_HMAT=y
> > > CONFIG_HAVE_ACPI_APEI=y
> > > CONFIG_HAVE_ACPI_APEI_NMI=y
> > > CONFIG_ACPI_APEI=y
> > > CONFIG_ACPI_APEI_GHES=y
> > > CONFIG_ACPI_APEI_PCIEAER=y
> > > CONFIG_ACPI_APEI_MEMORY_FAILURE=y
> > > CONFIG_ACPI_APEI_EINJ=m
> > > # CONFIG_ACPI_APEI_ERST_DEBUG is not set
> > > CONFIG_DPTF_POWER=m
> > > CONFIG_ACPI_WATCHDOG=y
> > > CONFIG_ACPI_EXTLOG=m
> > > CONFIG_ACPI_ADXL=y
> > > # CONFIG_PMIC_OPREGION is not set
> > > CONFIG_ACPI_CONFIGFS=m
> > > CONFIG_TPS68470_PMIC_OPREGION=y
> > > CONFIG_X86_PM_TIMER=y
> > > CONFIG_SFI=y
> > > 
> > > #
> > > # CPU Frequency scaling
> > > #
> > > CONFIG_CPU_FREQ=y
> > > CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> > > CONFIG_CPU_FREQ_GOV_COMMON=y
> > > CONFIG_CPU_FREQ_STAT=y
> > > CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> > > # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> > > # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> > > # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
> > > # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
> > > # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> > > CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> > > CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> > > CONFIG_CPU_FREQ_GOV_USERSPACE=y
> > > CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> > > CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> > > CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
> > > 
> > > #
> > > # CPU frequency scaling drivers
> > > #
> > > CONFIG_X86_INTEL_PSTATE=y
> > > CONFIG_X86_PCC_CPUFREQ=y
> > > CONFIG_X86_ACPI_CPUFREQ=y
> > > CONFIG_X86_ACPI_CPUFREQ_CPB=y
> > > CONFIG_X86_POWERNOW_K8=y
> > > CONFIG_X86_AMD_FREQ_SENSITIVITY=m
> > > CONFIG_X86_SPEEDSTEP_CENTRINO=y
> > > CONFIG_X86_P4_CLOCKMOD=m
> > > 
> > > #
> > > # shared options
> > > #
> > > CONFIG_X86_SPEEDSTEP_LIB=m
> > > # end of CPU Frequency scaling
> > > 
> > > #
> > > # CPU Idle
> > > #
> > > CONFIG_CPU_IDLE=y
> > > CONFIG_CPU_IDLE_GOV_LADDER=y
> > > CONFIG_CPU_IDLE_GOV_MENU=y
> > > CONFIG_CPU_IDLE_GOV_TEO=y
> > > # end of CPU Idle
> > > 
> > > CONFIG_INTEL_IDLE=y
> > > # end of Power management and ACPI options
> > > 
> > > #
> > > # Bus options (PCI etc.)
> > > #
> > > CONFIG_PCI_DIRECT=y
> > > CONFIG_PCI_MMCONFIG=y
> > > CONFIG_PCI_XEN=y
> > > CONFIG_MMCONF_FAM10H=y
> > > # CONFIG_PCI_CNB20LE_QUIRK is not set
> > > CONFIG_ISA_BUS=y
> > > CONFIG_ISA_DMA_API=y
> > > CONFIG_AMD_NB=y
> > > # CONFIG_X86_SYSFB is not set
> > > # end of Bus options (PCI etc.)
> > > 
> > > #
> > > # Binary Emulations
> > > #
> > > CONFIG_IA32_EMULATION=y
> > > CONFIG_X86_X32=y
> > > CONFIG_COMPAT_32=y
> > > CONFIG_COMPAT=y
> > > CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
> > > CONFIG_SYSVIPC_COMPAT=y
> > > # end of Binary Emulations
> > > 
> > > CONFIG_X86_DEV_DMA_OPS=y
> > > 
> > > #
> > > # Firmware Drivers
> > > #
> > > CONFIG_EDD=y
> > > CONFIG_EDD_OFF=y
> > > CONFIG_FIRMWARE_MEMMAP=y
> > > CONFIG_DMIID=y
> > > CONFIG_DMI_SYSFS=m
> > > CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> > > CONFIG_ISCSI_IBFT_FIND=y
> > > CONFIG_ISCSI_IBFT=m
> > > CONFIG_FW_CFG_SYSFS=m
> > > # CONFIG_FW_CFG_SYSFS_CMDLINE is not set
> > > # CONFIG_GOOGLE_FIRMWARE is not set
> > > 
> > > #
> > > # EFI (Extensible Firmware Interface) Support
> > > #
> > > CONFIG_EFI_VARS=y
> > > CONFIG_EFI_ESRT=y
> > > CONFIG_EFI_VARS_PSTORE=m
> > > # CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
> > > CONFIG_EFI_RUNTIME_MAP=y
> > > # CONFIG_EFI_FAKE_MEMMAP is not set
> > > CONFIG_EFI_RUNTIME_WRAPPERS=y
> > > CONFIG_EFI_BOOTLOADER_CONTROL=m
> > > CONFIG_EFI_CAPSULE_LOADER=m
> > > CONFIG_EFI_TEST=m
> > > CONFIG_APPLE_PROPERTIES=y
> > > CONFIG_RESET_ATTACK_MITIGATION=y
> > > # end of EFI (Extensible Firmware Interface) Support
> > > 
> > > CONFIG_UEFI_CPER=y
> > > CONFIG_UEFI_CPER_X86=y
> > > CONFIG_EFI_DEV_PATH_PARSER=y
> > > CONFIG_EFI_EARLYCON=y
> > > 
> > > #
> > > # Tegra firmware driver
> > > #
> > > # end of Tegra firmware driver
> > > # end of Firmware Drivers
> > > 
> > > CONFIG_HAVE_KVM=y
> > > CONFIG_HAVE_KVM_IRQCHIP=y
> > > CONFIG_HAVE_KVM_IRQFD=y
> > > CONFIG_HAVE_KVM_IRQ_ROUTING=y
> > > CONFIG_HAVE_KVM_EVENTFD=y
> > > CONFIG_KVM_MMIO=y
> > > CONFIG_KVM_ASYNC_PF=y
> > > CONFIG_HAVE_KVM_MSI=y
> > > CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
> > > CONFIG_KVM_VFIO=y
> > > CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
> > > CONFIG_KVM_COMPAT=y
> > > CONFIG_HAVE_KVM_IRQ_BYPASS=y
> > > CONFIG_HAVE_KVM_NO_POLL=y
> > > CONFIG_VIRTUALIZATION=y
> > > CONFIG_KVM=m
> > > CONFIG_KVM_INTEL=m
> > > CONFIG_KVM_AMD=m
> > > CONFIG_KVM_AMD_SEV=y
> > > # CONFIG_KVM_MMU_AUDIT is not set
> > > CONFIG_VHOST_NET=m
> > > CONFIG_VHOST_SCSI=m
> > > CONFIG_VHOST_VSOCK=m
> > > CONFIG_VHOST=m
> > > # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
> > > 
> > > #
> > > # General architecture-dependent options
> > > #
> > > CONFIG_CRASH_CORE=y
> > > CONFIG_KEXEC_CORE=y
> > > CONFIG_HOTPLUG_SMT=y
> > > CONFIG_OPROFILE=m
> > > # CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
> > > CONFIG_HAVE_OPROFILE=y
> > > CONFIG_OPROFILE_NMI_TIMER=y
> > > CONFIG_KPROBES=y
> > > CONFIG_JUMP_LABEL=y
> > > # CONFIG_STATIC_KEYS_SELFTEST is not set
> > > CONFIG_OPTPROBES=y
> > > CONFIG_KPROBES_ON_FTRACE=y
> > > CONFIG_UPROBES=y
> > > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> > > CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> > > CONFIG_KRETPROBES=y
> > > CONFIG_USER_RETURN_NOTIFIER=y
> > > CONFIG_HAVE_IOREMAP_PROT=y
> > > CONFIG_HAVE_KPROBES=y
> > > CONFIG_HAVE_KRETPROBES=y
> > > CONFIG_HAVE_OPTPROBES=y
> > > CONFIG_HAVE_KPROBES_ON_FTRACE=y
> > > CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> > > CONFIG_HAVE_NMI=y
> > > CONFIG_HAVE_ARCH_TRACEHOOK=y
> > > CONFIG_HAVE_DMA_CONTIGUOUS=y
> > > CONFIG_GENERIC_SMP_IDLE_THREAD=y
> > > CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> > > CONFIG_ARCH_HAS_SET_MEMORY=y
> > > CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
> > > CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> > > CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> > > CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> > > CONFIG_HAVE_RSEQ=y
> > > CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
> > > CONFIG_HAVE_CLK=y
> > > CONFIG_HAVE_HW_BREAKPOINT=y
> > > CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> > > CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> > > CONFIG_HAVE_PERF_EVENTS_NMI=y
> > > CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> > > CONFIG_HAVE_PERF_REGS=y
> > > CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> > > CONFIG_HAVE_ARCH_JUMP_LABEL=y
> > > CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
> > > CONFIG_HAVE_RCU_TABLE_FREE=y
> > > CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> > > CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
> > > CONFIG_HAVE_CMPXCHG_LOCAL=y
> > > CONFIG_HAVE_CMPXCHG_DOUBLE=y
> > > CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
> > > CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
> > > CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> > > CONFIG_SECCOMP_FILTER=y
> > > CONFIG_HAVE_ARCH_STACKLEAK=y
> > > CONFIG_HAVE_STACKPROTECTOR=y
> > > CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
> > > CONFIG_STACKPROTECTOR=y
> > > CONFIG_STACKPROTECTOR_STRONG=y
> > > CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> > > CONFIG_HAVE_CONTEXT_TRACKING=y
> > > CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> > > CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> > > CONFIG_HAVE_MOVE_PMD=y
> > > CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> > > CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
> > > CONFIG_HAVE_ARCH_HUGE_VMAP=y
> > > CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> > > CONFIG_HAVE_ARCH_SOFT_DIRTY=y
> > > CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> > > CONFIG_MODULES_USE_ELF_RELA=y
> > > CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
> > > CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> > > CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> > > CONFIG_HAVE_EXIT_THREAD=y
> > > CONFIG_ARCH_MMAP_RND_BITS=28
> > > CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
> > > CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
> > > CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
> > > CONFIG_HAVE_COPY_THREAD_TLS=y
> > > CONFIG_HAVE_STACK_VALIDATION=y
> > > CONFIG_HAVE_RELIABLE_STACKTRACE=y
> > > CONFIG_ISA_BUS_API=y
> > > CONFIG_OLD_SIGSUSPEND3=y
> > > CONFIG_COMPAT_OLD_SIGACTION=y
> > > CONFIG_64BIT_TIME=y
> > > CONFIG_COMPAT_32BIT_TIME=y
> > > CONFIG_HAVE_ARCH_VMAP_STACK=y
> > > CONFIG_VMAP_STACK=y
> > > CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> > > CONFIG_STRICT_KERNEL_RWX=y
> > > CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> > > CONFIG_STRICT_MODULE_RWX=y
> > > CONFIG_ARCH_HAS_REFCOUNT=y
> > > # CONFIG_REFCOUNT_FULL is not set
> > > CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
> > > CONFIG_ARCH_USE_MEMREMAP_PROT=y
> > > # CONFIG_LOCK_EVENT_COUNTS is not set
> > > 
> > > #
> > > # GCOV-based kernel profiling
> > > #
> > > # CONFIG_GCOV_KERNEL is not set
> > > CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> > > # end of GCOV-based kernel profiling
> > > 
> > > CONFIG_PLUGIN_HOSTCC=""
> > > CONFIG_HAVE_GCC_PLUGINS=y
> > > # end of General architecture-dependent options
> > > 
> > > CONFIG_RT_MUTEXES=y
> > > CONFIG_BASE_SMALL=0
> > > CONFIG_MODULES=y
> > > # CONFIG_MODULE_FORCE_LOAD is not set
> > > CONFIG_MODULE_UNLOAD=y
> > > # CONFIG_MODULE_FORCE_UNLOAD is not set
> > > # CONFIG_MODVERSIONS is not set
> > > CONFIG_MODULE_SRCVERSION_ALL=y
> > > CONFIG_MODULE_SIG=y
> > > # CONFIG_MODULE_SIG_FORCE is not set
> > > CONFIG_MODULE_SIG_ALL=y
> > > # CONFIG_MODULE_SIG_SHA1 is not set
> > > # CONFIG_MODULE_SIG_SHA224 is not set
> > > # CONFIG_MODULE_SIG_SHA256 is not set
> > > # CONFIG_MODULE_SIG_SHA384 is not set
> > > CONFIG_MODULE_SIG_SHA512=y
> > > CONFIG_MODULE_SIG_HASH="sha512"
> > > # CONFIG_MODULE_COMPRESS is not set
> > > CONFIG_MODULES_TREE_LOOKUP=y
> > > CONFIG_BLOCK=y
> > > CONFIG_BLK_SCSI_REQUEST=y
> > > CONFIG_BLK_DEV_BSG=y
> > > CONFIG_BLK_DEV_BSGLIB=y
> > > CONFIG_BLK_DEV_INTEGRITY=y
> > > CONFIG_BLK_DEV_ZONED=y
> > > CONFIG_BLK_DEV_THROTTLING=y
> > > # CONFIG_BLK_DEV_THROTTLING_LOW is not set
> > > CONFIG_BLK_CMDLINE_PARSER=y
> > > CONFIG_BLK_WBT=y
> > > # CONFIG_BLK_CGROUP_IOLATENCY is not set
> > > CONFIG_BLK_WBT_MQ=y
> > > CONFIG_BLK_DEBUG_FS=y
> > > CONFIG_BLK_DEBUG_FS_ZONED=y
> > > CONFIG_BLK_SED_OPAL=y
> > > 
> > > #
> > > # Partition Types
> > > #
> > > CONFIG_PARTITION_ADVANCED=y
> > > # CONFIG_ACORN_PARTITION is not set
> > > CONFIG_AIX_PARTITION=y
> > > CONFIG_OSF_PARTITION=y
> > > CONFIG_AMIGA_PARTITION=y
> > > CONFIG_ATARI_PARTITION=y
> > > CONFIG_MAC_PARTITION=y
> > > CONFIG_MSDOS_PARTITION=y
> > > CONFIG_BSD_DISKLABEL=y
> > > CONFIG_MINIX_SUBPARTITION=y
> > > CONFIG_SOLARIS_X86_PARTITION=y
> > > CONFIG_UNIXWARE_DISKLABEL=y
> > > CONFIG_LDM_PARTITION=y
> > > # CONFIG_LDM_DEBUG is not set
> > > CONFIG_SGI_PARTITION=y
> > > CONFIG_ULTRIX_PARTITION=y
> > > CONFIG_SUN_PARTITION=y
> > > CONFIG_KARMA_PARTITION=y
> > > CONFIG_EFI_PARTITION=y
> > > CONFIG_SYSV68_PARTITION=y
> > > CONFIG_CMDLINE_PARTITION=y
> > > # end of Partition Types
> > > 
> > > CONFIG_BLOCK_COMPAT=y
> > > CONFIG_BLK_MQ_PCI=y
> > > CONFIG_BLK_MQ_VIRTIO=y
> > > CONFIG_BLK_MQ_RDMA=y
> > > CONFIG_BLK_PM=y
> > > 
> > > #
> > > # IO Schedulers
> > > #
> > > CONFIG_MQ_IOSCHED_DEADLINE=y
> > > CONFIG_MQ_IOSCHED_KYBER=m
> > > CONFIG_IOSCHED_BFQ=m
> > > CONFIG_BFQ_GROUP_IOSCHED=y
> > > # CONFIG_BFQ_CGROUP_DEBUG is not set
> > > # end of IO Schedulers
> > > 
> > > CONFIG_PREEMPT_NOTIFIERS=y
> > > CONFIG_PADATA=y
> > > CONFIG_ASN1=y
> > > CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
> > > CONFIG_INLINE_READ_UNLOCK=y
> > > CONFIG_INLINE_READ_UNLOCK_IRQ=y
> > > CONFIG_INLINE_WRITE_UNLOCK=y
> > > CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
> > > CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> > > CONFIG_MUTEX_SPIN_ON_OWNER=y
> > > CONFIG_RWSEM_SPIN_ON_OWNER=y
> > > CONFIG_LOCK_SPIN_ON_OWNER=y
> > > CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> > > CONFIG_QUEUED_SPINLOCKS=y
> > > CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> > > CONFIG_QUEUED_RWLOCKS=y
> > > CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> > > CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> > > CONFIG_FREEZER=y
> > > 
> > > #
> > > # Executable file formats
> > > #
> > > CONFIG_BINFMT_ELF=y
> > > CONFIG_COMPAT_BINFMT_ELF=y
> > > CONFIG_ELFCORE=y
> > > CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
> > > CONFIG_BINFMT_SCRIPT=y
> > > CONFIG_BINFMT_MISC=m
> > > CONFIG_COREDUMP=y
> > > # end of Executable file formats
> > > 
> > > #
> > > # Memory Management options
> > > #
> > > CONFIG_SELECT_MEMORY_MODEL=y
> > > CONFIG_SPARSEMEM_MANUAL=y
> > > CONFIG_SPARSEMEM=y
> > > CONFIG_NEED_MULTIPLE_NODES=y
> > > CONFIG_HAVE_MEMORY_PRESENT=y
> > > CONFIG_SPARSEMEM_EXTREME=y
> > > CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> > > CONFIG_SPARSEMEM_VMEMMAP=y
> > > CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
> > > CONFIG_HAVE_FAST_GUP=y
> > > CONFIG_MEMORY_ISOLATION=y
> > > CONFIG_HAVE_BOOTMEM_INFO_NODE=y
> > > CONFIG_MEMORY_HOTPLUG=y
> > > CONFIG_MEMORY_HOTPLUG_SPARSE=y
> > > CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
> > > CONFIG_MEMORY_HOTREMOVE=y
> > > CONFIG_SPLIT_PTLOCK_CPUS=4
> > > CONFIG_MEMORY_BALLOON=y
> > > CONFIG_BALLOON_COMPACTION=y
> > > CONFIG_COMPACTION=y
> > > CONFIG_MIGRATION=y
> > > CONFIG_CONTIG_ALLOC=y
> > > CONFIG_PHYS_ADDR_T_64BIT=y
> > > CONFIG_BOUNCE=y
> > > CONFIG_VIRT_TO_BUS=y
> > > CONFIG_MMU_NOTIFIER=y
> > > CONFIG_KSM=y
> > > CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
> > > CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
> > > CONFIG_MEMORY_FAILURE=y
> > > CONFIG_HWPOISON_INJECT=m
> > > CONFIG_TRANSPARENT_HUGEPAGE=y
> > > # CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
> > > CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
> > > CONFIG_ARCH_WANTS_THP_SWAP=y
> > > CONFIG_THP_SWAP=y
> > > CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
> > > CONFIG_CLEANCACHE=y
> > > CONFIG_FRONTSWAP=y
> > > CONFIG_CMA=y
> > > # CONFIG_CMA_DEBUG is not set
> > > # CONFIG_CMA_DEBUGFS is not set
> > > CONFIG_CMA_AREAS=7
> > > CONFIG_MEM_SOFT_DIRTY=y
> > > CONFIG_ZSWAP=y
> > > CONFIG_ZPOOL=y
> > > CONFIG_ZBUD=y
> > > CONFIG_Z3FOLD=m
> > > CONFIG_ZSMALLOC=y
> > > CONFIG_PGTABLE_MAPPING=y
> > > # CONFIG_ZSMALLOC_STAT is not set
> > > CONFIG_GENERIC_EARLY_IOREMAP=y
> > > # CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
> > > CONFIG_IDLE_PAGE_TRACKING=y
> > > CONFIG_ARCH_HAS_PTE_DEVMAP=y
> > > CONFIG_ZONE_DEVICE=y
> > > CONFIG_DEV_PAGEMAP_OPS=y
> > > CONFIG_HMM_MIRROR=y
> > > CONFIG_DEVICE_PRIVATE=y
> > > CONFIG_FRAME_VECTOR=y
> > > CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
> > > CONFIG_ARCH_HAS_PKEYS=y
> > > # CONFIG_PERCPU_STATS is not set
> > > # CONFIG_GUP_BENCHMARK is not set
> > > CONFIG_ARCH_HAS_PTE_SPECIAL=y
> > > # end of Memory Management options
> > > 
> > > CONFIG_NET=y
> > > CONFIG_COMPAT_NETLINK_MESSAGES=y
> > > CONFIG_NET_INGRESS=y
> > > CONFIG_NET_EGRESS=y
> > > CONFIG_SKB_EXTENSIONS=y
> > > 
> > > #
> > > # Networking options
> > > #
> > > CONFIG_PACKET=y
> > > CONFIG_PACKET_DIAG=m
> > > CONFIG_UNIX=y
> > > CONFIG_UNIX_SCM=y
> > > CONFIG_UNIX_DIAG=m
> > > CONFIG_TLS=m
> > > CONFIG_TLS_DEVICE=y
> > > CONFIG_XFRM=y
> > > CONFIG_XFRM_OFFLOAD=y
> > > CONFIG_XFRM_ALGO=m
> > > CONFIG_XFRM_USER=m
> > > CONFIG_XFRM_INTERFACE=m
> > > # CONFIG_XFRM_SUB_POLICY is not set
> > > # CONFIG_XFRM_MIGRATE is not set
> > > CONFIG_XFRM_STATISTICS=y
> > > CONFIG_XFRM_IPCOMP=m
> > > CONFIG_NET_KEY=m
> > > # CONFIG_NET_KEY_MIGRATE is not set
> > > CONFIG_SMC=m
> > > CONFIG_SMC_DIAG=m
> > > CONFIG_XDP_SOCKETS=y
> > > CONFIG_XDP_SOCKETS_DIAG=m
> > > CONFIG_INET=y
> > > CONFIG_IP_MULTICAST=y
> > > CONFIG_IP_ADVANCED_ROUTER=y
> > > CONFIG_IP_FIB_TRIE_STATS=y
> > > CONFIG_IP_MULTIPLE_TABLES=y
> > > CONFIG_IP_ROUTE_MULTIPATH=y
> > > CONFIG_IP_ROUTE_VERBOSE=y
> > > CONFIG_IP_ROUTE_CLASSID=y
> > > # CONFIG_IP_PNP is not set
> > > CONFIG_NET_IPIP=m
> > > CONFIG_NET_IPGRE_DEMUX=m
> > > CONFIG_NET_IP_TUNNEL=m
> > > CONFIG_NET_IPGRE=m
> > > CONFIG_NET_IPGRE_BROADCAST=y
> > > CONFIG_IP_MROUTE_COMMON=y
> > > CONFIG_IP_MROUTE=y
> > > # CONFIG_IP_MROUTE_MULTIPLE_TABLES is not set
> > > CONFIG_IP_PIMSM_V1=y
> > > CONFIG_IP_PIMSM_V2=y
> > > CONFIG_SYN_COOKIES=y
> > > CONFIG_NET_IPVTI=m
> > > CONFIG_NET_UDP_TUNNEL=m
> > > CONFIG_NET_FOU=m
> > > CONFIG_NET_FOU_IP_TUNNELS=y
> > > CONFIG_INET_AH=m
> > > CONFIG_INET_ESP=m
> > > CONFIG_INET_ESP_OFFLOAD=m
> > > CONFIG_INET_IPCOMP=m
> > > CONFIG_INET_XFRM_TUNNEL=m
> > > CONFIG_INET_TUNNEL=m
> > > CONFIG_INET_DIAG=m
> > > CONFIG_INET_TCP_DIAG=m
> > > CONFIG_INET_UDP_DIAG=m
> > > CONFIG_INET_RAW_DIAG=m
> > > CONFIG_INET_DIAG_DESTROY=y
> > > CONFIG_TCP_CONG_ADVANCED=y
> > > CONFIG_TCP_CONG_BIC=m
> > > CONFIG_TCP_CONG_CUBIC=y
> > > CONFIG_TCP_CONG_WESTWOOD=m
> > > CONFIG_TCP_CONG_HTCP=m
> > > CONFIG_TCP_CONG_HSTCP=m
> > > CONFIG_TCP_CONG_HYBLA=m
> > > CONFIG_TCP_CONG_VEGAS=m
> > > CONFIG_TCP_CONG_NV=m
> > > CONFIG_TCP_CONG_SCALABLE=m
> > > CONFIG_TCP_CONG_LP=m
> > > CONFIG_TCP_CONG_VENO=m
> > > CONFIG_TCP_CONG_YEAH=m
> > > CONFIG_TCP_CONG_ILLINOIS=m
> > > CONFIG_TCP_CONG_DCTCP=m
> > > CONFIG_TCP_CONG_CDG=m
> > > CONFIG_TCP_CONG_BBR=m
> > > CONFIG_DEFAULT_CUBIC=y
> > > # CONFIG_DEFAULT_RENO is not set
> > > CONFIG_DEFAULT_TCP_CONG="cubic"
> > > CONFIG_TCP_MD5SIG=y
> > > CONFIG_IPV6=y
> > > CONFIG_IPV6_ROUTER_PREF=y
> > > CONFIG_IPV6_ROUTE_INFO=y
> > > # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> > > CONFIG_INET6_AH=m
> > > CONFIG_INET6_ESP=m
> > > CONFIG_INET6_ESP_OFFLOAD=m
> > > CONFIG_INET6_IPCOMP=m
> > > CONFIG_IPV6_MIP6=m
> > > CONFIG_IPV6_ILA=m
> > > CONFIG_INET6_XFRM_TUNNEL=m
> > > CONFIG_INET6_TUNNEL=m
> > > CONFIG_IPV6_VTI=m
> > > CONFIG_IPV6_SIT=m
> > > CONFIG_IPV6_SIT_6RD=y
> > > CONFIG_IPV6_NDISC_NODETYPE=y
> > > CONFIG_IPV6_TUNNEL=m
> > > CONFIG_IPV6_GRE=m
> > > CONFIG_IPV6_FOU=m
> > > CONFIG_IPV6_FOU_TUNNEL=m
> > > CONFIG_IPV6_MULTIPLE_TABLES=y
> > > CONFIG_IPV6_SUBTREES=y
> > > CONFIG_IPV6_MROUTE=y
> > > CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
> > > CONFIG_IPV6_PIMSM_V2=y
> > > CONFIG_IPV6_SEG6_LWTUNNEL=y
> > > CONFIG_IPV6_SEG6_HMAC=y
> > > CONFIG_IPV6_SEG6_BPF=y
> > > CONFIG_NETLABEL=y
> > > CONFIG_NETWORK_SECMARK=y
> > > CONFIG_NET_PTP_CLASSIFY=y
> > > CONFIG_NETWORK_PHY_TIMESTAMPING=y
> > > CONFIG_NETFILTER=y
> > > CONFIG_NETFILTER_ADVANCED=y
> > > CONFIG_BRIDGE_NETFILTER=m
> > > 
> > > #
> > > # Core Netfilter Configuration
> > > #
> > > CONFIG_NETFILTER_INGRESS=y
> > > CONFIG_NETFILTER_NETLINK=m
> > > CONFIG_NETFILTER_FAMILY_BRIDGE=y
> > > CONFIG_NETFILTER_FAMILY_ARP=y
> > > CONFIG_NETFILTER_NETLINK_ACCT=m
> > > CONFIG_NETFILTER_NETLINK_QUEUE=m
> > > CONFIG_NETFILTER_NETLINK_LOG=m
> > > CONFIG_NETFILTER_NETLINK_OSF=m
> > > CONFIG_NF_CONNTRACK=m
> > > CONFIG_NF_LOG_COMMON=m
> > > CONFIG_NF_LOG_NETDEV=m
> > > CONFIG_NETFILTER_CONNCOUNT=m
> > > CONFIG_NF_CONNTRACK_MARK=y
> > > CONFIG_NF_CONNTRACK_SECMARK=y
> > > CONFIG_NF_CONNTRACK_ZONES=y
> > > # CONFIG_NF_CONNTRACK_PROCFS is not set
> > > CONFIG_NF_CONNTRACK_EVENTS=y
> > > CONFIG_NF_CONNTRACK_TIMEOUT=y
> > > CONFIG_NF_CONNTRACK_TIMESTAMP=y
> > > CONFIG_NF_CONNTRACK_LABELS=y
> > > CONFIG_NF_CT_PROTO_DCCP=y
> > > CONFIG_NF_CT_PROTO_GRE=y
> > > CONFIG_NF_CT_PROTO_SCTP=y
> > > CONFIG_NF_CT_PROTO_UDPLITE=y
> > > CONFIG_NF_CONNTRACK_AMANDA=m
> > > CONFIG_NF_CONNTRACK_FTP=m
> > > CONFIG_NF_CONNTRACK_H323=m
> > > CONFIG_NF_CONNTRACK_IRC=m
> > > CONFIG_NF_CONNTRACK_BROADCAST=m
> > > CONFIG_NF_CONNTRACK_NETBIOS_NS=m
> > > CONFIG_NF_CONNTRACK_SNMP=m
> > > CONFIG_NF_CONNTRACK_PPTP=m
> > > CONFIG_NF_CONNTRACK_SANE=m
> > > CONFIG_NF_CONNTRACK_SIP=m
> > > CONFIG_NF_CONNTRACK_TFTP=m
> > > CONFIG_NF_CT_NETLINK=m
> > > CONFIG_NF_CT_NETLINK_TIMEOUT=m
> > > CONFIG_NF_CT_NETLINK_HELPER=m
> > > CONFIG_NETFILTER_NETLINK_GLUE_CT=y
> > > CONFIG_NF_NAT=m
> > > CONFIG_NF_NAT_AMANDA=m
> > > CONFIG_NF_NAT_FTP=m
> > > CONFIG_NF_NAT_IRC=m
> > > CONFIG_NF_NAT_SIP=m
> > > CONFIG_NF_NAT_TFTP=m
> > > CONFIG_NF_NAT_REDIRECT=y
> > > CONFIG_NF_NAT_MASQUERADE=y
> > > CONFIG_NETFILTER_SYNPROXY=m
> > > CONFIG_NF_TABLES=m
> > > CONFIG_NF_TABLES_SET=m
> > > CONFIG_NF_TABLES_INET=y
> > > CONFIG_NF_TABLES_NETDEV=y
> > > CONFIG_NFT_NUMGEN=m
> > > CONFIG_NFT_CT=m
> > > CONFIG_NFT_FLOW_OFFLOAD=m
> > > CONFIG_NFT_COUNTER=m
> > > CONFIG_NFT_CONNLIMIT=m
> > > CONFIG_NFT_LOG=m
> > > CONFIG_NFT_LIMIT=m
> > > CONFIG_NFT_MASQ=m
> > > CONFIG_NFT_REDIR=m
> > > CONFIG_NFT_NAT=m
> > > CONFIG_NFT_TUNNEL=m
> > > CONFIG_NFT_OBJREF=m
> > > CONFIG_NFT_QUEUE=m
> > > CONFIG_NFT_QUOTA=m
> > > CONFIG_NFT_REJECT=m
> > > CONFIG_NFT_REJECT_INET=m
> > > CONFIG_NFT_COMPAT=m
> > > CONFIG_NFT_HASH=m
> > > CONFIG_NFT_FIB=m
> > > CONFIG_NFT_FIB_INET=m
> > > CONFIG_NFT_XFRM=m
> > > CONFIG_NFT_SOCKET=m
> > > CONFIG_NFT_OSF=m
> > > CONFIG_NFT_TPROXY=m
> > > CONFIG_NFT_SYNPROXY=m
> > > CONFIG_NF_DUP_NETDEV=m
> > > CONFIG_NFT_DUP_NETDEV=m
> > > CONFIG_NFT_FWD_NETDEV=m
> > > CONFIG_NFT_FIB_NETDEV=m
> > > CONFIG_NF_FLOW_TABLE_INET=m
> > > CONFIG_NF_FLOW_TABLE=m
> > > CONFIG_NETFILTER_XTABLES=m
> > > 
> > > #
> > > # Xtables combined modules
> > > #
> > > CONFIG_NETFILTER_XT_MARK=m
> > > CONFIG_NETFILTER_XT_CONNMARK=m
> > > CONFIG_NETFILTER_XT_SET=m
> > > 
> > > #
> > > # Xtables targets
> > > #
> > > CONFIG_NETFILTER_XT_TARGET_AUDIT=m
> > > CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
> > > CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
> > > CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
> > > CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
> > > CONFIG_NETFILTER_XT_TARGET_CT=m
> > > CONFIG_NETFILTER_XT_TARGET_DSCP=m
> > > CONFIG_NETFILTER_XT_TARGET_HL=m
> > > CONFIG_NETFILTER_XT_TARGET_HMARK=m
> > > CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
> > > CONFIG_NETFILTER_XT_TARGET_LED=m
> > > CONFIG_NETFILTER_XT_TARGET_LOG=m
> > > CONFIG_NETFILTER_XT_TARGET_MARK=m
> > > CONFIG_NETFILTER_XT_NAT=m
> > > CONFIG_NETFILTER_XT_TARGET_NETMAP=m
> > > CONFIG_NETFILTER_XT_TARGET_NFLOG=m
> > > CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
> > > # CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
> > > CONFIG_NETFILTER_XT_TARGET_RATEEST=m
> > > CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
> > > CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
> > > CONFIG_NETFILTER_XT_TARGET_TEE=m
> > > CONFIG_NETFILTER_XT_TARGET_TPROXY=m
> > > CONFIG_NETFILTER_XT_TARGET_TRACE=m
> > > CONFIG_NETFILTER_XT_TARGET_SECMARK=m
> > > CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
> > > CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m
> > > 
> > > #
> > > # Xtables matches
> > > #
> > > CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
> > > CONFIG_NETFILTER_XT_MATCH_BPF=m
> > > CONFIG_NETFILTER_XT_MATCH_CGROUP=m
> > > CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
> > > CONFIG_NETFILTER_XT_MATCH_COMMENT=m
> > > CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
> > > CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
> > > CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
> > > CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
> > > CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
> > > CONFIG_NETFILTER_XT_MATCH_CPU=m
> > > CONFIG_NETFILTER_XT_MATCH_DCCP=m
> > > CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
> > > CONFIG_NETFILTER_XT_MATCH_DSCP=m
> > > CONFIG_NETFILTER_XT_MATCH_ECN=m
> > > CONFIG_NETFILTER_XT_MATCH_ESP=m
> > > CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
> > > CONFIG_NETFILTER_XT_MATCH_HELPER=m
> > > CONFIG_NETFILTER_XT_MATCH_HL=m
> > > CONFIG_NETFILTER_XT_MATCH_IPCOMP=m
> > > CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
> > > CONFIG_NETFILTER_XT_MATCH_IPVS=m
> > > CONFIG_NETFILTER_XT_MATCH_L2TP=m
> > > CONFIG_NETFILTER_XT_MATCH_LENGTH=m
> > > CONFIG_NETFILTER_XT_MATCH_LIMIT=m
> > > CONFIG_NETFILTER_XT_MATCH_MAC=m
> > > CONFIG_NETFILTER_XT_MATCH_MARK=m
> > > CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
> > > CONFIG_NETFILTER_XT_MATCH_NFACCT=m
> > > CONFIG_NETFILTER_XT_MATCH_OSF=m
> > > CONFIG_NETFILTER_XT_MATCH_OWNER=m
> > > CONFIG_NETFILTER_XT_MATCH_POLICY=m
> > > CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
> > > CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
> > > CONFIG_NETFILTER_XT_MATCH_QUOTA=m
> > > CONFIG_NETFILTER_XT_MATCH_RATEEST=m
> > > CONFIG_NETFILTER_XT_MATCH_REALM=m
> > > CONFIG_NETFILTER_XT_MATCH_RECENT=m
> > > CONFIG_NETFILTER_XT_MATCH_SCTP=m
> > > CONFIG_NETFILTER_XT_MATCH_SOCKET=m
> > > CONFIG_NETFILTER_XT_MATCH_STATE=m
> > > CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
> > > CONFIG_NETFILTER_XT_MATCH_STRING=m
> > > CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
> > > CONFIG_NETFILTER_XT_MATCH_TIME=m
> > > CONFIG_NETFILTER_XT_MATCH_U32=m
> > > # end of Core Netfilter Configuration
> > > 
> > > CONFIG_IP_SET=m
> > > CONFIG_IP_SET_MAX=256
> > > CONFIG_IP_SET_BITMAP_IP=m
> > > CONFIG_IP_SET_BITMAP_IPMAC=m
> > > CONFIG_IP_SET_BITMAP_PORT=m
> > > CONFIG_IP_SET_HASH_IP=m
> > > CONFIG_IP_SET_HASH_IPMARK=m
> > > CONFIG_IP_SET_HASH_IPPORT=m
> > > CONFIG_IP_SET_HASH_IPPORTIP=m
> > > CONFIG_IP_SET_HASH_IPPORTNET=m
> > > CONFIG_IP_SET_HASH_IPMAC=m
> > > CONFIG_IP_SET_HASH_MAC=m
> > > CONFIG_IP_SET_HASH_NETPORTNET=m
> > > CONFIG_IP_SET_HASH_NET=m
> > > CONFIG_IP_SET_HASH_NETNET=m
> > > CONFIG_IP_SET_HASH_NETPORT=m
> > > CONFIG_IP_SET_HASH_NETIFACE=m
> > > CONFIG_IP_SET_LIST_SET=m
> > > CONFIG_IP_VS=m
> > > CONFIG_IP_VS_IPV6=y
> > > # CONFIG_IP_VS_DEBUG is not set
> > > CONFIG_IP_VS_TAB_BITS=12
> > > 
> > > #
> > > # IPVS transport protocol load balancing support
> > > #
> > > CONFIG_IP_VS_PROTO_TCP=y
> > > CONFIG_IP_VS_PROTO_UDP=y
> > > CONFIG_IP_VS_PROTO_AH_ESP=y
> > > CONFIG_IP_VS_PROTO_ESP=y
> > > CONFIG_IP_VS_PROTO_AH=y
> > > CONFIG_IP_VS_PROTO_SCTP=y
> > > 
> > > #
> > > # IPVS scheduler
> > > #
> > > CONFIG_IP_VS_RR=m
> > > CONFIG_IP_VS_WRR=m
> > > CONFIG_IP_VS_LC=m
> > > CONFIG_IP_VS_WLC=m
> > > CONFIG_IP_VS_FO=m
> > > CONFIG_IP_VS_OVF=m
> > > CONFIG_IP_VS_LBLC=m
> > > CONFIG_IP_VS_LBLCR=m
> > > CONFIG_IP_VS_DH=m
> > > CONFIG_IP_VS_SH=m
> > > CONFIG_IP_VS_MH=m
> > > CONFIG_IP_VS_SED=m
> > > CONFIG_IP_VS_NQ=m
> > > 
> > > #
> > > # IPVS SH scheduler
> > > #
> > > CONFIG_IP_VS_SH_TAB_BITS=8
> > > 
> > > #
> > > # IPVS MH scheduler
> > > #
> > > CONFIG_IP_VS_MH_TAB_INDEX=12
> > > 
> > > #
> > > # IPVS application helper
> > > #
> > > CONFIG_IP_VS_FTP=m
> > > CONFIG_IP_VS_NFCT=y
> > > CONFIG_IP_VS_PE_SIP=m
> > > 
> > > #
> > > # IP: Netfilter Configuration
> > > #
> > > CONFIG_NF_DEFRAG_IPV4=m
> > > CONFIG_NF_SOCKET_IPV4=m
> > > CONFIG_NF_TPROXY_IPV4=m
> > > CONFIG_NF_TABLES_IPV4=y
> > > CONFIG_NFT_REJECT_IPV4=m
> > > CONFIG_NFT_DUP_IPV4=m
> > > CONFIG_NFT_FIB_IPV4=m
> > > CONFIG_NF_TABLES_ARP=y
> > > CONFIG_NF_FLOW_TABLE_IPV4=m
> > > CONFIG_NF_DUP_IPV4=m
> > > CONFIG_NF_LOG_ARP=m
> > > CONFIG_NF_LOG_IPV4=m
> > > CONFIG_NF_REJECT_IPV4=m
> > > CONFIG_NF_NAT_SNMP_BASIC=m
> > > CONFIG_NF_NAT_PPTP=m
> > > CONFIG_NF_NAT_H323=m
> > > CONFIG_IP_NF_IPTABLES=m
> > > CONFIG_IP_NF_MATCH_AH=m
> > > CONFIG_IP_NF_MATCH_ECN=m
> > > CONFIG_IP_NF_MATCH_RPFILTER=m
> > > CONFIG_IP_NF_MATCH_TTL=m
> > > CONFIG_IP_NF_FILTER=m
> > > CONFIG_IP_NF_TARGET_REJECT=m
> > > CONFIG_IP_NF_TARGET_SYNPROXY=m
> > > CONFIG_IP_NF_NAT=m
> > > CONFIG_IP_NF_TARGET_MASQUERADE=m
> > > CONFIG_IP_NF_TARGET_NETMAP=m
> > > CONFIG_IP_NF_TARGET_REDIRECT=m
> > > CONFIG_IP_NF_MANGLE=m
> > > CONFIG_IP_NF_TARGET_CLUSTERIP=m
> > > CONFIG_IP_NF_TARGET_ECN=m
> > > CONFIG_IP_NF_TARGET_TTL=m
> > > CONFIG_IP_NF_RAW=m
> > > CONFIG_IP_NF_SECURITY=m
> > > CONFIG_IP_NF_ARPTABLES=m
> > > CONFIG_IP_NF_ARPFILTER=m
> > > CONFIG_IP_NF_ARP_MANGLE=m
> > > # end of IP: Netfilter Configuration
> > > 
> > > #
> > > # IPv6: Netfilter Configuration
> > > #
> > > CONFIG_NF_SOCKET_IPV6=m
> > > CONFIG_NF_TPROXY_IPV6=m
> > > CONFIG_NF_TABLES_IPV6=y
> > > CONFIG_NFT_REJECT_IPV6=m
> > > CONFIG_NFT_DUP_IPV6=m
> > > CONFIG_NFT_FIB_IPV6=m
> > > CONFIG_NF_FLOW_TABLE_IPV6=m
> > > CONFIG_NF_DUP_IPV6=m
> > > CONFIG_NF_REJECT_IPV6=m
> > > CONFIG_NF_LOG_IPV6=m
> > > CONFIG_IP6_NF_IPTABLES=m
> > > CONFIG_IP6_NF_MATCH_AH=m
> > > CONFIG_IP6_NF_MATCH_EUI64=m
> > > CONFIG_IP6_NF_MATCH_FRAG=m
> > > CONFIG_IP6_NF_MATCH_OPTS=m
> > > CONFIG_IP6_NF_MATCH_HL=m
> > > CONFIG_IP6_NF_MATCH_IPV6HEADER=m
> > > CONFIG_IP6_NF_MATCH_MH=m
> > > CONFIG_IP6_NF_MATCH_RPFILTER=m
> > > CONFIG_IP6_NF_MATCH_RT=m
> > > CONFIG_IP6_NF_MATCH_SRH=m
> > > CONFIG_IP6_NF_TARGET_HL=m
> > > CONFIG_IP6_NF_FILTER=m
> > > CONFIG_IP6_NF_TARGET_REJECT=m
> > > CONFIG_IP6_NF_TARGET_SYNPROXY=m
> > > CONFIG_IP6_NF_MANGLE=m
> > > CONFIG_IP6_NF_RAW=m
> > > CONFIG_IP6_NF_SECURITY=m
> > > CONFIG_IP6_NF_NAT=m
> > > CONFIG_IP6_NF_TARGET_MASQUERADE=m
> > > CONFIG_IP6_NF_TARGET_NPT=m
> > > # end of IPv6: Netfilter Configuration
> > > 
> > > CONFIG_NF_DEFRAG_IPV6=m
> > > 
> > > #
> > > # DECnet: Netfilter Configuration
> > > #
> > > CONFIG_DECNET_NF_GRABULATOR=m
> > > # end of DECnet: Netfilter Configuration
> > > 
> > > CONFIG_NF_TABLES_BRIDGE=m
> > > CONFIG_NFT_BRIDGE_META=m
> > > CONFIG_NFT_BRIDGE_REJECT=m
> > > CONFIG_NF_LOG_BRIDGE=m
> > > CONFIG_NF_CONNTRACK_BRIDGE=m
> > > CONFIG_BRIDGE_NF_EBTABLES=m
> > > CONFIG_BRIDGE_EBT_BROUTE=m
> > > CONFIG_BRIDGE_EBT_T_FILTER=m
> > > CONFIG_BRIDGE_EBT_T_NAT=m
> > > CONFIG_BRIDGE_EBT_802_3=m
> > > CONFIG_BRIDGE_EBT_AMONG=m
> > > CONFIG_BRIDGE_EBT_ARP=m
> > > CONFIG_BRIDGE_EBT_IP=m
> > > CONFIG_BRIDGE_EBT_IP6=m
> > > CONFIG_BRIDGE_EBT_LIMIT=m
> > > CONFIG_BRIDGE_EBT_MARK=m
> > > CONFIG_BRIDGE_EBT_PKTTYPE=m
> > > CONFIG_BRIDGE_EBT_STP=m
> > > CONFIG_BRIDGE_EBT_VLAN=m
> > > CONFIG_BRIDGE_EBT_ARPREPLY=m
> > > CONFIG_BRIDGE_EBT_DNAT=m
> > > CONFIG_BRIDGE_EBT_MARK_T=m
> > > CONFIG_BRIDGE_EBT_REDIRECT=m
> > > CONFIG_BRIDGE_EBT_SNAT=m
> > > CONFIG_BRIDGE_EBT_LOG=m
> > > CONFIG_BRIDGE_EBT_NFLOG=m
> > > CONFIG_BPFILTER=y
> > > CONFIG_BPFILTER_UMH=m
> > > CONFIG_IP_DCCP=m
> > > CONFIG_INET_DCCP_DIAG=m
> > > 
> > > #
> > > # DCCP CCIDs Configuration
> > > #
> > > # CONFIG_IP_DCCP_CCID2_DEBUG is not set
> > > # CONFIG_IP_DCCP_CCID3 is not set
> > > # end of DCCP CCIDs Configuration
> > > 
> > > #
> > > # DCCP Kernel Hacking
> > > #
> > > # CONFIG_IP_DCCP_DEBUG is not set
> > > # end of DCCP Kernel Hacking
> > > 
> > > CONFIG_IP_SCTP=m
> > > # CONFIG_SCTP_DBG_OBJCNT is not set
> > > # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
> > > CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
> > > # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
> > > CONFIG_SCTP_COOKIE_HMAC_MD5=y
> > > CONFIG_SCTP_COOKIE_HMAC_SHA1=y
> > > CONFIG_INET_SCTP_DIAG=m
> > > CONFIG_RDS=m
> > > CONFIG_RDS_RDMA=m
> > > CONFIG_RDS_TCP=m
> > > # CONFIG_RDS_DEBUG is not set
> > > CONFIG_TIPC=m
> > > CONFIG_TIPC_MEDIA_IB=y
> > > CONFIG_TIPC_MEDIA_UDP=y
> > > CONFIG_TIPC_DIAG=m
> > > CONFIG_ATM=m
> > > CONFIG_ATM_CLIP=m
> > > # CONFIG_ATM_CLIP_NO_ICMP is not set
> > > CONFIG_ATM_LANE=m
> > > CONFIG_ATM_MPOA=m
> > > CONFIG_ATM_BR2684=m
> > > # CONFIG_ATM_BR2684_IPFILTER is not set
> > > CONFIG_L2TP=m
> > > CONFIG_L2TP_DEBUGFS=m
> > > CONFIG_L2TP_V3=y
> > > CONFIG_L2TP_IP=m
> > > CONFIG_L2TP_ETH=m
> > > CONFIG_STP=m
> > > CONFIG_GARP=m
> > > CONFIG_MRP=m
> > > CONFIG_BRIDGE=m
> > > CONFIG_BRIDGE_IGMP_SNOOPING=y
> > > CONFIG_BRIDGE_VLAN_FILTERING=y
> > > CONFIG_HAVE_NET_DSA=y
> > > CONFIG_NET_DSA=m
> > > CONFIG_NET_DSA_TAG_8021Q=m
> > > CONFIG_NET_DSA_TAG_BRCM_COMMON=m
> > > CONFIG_NET_DSA_TAG_BRCM=m
> > > CONFIG_NET_DSA_TAG_BRCM_PREPEND=m
> > > CONFIG_NET_DSA_TAG_GSWIP=m
> > > CONFIG_NET_DSA_TAG_DSA=m
> > > CONFIG_NET_DSA_TAG_EDSA=m
> > > CONFIG_NET_DSA_TAG_MTK=m
> > > CONFIG_NET_DSA_TAG_KSZ_COMMON=m
> > > CONFIG_NET_DSA_TAG_KSZ=m
> > > CONFIG_NET_DSA_TAG_KSZ9477=m
> > > CONFIG_NET_DSA_TAG_QCA=m
> > > CONFIG_NET_DSA_TAG_LAN9303=m
> > > CONFIG_NET_DSA_TAG_SJA1105=m
> > > CONFIG_NET_DSA_TAG_TRAILER=m
> > > CONFIG_VLAN_8021Q=m
> > > CONFIG_VLAN_8021Q_GVRP=y
> > > CONFIG_VLAN_8021Q_MVRP=y
> > > CONFIG_DECNET=m
> > > # CONFIG_DECNET_ROUTER is not set
> > > CONFIG_LLC=m
> > > CONFIG_LLC2=m
> > > CONFIG_ATALK=m
> > > CONFIG_DEV_APPLETALK=m
> > > CONFIG_LTPC=m
> > > CONFIG_COPS=m
> > > CONFIG_COPS_DAYNA=y
> > > CONFIG_COPS_TANGENT=y
> > > # CONFIG_IPDDP is not set
> > > CONFIG_X25=m
> > > CONFIG_LAPB=m
> > > CONFIG_PHONET=m
> > > CONFIG_6LOWPAN=m
> > > # CONFIG_6LOWPAN_DEBUGFS is not set
> > > CONFIG_6LOWPAN_NHC=m
> > > CONFIG_6LOWPAN_NHC_DEST=m
> > > CONFIG_6LOWPAN_NHC_FRAGMENT=m
> > > CONFIG_6LOWPAN_NHC_HOP=m
> > > CONFIG_6LOWPAN_NHC_IPV6=m
> > > CONFIG_6LOWPAN_NHC_MOBILITY=m
> > > CONFIG_6LOWPAN_NHC_ROUTING=m
> > > CONFIG_6LOWPAN_NHC_UDP=m
> > > # CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
> > > # CONFIG_6LOWPAN_GHC_UDP is not set
> > > # CONFIG_6LOWPAN_GHC_ICMPV6 is not set
> > > # CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
> > > # CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
> > > # CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
> > > CONFIG_IEEE802154=m
> > > # CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
> > > CONFIG_IEEE802154_SOCKET=m
> > > CONFIG_IEEE802154_6LOWPAN=m
> > > CONFIG_MAC802154=m
> > > CONFIG_NET_SCHED=y
> > > 
> > > #
> > > # Queueing/Scheduling
> > > #
> > > CONFIG_NET_SCH_CBQ=m
> > > CONFIG_NET_SCH_HTB=m
> > > CONFIG_NET_SCH_HFSC=m
> > > CONFIG_NET_SCH_ATM=m
> > > CONFIG_NET_SCH_PRIO=m
> > > CONFIG_NET_SCH_MULTIQ=m
> > > CONFIG_NET_SCH_RED=m
> > > CONFIG_NET_SCH_SFB=m
> > > CONFIG_NET_SCH_SFQ=m
> > > CONFIG_NET_SCH_TEQL=m
> > > CONFIG_NET_SCH_TBF=m
> > > CONFIG_NET_SCH_CBS=m
> > > CONFIG_NET_SCH_ETF=m
> > > CONFIG_NET_SCH_TAPRIO=m
> > > CONFIG_NET_SCH_GRED=m
> > > CONFIG_NET_SCH_DSMARK=m
> > > CONFIG_NET_SCH_NETEM=m
> > > CONFIG_NET_SCH_DRR=m
> > > CONFIG_NET_SCH_MQPRIO=m
> > > CONFIG_NET_SCH_SKBPRIO=m
> > > CONFIG_NET_SCH_CHOKE=m
> > > CONFIG_NET_SCH_QFQ=m
> > > CONFIG_NET_SCH_CODEL=m
> > > CONFIG_NET_SCH_FQ_CODEL=m
> > > CONFIG_NET_SCH_CAKE=m
> > > CONFIG_NET_SCH_FQ=m
> > > CONFIG_NET_SCH_HHF=m
> > > CONFIG_NET_SCH_PIE=m
> > > CONFIG_NET_SCH_INGRESS=m
> > > CONFIG_NET_SCH_PLUG=m
> > > # CONFIG_NET_SCH_DEFAULT is not set
> > > 
> > > #
> > > # Classification
> > > #
> > > CONFIG_NET_CLS=y
> > > CONFIG_NET_CLS_BASIC=m
> > > CONFIG_NET_CLS_TCINDEX=m
> > > CONFIG_NET_CLS_ROUTE4=m
> > > CONFIG_NET_CLS_FW=m
> > > CONFIG_NET_CLS_U32=m
> > > # CONFIG_CLS_U32_PERF is not set
> > > CONFIG_CLS_U32_MARK=y
> > > CONFIG_NET_CLS_RSVP=m
> > > CONFIG_NET_CLS_RSVP6=m
> > > CONFIG_NET_CLS_FLOW=m
> > > CONFIG_NET_CLS_CGROUP=m
> > > CONFIG_NET_CLS_BPF=m
> > > CONFIG_NET_CLS_FLOWER=m
> > > CONFIG_NET_CLS_MATCHALL=m
> > > CONFIG_NET_EMATCH=y
> > > CONFIG_NET_EMATCH_STACK=32
> > > CONFIG_NET_EMATCH_CMP=m
> > > CONFIG_NET_EMATCH_NBYTE=m
> > > CONFIG_NET_EMATCH_U32=m
> > > CONFIG_NET_EMATCH_META=m
> > > CONFIG_NET_EMATCH_TEXT=m
> > > CONFIG_NET_EMATCH_CANID=m
> > > CONFIG_NET_EMATCH_IPSET=m
> > > CONFIG_NET_EMATCH_IPT=m
> > > CONFIG_NET_CLS_ACT=y
> > > CONFIG_NET_ACT_POLICE=m
> > > CONFIG_NET_ACT_GACT=m
> > > CONFIG_GACT_PROB=y
> > > CONFIG_NET_ACT_MIRRED=m
> > > CONFIG_NET_ACT_SAMPLE=m
> > > CONFIG_NET_ACT_IPT=m
> > > CONFIG_NET_ACT_NAT=m
> > > CONFIG_NET_ACT_PEDIT=m
> > > CONFIG_NET_ACT_SIMP=m
> > > CONFIG_NET_ACT_SKBEDIT=m
> > > CONFIG_NET_ACT_CSUM=m
> > > CONFIG_NET_ACT_MPLS=m
> > > CONFIG_NET_ACT_VLAN=m
> > > CONFIG_NET_ACT_BPF=m
> > > CONFIG_NET_ACT_CONNMARK=m
> > > CONFIG_NET_ACT_CTINFO=m
> > > CONFIG_NET_ACT_SKBMOD=m
> > > # CONFIG_NET_ACT_IFE is not set
> > > CONFIG_NET_ACT_TUNNEL_KEY=m
> > > CONFIG_NET_ACT_CT=m
> > > CONFIG_NET_SCH_FIFO=y
> > > CONFIG_DCB=y
> > > CONFIG_DNS_RESOLVER=y
> > > CONFIG_BATMAN_ADV=m
> > > # CONFIG_BATMAN_ADV_BATMAN_V is not set
> > > CONFIG_BATMAN_ADV_BLA=y
> > > CONFIG_BATMAN_ADV_DAT=y
> > > CONFIG_BATMAN_ADV_NC=y
> > > CONFIG_BATMAN_ADV_MCAST=y
> > > # CONFIG_BATMAN_ADV_DEBUGFS is not set
> > > # CONFIG_BATMAN_ADV_DEBUG is not set
> > > CONFIG_BATMAN_ADV_SYSFS=y
> > > # CONFIG_BATMAN_ADV_TRACING is not set
> > > CONFIG_OPENVSWITCH=m
> > > CONFIG_OPENVSWITCH_GRE=m
> > > CONFIG_OPENVSWITCH_VXLAN=m
> > > CONFIG_OPENVSWITCH_GENEVE=m
> > > CONFIG_VSOCKETS=m
> > > CONFIG_VSOCKETS_DIAG=m
> > > CONFIG_VMWARE_VMCI_VSOCKETS=m
> > > CONFIG_VIRTIO_VSOCKETS=m
> > > CONFIG_VIRTIO_VSOCKETS_COMMON=m
> > > CONFIG_HYPERV_VSOCKETS=m
> > > CONFIG_NETLINK_DIAG=m
> > > CONFIG_MPLS=y
> > > CONFIG_NET_MPLS_GSO=m
> > > CONFIG_MPLS_ROUTING=m
> > > CONFIG_MPLS_IPTUNNEL=m
> > > CONFIG_NET_NSH=m
> > > CONFIG_HSR=m
> > > CONFIG_NET_SWITCHDEV=y
> > > CONFIG_NET_L3_MASTER_DEV=y
> > > CONFIG_NET_NCSI=y
> > > CONFIG_NCSI_OEM_CMD_GET_MAC=y
> > > CONFIG_RPS=y
> > > CONFIG_RFS_ACCEL=y
> > > CONFIG_XPS=y
> > > CONFIG_CGROUP_NET_PRIO=y
> > > CONFIG_CGROUP_NET_CLASSID=y
> > > CONFIG_NET_RX_BUSY_POLL=y
> > > CONFIG_BQL=y
> > > CONFIG_BPF_JIT=y
> > > CONFIG_BPF_STREAM_PARSER=y
> > > CONFIG_NET_FLOW_LIMIT=y
> > > 
> > > #
> > > # Network testing
> > > #
> > > CONFIG_NET_PKTGEN=m
> > > CONFIG_NET_DROP_MONITOR=m
> > > # end of Network testing
> > > # end of Networking options
> > > 
> > > CONFIG_HAMRADIO=y
> > > 
> > > #
> > > # Packet Radio protocols
> > > #
> > > CONFIG_AX25=m
> > > CONFIG_AX25_DAMA_SLAVE=y
> > > CONFIG_NETROM=m
> > > CONFIG_ROSE=m
> > > 
> > > #
> > > # AX.25 network device drivers
> > > #
> > > CONFIG_MKISS=m
> > > CONFIG_6PACK=m
> > > CONFIG_BPQETHER=m
> > > CONFIG_BAYCOM_SER_FDX=m
> > > CONFIG_BAYCOM_SER_HDX=m
> > > CONFIG_BAYCOM_PAR=m
> > > CONFIG_YAM=m
> > > # end of AX.25 network device drivers
> > > 
> > > CONFIG_CAN=m
> > > CONFIG_CAN_RAW=m
> > > CONFIG_CAN_BCM=m
> > > CONFIG_CAN_GW=m
> > > 
> > > #
> > > # CAN Device Drivers
> > > #
> > > CONFIG_CAN_VCAN=m
> > > CONFIG_CAN_VXCAN=m
> > > CONFIG_CAN_SLCAN=m
> > > CONFIG_CAN_DEV=m
> > > CONFIG_CAN_CALC_BITTIMING=y
> > > CONFIG_CAN_JANZ_ICAN3=m
> > > CONFIG_CAN_C_CAN=m
> > > CONFIG_CAN_C_CAN_PLATFORM=m
> > > CONFIG_CAN_C_CAN_PCI=m
> > > CONFIG_CAN_CC770=m
> > > CONFIG_CAN_CC770_ISA=m
> > > CONFIG_CAN_CC770_PLATFORM=m
> > > CONFIG_CAN_IFI_CANFD=m
> > > CONFIG_CAN_M_CAN=m
> > > CONFIG_CAN_PEAK_PCIEFD=m
> > > CONFIG_CAN_SJA1000=m
> > > CONFIG_CAN_SJA1000_ISA=m
> > > CONFIG_CAN_SJA1000_PLATFORM=m
> > > CONFIG_CAN_EMS_PCMCIA=m
> > > CONFIG_CAN_EMS_PCI=m
> > > CONFIG_CAN_PEAK_PCMCIA=m
> > > CONFIG_CAN_PEAK_PCI=m
> > > CONFIG_CAN_PEAK_PCIEC=y
> > > CONFIG_CAN_KVASER_PCI=m
> > > CONFIG_CAN_PLX_PCI=m
> > > CONFIG_CAN_SOFTING=m
> > > CONFIG_CAN_SOFTING_CS=m
> > > 
> > > #
> > > # CAN SPI interfaces
> > > #
> > > CONFIG_CAN_HI311X=m
> > > CONFIG_CAN_MCP251X=m
> > > # end of CAN SPI interfaces
> > > 
> > > #
> > > # CAN USB interfaces
> > > #
> > > CONFIG_CAN_8DEV_USB=m
> > > CONFIG_CAN_EMS_USB=m
> > > CONFIG_CAN_ESD_USB2=m
> > > CONFIG_CAN_GS_USB=m
> > > CONFIG_CAN_KVASER_USB=m
> > > CONFIG_CAN_MCBA_USB=m
> > > CONFIG_CAN_PEAK_USB=m
> > > CONFIG_CAN_UCAN=m
> > > # end of CAN USB interfaces
> > > 
> > > # CONFIG_CAN_DEBUG_DEVICES is not set
> > > # end of CAN Device Drivers
> > > 
> > > CONFIG_BT=m
> > > CONFIG_BT_BREDR=y
> > > CONFIG_BT_RFCOMM=m
> > > CONFIG_BT_RFCOMM_TTY=y
> > > CONFIG_BT_BNEP=m
> > > CONFIG_BT_BNEP_MC_FILTER=y
> > > CONFIG_BT_BNEP_PROTO_FILTER=y
> > > CONFIG_BT_CMTP=m
> > > CONFIG_BT_HIDP=m
> > > CONFIG_BT_HS=y
> > > CONFIG_BT_LE=y
> > > CONFIG_BT_6LOWPAN=m
> > > CONFIG_BT_LEDS=y
> > > # CONFIG_BT_SELFTEST is not set
> > > CONFIG_BT_DEBUGFS=y
> > > 
> > > #
> > > # Bluetooth device drivers
> > > #
> > > CONFIG_BT_INTEL=m
> > > CONFIG_BT_BCM=m
> > > CONFIG_BT_RTL=m
> > > CONFIG_BT_QCA=m
> > > CONFIG_BT_HCIBTUSB=m
> > > CONFIG_BT_HCIBTUSB_AUTOSUSPEND=y
> > > CONFIG_BT_HCIBTUSB_BCM=y
> > > CONFIG_BT_HCIBTUSB_MTK=y
> > > CONFIG_BT_HCIBTUSB_RTL=y
> > > CONFIG_BT_HCIBTSDIO=m
> > > CONFIG_BT_HCIUART=m
> > > CONFIG_BT_HCIUART_SERDEV=y
> > > CONFIG_BT_HCIUART_H4=y
> > > CONFIG_BT_HCIUART_NOKIA=m
> > > CONFIG_BT_HCIUART_BCSP=y
> > > CONFIG_BT_HCIUART_ATH3K=y
> > > CONFIG_BT_HCIUART_LL=y
> > > CONFIG_BT_HCIUART_3WIRE=y
> > > CONFIG_BT_HCIUART_INTEL=y
> > > CONFIG_BT_HCIUART_BCM=y
> > > CONFIG_BT_HCIUART_RTL=y
> > > CONFIG_BT_HCIUART_QCA=y
> > > CONFIG_BT_HCIUART_AG6XX=y
> > > CONFIG_BT_HCIUART_MRVL=y
> > > CONFIG_BT_HCIBCM203X=m
> > > CONFIG_BT_HCIBPA10X=m
> > > CONFIG_BT_HCIBFUSB=m
> > > CONFIG_BT_HCIDTL1=m
> > > CONFIG_BT_HCIBT3C=m
> > > CONFIG_BT_HCIBLUECARD=m
> > > CONFIG_BT_HCIVHCI=m
> > > CONFIG_BT_MRVL=m
> > > CONFIG_BT_MRVL_SDIO=m
> > > CONFIG_BT_ATH3K=m
> > > CONFIG_BT_WILINK=m
> > > CONFIG_BT_MTKSDIO=m
> > > CONFIG_BT_MTKUART=m
> > > CONFIG_BT_HCIRSI=m
> > > # end of Bluetooth device drivers
> > > 
> > > CONFIG_AF_RXRPC=m
> > > CONFIG_AF_RXRPC_IPV6=y
> > > # CONFIG_AF_RXRPC_INJECT_LOSS is not set
> > > # CONFIG_AF_RXRPC_DEBUG is not set
> > > CONFIG_RXKAD=y
> > > CONFIG_AF_KCM=m
> > > CONFIG_STREAM_PARSER=y
> > > CONFIG_FIB_RULES=y
> > > CONFIG_WIRELESS=y
> > > CONFIG_WIRELESS_EXT=y
> > > CONFIG_WEXT_CORE=y
> > > CONFIG_WEXT_PROC=y
> > > CONFIG_WEXT_SPY=y
> > > CONFIG_WEXT_PRIV=y
> > > CONFIG_CFG80211=m
> > > # CONFIG_NL80211_TESTMODE is not set
> > > # CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
> > > # CONFIG_CFG80211_CERTIFICATION_ONUS is not set
> > > CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
> > > CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
> > > CONFIG_CFG80211_DEFAULT_PS=y
> > > CONFIG_CFG80211_DEBUGFS=y
> > > CONFIG_CFG80211_CRDA_SUPPORT=y
> > > CONFIG_CFG80211_WEXT=y
> > > CONFIG_CFG80211_WEXT_EXPORT=y
> > > CONFIG_LIB80211=m
> > > CONFIG_LIB80211_CRYPT_WEP=m
> > > CONFIG_LIB80211_CRYPT_CCMP=m
> > > CONFIG_LIB80211_CRYPT_TKIP=m
> > > # CONFIG_LIB80211_DEBUG is not set
> > > CONFIG_MAC80211=m
> > > CONFIG_MAC80211_HAS_RC=y
> > > CONFIG_MAC80211_RC_MINSTREL=y
> > > CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
> > > CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
> > > CONFIG_MAC80211_MESH=y
> > > CONFIG_MAC80211_LEDS=y
> > > CONFIG_MAC80211_DEBUGFS=y
> > > CONFIG_MAC80211_MESSAGE_TRACING=y
> > > # CONFIG_MAC80211_DEBUG_MENU is not set
> > > CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> > > CONFIG_WIMAX=m
> > > CONFIG_WIMAX_DEBUG_LEVEL=8
> > > CONFIG_RFKILL=y
> > > CONFIG_RFKILL_LEDS=y
> > > CONFIG_RFKILL_INPUT=y
> > > CONFIG_RFKILL_GPIO=m
> > > CONFIG_NET_9P=m
> > > CONFIG_NET_9P_VIRTIO=m
> > > CONFIG_NET_9P_XEN=m
> > > CONFIG_NET_9P_RDMA=m
> > > # CONFIG_NET_9P_DEBUG is not set
> > > CONFIG_CAIF=m
> > > # CONFIG_CAIF_DEBUG is not set
> > > CONFIG_CAIF_NETDEV=m
> > > CONFIG_CAIF_USB=m
> > > CONFIG_CEPH_LIB=m
> > > # CONFIG_CEPH_LIB_PRETTYDEBUG is not set
> > > CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
> > > CONFIG_NFC=m
> > > CONFIG_NFC_DIGITAL=m
> > > CONFIG_NFC_NCI=m
> > > CONFIG_NFC_NCI_SPI=m
> > > CONFIG_NFC_NCI_UART=m
> > > CONFIG_NFC_HCI=m
> > > CONFIG_NFC_SHDLC=y
> > > 
> > > #
> > > # Near Field Communication (NFC) devices
> > > #
> > > CONFIG_NFC_TRF7970A=m
> > > CONFIG_NFC_MEI_PHY=m
> > > CONFIG_NFC_SIM=m
> > > CONFIG_NFC_PORT100=m
> > > CONFIG_NFC_FDP=m
> > > CONFIG_NFC_FDP_I2C=m
> > > CONFIG_NFC_PN544=m
> > > CONFIG_NFC_PN544_I2C=m
> > > CONFIG_NFC_PN544_MEI=m
> > > CONFIG_NFC_PN533=m
> > > CONFIG_NFC_PN533_USB=m
> > > CONFIG_NFC_PN533_I2C=m
> > > CONFIG_NFC_MICROREAD=m
> > > CONFIG_NFC_MICROREAD_I2C=m
> > > CONFIG_NFC_MICROREAD_MEI=m
> > > CONFIG_NFC_MRVL=m
> > > CONFIG_NFC_MRVL_USB=m
> > > CONFIG_NFC_MRVL_UART=m
> > > CONFIG_NFC_MRVL_I2C=m
> > > CONFIG_NFC_MRVL_SPI=m
> > > CONFIG_NFC_ST21NFCA=m
> > > CONFIG_NFC_ST21NFCA_I2C=m
> > > CONFIG_NFC_ST_NCI=m
> > > CONFIG_NFC_ST_NCI_I2C=m
> > > CONFIG_NFC_ST_NCI_SPI=m
> > > CONFIG_NFC_NXP_NCI=m
> > > CONFIG_NFC_NXP_NCI_I2C=m
> > > CONFIG_NFC_S3FWRN5=m
> > > CONFIG_NFC_S3FWRN5_I2C=m
> > > CONFIG_NFC_ST95HF=m
> > > # end of Near Field Communication (NFC) devices
> > > 
> > > CONFIG_PSAMPLE=m
> > > CONFIG_NET_IFE=m
> > > CONFIG_LWTUNNEL=y
> > > CONFIG_LWTUNNEL_BPF=y
> > > CONFIG_DST_CACHE=y
> > > CONFIG_GRO_CELLS=y
> > > CONFIG_SOCK_VALIDATE_XMIT=y
> > > CONFIG_NET_SOCK_MSG=y
> > > CONFIG_NET_DEVLINK=y
> > > CONFIG_PAGE_POOL=y
> > > CONFIG_FAILOVER=m
> > > CONFIG_HAVE_EBPF_JIT=y
> > > 
> > > #
> > > # Device Drivers
> > > #
> > > CONFIG_HAVE_EISA=y
> > > CONFIG_EISA=y
> > > CONFIG_EISA_VLB_PRIMING=y
> > > CONFIG_EISA_PCI_EISA=y
> > > CONFIG_EISA_VIRTUAL_ROOT=y
> > > CONFIG_EISA_NAMES=y
> > > CONFIG_HAVE_PCI=y
> > > CONFIG_PCI=y
> > > CONFIG_PCI_DOMAINS=y
> > > CONFIG_PCIEPORTBUS=y
> > > CONFIG_HOTPLUG_PCI_PCIE=y
> > > CONFIG_PCIEAER=y
> > > # CONFIG_PCIEAER_INJECT is not set
> > > # CONFIG_PCIE_ECRC is not set
> > > CONFIG_PCIEASPM=y
> > > CONFIG_PCIEASPM_DEBUG=y
> > > CONFIG_PCIEASPM_DEFAULT=y
> > > # CONFIG_PCIEASPM_POWERSAVE is not set
> > > # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> > > # CONFIG_PCIEASPM_PERFORMANCE is not set
> > > CONFIG_PCIE_PME=y
> > > CONFIG_PCIE_DPC=y
> > > CONFIG_PCIE_PTM=y
> > > # CONFIG_PCIE_BW is not set
> > > CONFIG_PCI_MSI=y
> > > CONFIG_PCI_MSI_IRQ_DOMAIN=y
> > > CONFIG_PCI_QUIRKS=y
> > > # CONFIG_PCI_DEBUG is not set
> > > CONFIG_PCI_REALLOC_ENABLE_AUTO=y
> > > CONFIG_PCI_STUB=m
> > > CONFIG_PCI_PF_STUB=m
> > > CONFIG_XEN_PCIDEV_FRONTEND=m
> > > CONFIG_PCI_ATS=y
> > > CONFIG_PCI_LOCKLESS_CONFIG=y
> > > CONFIG_PCI_IOV=y
> > > CONFIG_PCI_PRI=y
> > > CONFIG_PCI_PASID=y
> > > # CONFIG_PCI_P2PDMA is not set
> > > CONFIG_PCI_LABEL=y
> > > CONFIG_PCI_HYPERV=m
> > > CONFIG_HOTPLUG_PCI=y
> > > CONFIG_HOTPLUG_PCI_ACPI=y
> > > CONFIG_HOTPLUG_PCI_ACPI_IBM=m
> > > CONFIG_HOTPLUG_PCI_CPCI=y
> > > CONFIG_HOTPLUG_PCI_CPCI_ZT5550=m
> > > CONFIG_HOTPLUG_PCI_CPCI_GENERIC=m
> > > CONFIG_HOTPLUG_PCI_SHPC=y
> > > 
> > > #
> > > # PCI controller drivers
> > > #
> > > 
> > > #
> > > # Cadence PCIe controllers support
> > > #
> > > # end of Cadence PCIe controllers support
> > > 
> > > CONFIG_VMD=m
> > > 
> > > #
> > > # DesignWare PCI Core Support
> > > #
> > > CONFIG_PCIE_DW=y
> > > CONFIG_PCIE_DW_HOST=y
> > > CONFIG_PCIE_DW_EP=y
> > > CONFIG_PCIE_DW_PLAT=y
> > > CONFIG_PCIE_DW_PLAT_HOST=y
> > > CONFIG_PCIE_DW_PLAT_EP=y
> > > CONFIG_PCI_MESON=y
> > > # end of DesignWare PCI Core Support
> > > # end of PCI controller drivers
> > > 
> > > #
> > > # PCI Endpoint
> > > #
> > > CONFIG_PCI_ENDPOINT=y
> > > CONFIG_PCI_ENDPOINT_CONFIGFS=y
> > > # CONFIG_PCI_EPF_TEST is not set
> > > # end of PCI Endpoint
> > > 
> > > #
> > > # PCI switch controller drivers
> > > #
> > > CONFIG_PCI_SW_SWITCHTEC=m
> > > # end of PCI switch controller drivers
> > > 
> > > CONFIG_PCCARD=m
> > > CONFIG_PCMCIA=m
> > > CONFIG_PCMCIA_LOAD_CIS=y
> > > CONFIG_CARDBUS=y
> > > 
> > > #
> > > # PC-card bridges
> > > #
> > > CONFIG_YENTA=m
> > > CONFIG_YENTA_O2=y
> > > CONFIG_YENTA_RICOH=y
> > > CONFIG_YENTA_TI=y
> > > CONFIG_YENTA_ENE_TUNE=y
> > > CONFIG_YENTA_TOSHIBA=y
> > > CONFIG_PD6729=m
> > > CONFIG_I82092=m
> > > CONFIG_PCCARD_NONSTATIC=y
> > > CONFIG_RAPIDIO=y
> > > CONFIG_RAPIDIO_TSI721=m
> > > CONFIG_RAPIDIO_DISC_TIMEOUT=30
> > > # CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
> > > CONFIG_RAPIDIO_DMA_ENGINE=y
> > > # CONFIG_RAPIDIO_DEBUG is not set
> > > CONFIG_RAPIDIO_ENUM_BASIC=m
> > > CONFIG_RAPIDIO_CHMAN=m
> > > CONFIG_RAPIDIO_MPORT_CDEV=m
> > > 
> > > #
> > > # RapidIO Switch drivers
> > > #
> > > CONFIG_RAPIDIO_TSI57X=m
> > > CONFIG_RAPIDIO_CPS_XX=m
> > > CONFIG_RAPIDIO_TSI568=m
> > > CONFIG_RAPIDIO_CPS_GEN2=m
> > > CONFIG_RAPIDIO_RXS_GEN3=m
> > > # end of RapidIO Switch drivers
> > > 
> > > #
> > > # Generic Driver Options
> > > #
> > > CONFIG_UEVENT_HELPER=y
> > > CONFIG_UEVENT_HELPER_PATH=""
> > > CONFIG_DEVTMPFS=y
> > > CONFIG_DEVTMPFS_MOUNT=y
> > > # CONFIG_STANDALONE is not set
> > > CONFIG_PREVENT_FIRMWARE_BUILD=y
> > > 
> > > #
> > > # Firmware loader
> > > #
> > > CONFIG_FW_LOADER=y
> > > CONFIG_FW_LOADER_PAGED_BUF=y
> > > CONFIG_EXTRA_FIRMWARE=""
> > > CONFIG_FW_LOADER_USER_HELPER=y
> > > # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> > > CONFIG_FW_LOADER_COMPRESS=y
> > > # end of Firmware loader
> > > 
> > > CONFIG_WANT_DEV_COREDUMP=y
> > > CONFIG_ALLOW_DEV_COREDUMP=y
> > > CONFIG_DEV_COREDUMP=y
> > > # CONFIG_DEBUG_DRIVER is not set
> > > # CONFIG_DEBUG_DEVRES is not set
> > > # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> > > CONFIG_HMEM_REPORTING=y
> > > # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> > > CONFIG_SYS_HYPERVISOR=y
> > > CONFIG_GENERIC_CPU_AUTOPROBE=y
> > > CONFIG_GENERIC_CPU_VULNERABILITIES=y
> > > CONFIG_REGMAP=y
> > > CONFIG_REGMAP_I2C=y
> > > CONFIG_REGMAP_SLIMBUS=m
> > > CONFIG_REGMAP_SPI=y
> > > CONFIG_REGMAP_SPMI=m
> > > CONFIG_REGMAP_W1=m
> > > CONFIG_REGMAP_MMIO=y
> > > CONFIG_REGMAP_IRQ=y
> > > CONFIG_REGMAP_SCCB=m
> > > CONFIG_DMA_SHARED_BUFFER=y
> > > # CONFIG_DMA_FENCE_TRACE is not set
> > > # end of Generic Driver Options
> > > 
> > > #
> > > # Bus devices
> > > #
> > > # end of Bus devices
> > > 
> > > CONFIG_CONNECTOR=y
> > > CONFIG_PROC_EVENTS=y
> > > CONFIG_GNSS=m
> > > CONFIG_GNSS_SERIAL=m
> > > CONFIG_GNSS_MTK_SERIAL=m
> > > CONFIG_GNSS_SIRF_SERIAL=m
> > > CONFIG_GNSS_UBX_SERIAL=m
> > > CONFIG_MTD=m
> > > # CONFIG_MTD_TESTS is not set
> > > CONFIG_MTD_CMDLINE_PARTS=m
> > > CONFIG_MTD_AR7_PARTS=m
> > > 
> > > #
> > > # Partition parsers
> > > #
> > > CONFIG_MTD_REDBOOT_PARTS=m
> > > CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
> > > # CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
> > > # CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
> > > # end of Partition parsers
> > > 
> > > #
> > > # User Modules And Translation Layers
> > > #
> > > CONFIG_MTD_BLKDEVS=m
> > > CONFIG_MTD_BLOCK=m
> > > CONFIG_MTD_BLOCK_RO=m
> > > CONFIG_FTL=m
> > > CONFIG_NFTL=m
> > > CONFIG_NFTL_RW=y
> > > CONFIG_INFTL=m
> > > CONFIG_RFD_FTL=m
> > > CONFIG_SSFDC=m
> > > CONFIG_SM_FTL=m
> > > CONFIG_MTD_OOPS=m
> > > CONFIG_MTD_SWAP=m
> > > # CONFIG_MTD_PARTITIONED_MASTER is not set
> > > 
> > > #
> > > # RAM/ROM/Flash chip drivers
> > > #
> > > CONFIG_MTD_CFI=m
> > > CONFIG_MTD_JEDECPROBE=m
> > > CONFIG_MTD_GEN_PROBE=m
> > > # CONFIG_MTD_CFI_ADV_OPTIONS is not set
> > > CONFIG_MTD_MAP_BANK_WIDTH_1=y
> > > CONFIG_MTD_MAP_BANK_WIDTH_2=y
> > > CONFIG_MTD_MAP_BANK_WIDTH_4=y
> > > CONFIG_MTD_CFI_I1=y
> > > CONFIG_MTD_CFI_I2=y
> > > CONFIG_MTD_CFI_INTELEXT=m
> > > CONFIG_MTD_CFI_AMDSTD=m
> > > CONFIG_MTD_CFI_STAA=m
> > > CONFIG_MTD_CFI_UTIL=m
> > > CONFIG_MTD_RAM=m
> > > CONFIG_MTD_ROM=m
> > > CONFIG_MTD_ABSENT=m
> > > # end of RAM/ROM/Flash chip drivers
> > > 
> > > #
> > > # Mapping drivers for chip access
> > > #
> > > CONFIG_MTD_COMPLEX_MAPPINGS=y
> > > CONFIG_MTD_PHYSMAP=m
> > > # CONFIG_MTD_PHYSMAP_COMPAT is not set
> > > CONFIG_MTD_PHYSMAP_GPIO_ADDR=y
> > > CONFIG_MTD_SBC_GXX=m
> > > CONFIG_MTD_AMD76XROM=m
> > > CONFIG_MTD_ICHXROM=m
> > > CONFIG_MTD_ESB2ROM=m
> > > CONFIG_MTD_CK804XROM=m
> > > CONFIG_MTD_SCB2_FLASH=m
> > > CONFIG_MTD_NETtel=m
> > > CONFIG_MTD_L440GX=m
> > > CONFIG_MTD_PCI=m
> > > CONFIG_MTD_PCMCIA=m
> > > # CONFIG_MTD_PCMCIA_ANONYMOUS is not set
> > > CONFIG_MTD_INTEL_VR_NOR=m
> > > CONFIG_MTD_PLATRAM=m
> > > # end of Mapping drivers for chip access
> > > 
> > > #
> > > # Self-contained MTD device drivers
> > > #
> > > CONFIG_MTD_PMC551=m
> > > # CONFIG_MTD_PMC551_BUGFIX is not set
> > > # CONFIG_MTD_PMC551_DEBUG is not set
> > > CONFIG_MTD_DATAFLASH=m
> > > # CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
> > > CONFIG_MTD_DATAFLASH_OTP=y
> > > CONFIG_MTD_M25P80=m
> > > CONFIG_MTD_MCHP23K256=m
> > > CONFIG_MTD_SST25L=m
> > > CONFIG_MTD_SLRAM=m
> > > CONFIG_MTD_PHRAM=m
> > > CONFIG_MTD_MTDRAM=m
> > > CONFIG_MTDRAM_TOTAL_SIZE=4096
> > > CONFIG_MTDRAM_ERASE_SIZE=128
> > > CONFIG_MTD_BLOCK2MTD=m
> > > 
> > > #
> > > # Disk-On-Chip Device Drivers
> > > #
> > > # CONFIG_MTD_DOCG3 is not set
> > > # end of Self-contained MTD device drivers
> > > 
> > > CONFIG_MTD_NAND_CORE=m
> > > CONFIG_MTD_ONENAND=m
> > > CONFIG_MTD_ONENAND_VERIFY_WRITE=y
> > > CONFIG_MTD_ONENAND_GENERIC=m
> > > # CONFIG_MTD_ONENAND_OTP is not set
> > > CONFIG_MTD_ONENAND_2X_PROGRAM=y
> > > CONFIG_MTD_NAND_ECC_SW_HAMMING=m
> > > # CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
> > > CONFIG_MTD_RAW_NAND=m
> > > CONFIG_MTD_NAND_ECC_SW_BCH=y
> > > 
> > > #
> > > # Raw/parallel NAND flash controllers
> > > #
> > > CONFIG_MTD_NAND_DENALI=m
> > > CONFIG_MTD_NAND_DENALI_PCI=m
> > > CONFIG_MTD_NAND_CAFE=m
> > > CONFIG_MTD_NAND_GPIO=m
> > > CONFIG_MTD_NAND_PLATFORM=m
> > > 
> > > #
> > > # Misc
> > > #
> > > CONFIG_MTD_SM_COMMON=m
> > > CONFIG_MTD_NAND_NANDSIM=m
> > > CONFIG_MTD_NAND_RICOH=m
> > > CONFIG_MTD_NAND_DISKONCHIP=m
> > > # CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
> > > CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
> > > # CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
> > > CONFIG_MTD_SPI_NAND=m
> > > 
> > > #
> > > # LPDDR & LPDDR2 PCM memory drivers
> > > #
> > > CONFIG_MTD_LPDDR=m
> > > CONFIG_MTD_QINFO_PROBE=m
> > > # end of LPDDR & LPDDR2 PCM memory drivers
> > > 
> > > CONFIG_MTD_SPI_NOR=m
> > > CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
> > > CONFIG_SPI_MTK_QUADSPI=m
> > > # CONFIG_SPI_INTEL_SPI_PCI is not set
> > > # CONFIG_SPI_INTEL_SPI_PLATFORM is not set
> > > CONFIG_MTD_UBI=m
> > > CONFIG_MTD_UBI_WL_THRESHOLD=4096
> > > CONFIG_MTD_UBI_BEB_LIMIT=20
> > > CONFIG_MTD_UBI_FASTMAP=y
> > > CONFIG_MTD_UBI_GLUEBI=m
> > > CONFIG_MTD_UBI_BLOCK=y
> > > CONFIG_MTD_HYPERBUS=m
> > > # CONFIG_OF is not set
> > > CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> > > CONFIG_PARPORT=m
> > > CONFIG_PARPORT_PC=m
> > > CONFIG_PARPORT_SERIAL=m
> > > CONFIG_PARPORT_PC_FIFO=y
> > > # CONFIG_PARPORT_PC_SUPERIO is not set
> > > CONFIG_PARPORT_PC_PCMCIA=m
> > > CONFIG_PARPORT_AX88796=m
> > > CONFIG_PARPORT_1284=y
> > > CONFIG_PARPORT_NOT_PC=y
> > > CONFIG_PNP=y
> > > # CONFIG_PNP_DEBUG_MESSAGES is not set
> > > 
> > > #
> > > # Protocols
> > > #
> > > CONFIG_PNPACPI=y
> > > CONFIG_BLK_DEV=y
> > > CONFIG_BLK_DEV_NULL_BLK=m
> > > CONFIG_BLK_DEV_FD=m
> > > CONFIG_CDROM=y
> > > CONFIG_PARIDE=m
> > > 
> > > #
> > > # Parallel IDE high-level drivers
> > > #
> > > CONFIG_PARIDE_PD=m
> > > CONFIG_PARIDE_PCD=m
> > > CONFIG_PARIDE_PF=m
> > > CONFIG_PARIDE_PT=m
> > > CONFIG_PARIDE_PG=m
> > > 
> > > #
> > > # Parallel IDE protocol modules
> > > #
> > > CONFIG_PARIDE_ATEN=m
> > > CONFIG_PARIDE_BPCK=m
> > > CONFIG_PARIDE_COMM=m
> > > CONFIG_PARIDE_DSTR=m
> > > CONFIG_PARIDE_FIT2=m
> > > CONFIG_PARIDE_FIT3=m
> > > CONFIG_PARIDE_EPAT=m
> > > CONFIG_PARIDE_EPATC8=y
> > > CONFIG_PARIDE_EPIA=m
> > > CONFIG_PARIDE_FRIQ=m
> > > CONFIG_PARIDE_FRPW=m
> > > CONFIG_PARIDE_KBIC=m
> > > CONFIG_PARIDE_KTTI=m
> > > CONFIG_PARIDE_ON20=m
> > > CONFIG_PARIDE_ON26=m
> > > CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
> > > CONFIG_ZRAM=m
> > > CONFIG_ZRAM_WRITEBACK=y
> > > CONFIG_ZRAM_MEMORY_TRACKING=y
> > > CONFIG_BLK_DEV_UMEM=m
> > > CONFIG_BLK_DEV_LOOP=y
> > > CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
> > > CONFIG_BLK_DEV_CRYPTOLOOP=m
> > > CONFIG_BLK_DEV_DRBD=m
> > > # CONFIG_DRBD_FAULT_INJECTION is not set
> > > CONFIG_BLK_DEV_NBD=m
> > > CONFIG_BLK_DEV_SKD=m
> > > CONFIG_BLK_DEV_SX8=m
> > > CONFIG_BLK_DEV_RAM=m
> > > CONFIG_BLK_DEV_RAM_COUNT=16
> > > CONFIG_BLK_DEV_RAM_SIZE=65536
> > > CONFIG_CDROM_PKTCDVD=m
> > > CONFIG_CDROM_PKTCDVD_BUFFERS=8
> > > # CONFIG_CDROM_PKTCDVD_WCACHE is not set
> > > CONFIG_ATA_OVER_ETH=m
> > > CONFIG_XEN_BLKDEV_FRONTEND=y
> > > CONFIG_XEN_BLKDEV_BACKEND=m
> > > CONFIG_VIRTIO_BLK=m
> > > CONFIG_VIRTIO_BLK_SCSI=y
> > > CONFIG_BLK_DEV_RBD=m
> > > CONFIG_BLK_DEV_RSXX=m
> > > 
> > > #
> > > # NVME Support
> > > #
> > > CONFIG_NVME_CORE=m
> > > CONFIG_BLK_DEV_NVME=m
> > > CONFIG_NVME_MULTIPATH=y
> > > CONFIG_NVME_FABRICS=m
> > > CONFIG_NVME_RDMA=m
> > > CONFIG_NVME_FC=m
> > > CONFIG_NVME_TCP=m
> > > CONFIG_NVME_TARGET=m
> > > CONFIG_NVME_TARGET_LOOP=m
> > > CONFIG_NVME_TARGET_RDMA=m
> > > CONFIG_NVME_TARGET_FC=m
> > > # CONFIG_NVME_TARGET_FCLOOP is not set
> > > CONFIG_NVME_TARGET_TCP=m
> > > # end of NVME Support
> > > 
> > > #
> > > # Misc devices
> > > #
> > > CONFIG_SENSORS_LIS3LV02D=m
> > > CONFIG_AD525X_DPOT=m
> > > CONFIG_AD525X_DPOT_I2C=m
> > > CONFIG_AD525X_DPOT_SPI=m
> > > CONFIG_DUMMY_IRQ=m
> > > CONFIG_IBM_ASM=m
> > > CONFIG_PHANTOM=m
> > > CONFIG_SGI_IOC4=m
> > > CONFIG_TIFM_CORE=m
> > > CONFIG_TIFM_7XX1=m
> > > CONFIG_ICS932S401=m
> > > CONFIG_ENCLOSURE_SERVICES=m
> > > CONFIG_HP_ILO=m
> > > CONFIG_APDS9802ALS=m
> > > CONFIG_ISL29003=m
> > > CONFIG_ISL29020=m
> > > CONFIG_SENSORS_TSL2550=m
> > > CONFIG_SENSORS_BH1770=m
> > > CONFIG_SENSORS_APDS990X=m
> > > CONFIG_HMC6352=m
> > > CONFIG_DS1682=m
> > > CONFIG_VMWARE_BALLOON=m
> > > CONFIG_LATTICE_ECP3_CONFIG=m
> > > CONFIG_SRAM=y
> > > # CONFIG_PCI_ENDPOINT_TEST is not set
> > > CONFIG_XILINX_SDFEC=m
> > > CONFIG_MISC_RTSX=m
> > > CONFIG_PVPANIC=m
> > > CONFIG_C2PORT=m
> > > CONFIG_C2PORT_DURAMAR_2150=m
> > > 
> > > #
> > > # EEPROM support
> > > #
> > > CONFIG_EEPROM_AT24=m
> > > CONFIG_EEPROM_AT25=m
> > > CONFIG_EEPROM_LEGACY=m
> > > CONFIG_EEPROM_MAX6875=m
> > > CONFIG_EEPROM_93CX6=m
> > > CONFIG_EEPROM_93XX46=m
> > > CONFIG_EEPROM_IDT_89HPESX=m
> > > CONFIG_EEPROM_EE1004=m
> > > # end of EEPROM support
> > > 
> > > CONFIG_CB710_CORE=m
> > > # CONFIG_CB710_DEBUG is not set
> > > CONFIG_CB710_DEBUG_ASSUMPTIONS=y
> > > 
> > > #
> > > # Texas Instruments shared transport line discipline
> > > #
> > > CONFIG_TI_ST=m
> > > # end of Texas Instruments shared transport line discipline
> > > 
> > > CONFIG_SENSORS_LIS3_I2C=m
> > > CONFIG_ALTERA_STAPL=m
> > > CONFIG_INTEL_MEI=m
> > > CONFIG_INTEL_MEI_ME=m
> > > CONFIG_INTEL_MEI_TXE=m
> > > CONFIG_INTEL_MEI_HDCP=m
> > > CONFIG_VMWARE_VMCI=m
> > > 
> > > #
> > > # Intel MIC & related support
> > > #
> > > 
> > > #
> > > # Intel MIC Bus Driver
> > > #
> > > CONFIG_INTEL_MIC_BUS=m
> > > 
> > > #
> > > # SCIF Bus Driver
> > > #
> > > CONFIG_SCIF_BUS=m
> > > 
> > > #
> > > # VOP Bus Driver
> > > #
> > > CONFIG_VOP_BUS=m
> > > 
> > > #
> > > # Intel MIC Host Driver
> > > #
> > > CONFIG_INTEL_MIC_HOST=m
> > > 
> > > #
> > > # Intel MIC Card Driver
> > > #
> > > CONFIG_INTEL_MIC_CARD=m
> > > 
> > > #
> > > # SCIF Driver
> > > #
> > > CONFIG_SCIF=m
> > > 
> > > #
> > > # Intel MIC Coprocessor State Management (COSM) Drivers
> > > #
> > > CONFIG_MIC_COSM=m
> > > 
> > > #
> > > # VOP Driver
> > > #
> > > CONFIG_VOP=m
> > > CONFIG_VHOST_RING=m
> > > # end of Intel MIC & related support
> > > 
> > > CONFIG_GENWQE=m
> > > CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
> > > CONFIG_ECHO=m
> > > CONFIG_MISC_ALCOR_PCI=m
> > > CONFIG_MISC_RTSX_PCI=m
> > > CONFIG_MISC_RTSX_USB=m
> > > CONFIG_HABANA_AI=m
> > > # end of Misc devices
> > > 
> > > CONFIG_HAVE_IDE=y
> > > # CONFIG_IDE is not set
> > > 
> > > #
> > > # SCSI device support
> > > #
> > > CONFIG_SCSI_MOD=y
> > > CONFIG_RAID_ATTRS=m
> > > CONFIG_SCSI=y
> > > CONFIG_SCSI_DMA=y
> > > CONFIG_SCSI_NETLINK=y
> > > CONFIG_SCSI_PROC_FS=y
> > > 
> > > #
> > > # SCSI support type (disk, tape, CD-ROM)
> > > #
> > > CONFIG_BLK_DEV_SD=y
> > > CONFIG_CHR_DEV_ST=m
> > > CONFIG_BLK_DEV_SR=y
> > > # CONFIG_BLK_DEV_SR_VENDOR is not set
> > > CONFIG_CHR_DEV_SG=y
> > > CONFIG_CHR_DEV_SCH=m
> > > CONFIG_SCSI_ENCLOSURE=m
> > > CONFIG_SCSI_CONSTANTS=y
> > > CONFIG_SCSI_LOGGING=y
> > > CONFIG_SCSI_SCAN_ASYNC=y
> > > 
> > > #
> > > # SCSI Transports
> > > #
> > > CONFIG_SCSI_SPI_ATTRS=m
> > > CONFIG_SCSI_FC_ATTRS=m
> > > CONFIG_SCSI_ISCSI_ATTRS=m
> > > CONFIG_SCSI_SAS_ATTRS=m
> > > CONFIG_SCSI_SAS_LIBSAS=m
> > > CONFIG_SCSI_SAS_ATA=y
> > > CONFIG_SCSI_SAS_HOST_SMP=y
> > > CONFIG_SCSI_SRP_ATTRS=m
> > > # end of SCSI Transports
> > > 
> > > CONFIG_SCSI_LOWLEVEL=y
> > > CONFIG_ISCSI_TCP=m
> > > CONFIG_ISCSI_BOOT_SYSFS=m
> > > CONFIG_SCSI_CXGB3_ISCSI=m
> > > CONFIG_SCSI_CXGB4_ISCSI=m
> > > CONFIG_SCSI_BNX2_ISCSI=m
> > > CONFIG_SCSI_BNX2X_FCOE=m
> > > CONFIG_BE2ISCSI=m
> > > CONFIG_BLK_DEV_3W_XXXX_RAID=m
> > > CONFIG_SCSI_HPSA=m
> > > CONFIG_SCSI_3W_9XXX=m
> > > CONFIG_SCSI_3W_SAS=m
> > > CONFIG_SCSI_ACARD=m
> > > CONFIG_SCSI_AHA1740=m
> > > CONFIG_SCSI_AACRAID=m
> > > CONFIG_SCSI_AIC7XXX=m
> > > CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
> > > CONFIG_AIC7XXX_RESET_DELAY_MS=5000
> > > # CONFIG_AIC7XXX_DEBUG_ENABLE is not set
> > > CONFIG_AIC7XXX_DEBUG_MASK=0
> > > CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
> > > CONFIG_SCSI_AIC79XX=m
> > > CONFIG_AIC79XX_CMDS_PER_DEVICE=32
> > > CONFIG_AIC79XX_RESET_DELAY_MS=5000
> > > # CONFIG_AIC79XX_DEBUG_ENABLE is not set
> > > CONFIG_AIC79XX_DEBUG_MASK=0
> > > CONFIG_AIC79XX_REG_PRETTY_PRINT=y
> > > CONFIG_SCSI_AIC94XX=m
> > > # CONFIG_AIC94XX_DEBUG is not set
> > > CONFIG_SCSI_MVSAS=m
> > > # CONFIG_SCSI_MVSAS_DEBUG is not set
> > > # CONFIG_SCSI_MVSAS_TASKLET is not set
> > > CONFIG_SCSI_MVUMI=m
> > > CONFIG_SCSI_DPT_I2O=m
> > > CONFIG_SCSI_ADVANSYS=m
> > > CONFIG_SCSI_ARCMSR=m
> > > CONFIG_SCSI_ESAS2R=m
> > > CONFIG_MEGARAID_NEWGEN=y
> > > CONFIG_MEGARAID_MM=m
> > > CONFIG_MEGARAID_MAILBOX=m
> > > CONFIG_MEGARAID_LEGACY=m
> > > CONFIG_MEGARAID_SAS=m
> > > CONFIG_SCSI_MPT3SAS=m
> > > CONFIG_SCSI_MPT2SAS_MAX_SGE=128
> > > CONFIG_SCSI_MPT3SAS_MAX_SGE=128
> > > CONFIG_SCSI_MPT2SAS=m
> > > CONFIG_SCSI_SMARTPQI=m
> > > CONFIG_SCSI_UFSHCD=m
> > > CONFIG_SCSI_UFSHCD_PCI=m
> > > CONFIG_SCSI_UFS_DWC_TC_PCI=m
> > > CONFIG_SCSI_UFSHCD_PLATFORM=m
> > > CONFIG_SCSI_UFS_CDNS_PLATFORM=m
> > > CONFIG_SCSI_UFS_DWC_TC_PLATFORM=m
> > > CONFIG_SCSI_UFS_BSG=y
> > > CONFIG_SCSI_HPTIOP=m
> > > CONFIG_SCSI_BUSLOGIC=m
> > > CONFIG_SCSI_FLASHPOINT=y
> > > CONFIG_SCSI_MYRB=m
> > > CONFIG_SCSI_MYRS=m
> > > CONFIG_VMWARE_PVSCSI=m
> > > CONFIG_XEN_SCSI_FRONTEND=m
> > > CONFIG_HYPERV_STORAGE=m
> > > CONFIG_LIBFC=m
> > > CONFIG_LIBFCOE=m
> > > CONFIG_FCOE=m
> > > CONFIG_FCOE_FNIC=m
> > > CONFIG_SCSI_SNIC=m
> > > # CONFIG_SCSI_SNIC_DEBUG_FS is not set
> > > CONFIG_SCSI_DMX3191D=m
> > > CONFIG_SCSI_FDOMAIN=m
> > > CONFIG_SCSI_FDOMAIN_PCI=m
> > > CONFIG_SCSI_GDTH=m
> > > CONFIG_SCSI_ISCI=m
> > > CONFIG_SCSI_IPS=m
> > > CONFIG_SCSI_INITIO=m
> > > CONFIG_SCSI_INIA100=m
> > > CONFIG_SCSI_PPA=m
> > > CONFIG_SCSI_IMM=m
> > > # CONFIG_SCSI_IZIP_EPP16 is not set
> > > # CONFIG_SCSI_IZIP_SLOW_CTR is not set
> > > CONFIG_SCSI_STEX=m
> > > CONFIG_SCSI_SYM53C8XX_2=m
> > > CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
> > > CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
> > > CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
> > > CONFIG_SCSI_SYM53C8XX_MMIO=y
> > > CONFIG_SCSI_IPR=m
> > > CONFIG_SCSI_IPR_TRACE=y
> > > CONFIG_SCSI_IPR_DUMP=y
> > > CONFIG_SCSI_QLOGIC_1280=m
> > > CONFIG_SCSI_QLA_FC=m
> > > CONFIG_TCM_QLA2XXX=m
> > > # CONFIG_TCM_QLA2XXX_DEBUG is not set
> > > CONFIG_SCSI_QLA_ISCSI=m
> > > CONFIG_QEDI=m
> > > CONFIG_QEDF=m
> > > CONFIG_SCSI_LPFC=m
> > > # CONFIG_SCSI_LPFC_DEBUG_FS is not set
> > > CONFIG_SCSI_SIM710=m
> > > CONFIG_SCSI_DC395x=m
> > > CONFIG_SCSI_AM53C974=m
> > > CONFIG_SCSI_WD719X=m
> > > CONFIG_SCSI_DEBUG=m
> > > CONFIG_SCSI_PMCRAID=m
> > > CONFIG_SCSI_PM8001=m
> > > CONFIG_SCSI_BFA_FC=m
> > > CONFIG_SCSI_VIRTIO=m
> > > CONFIG_SCSI_CHELSIO_FCOE=m
> > > CONFIG_SCSI_LOWLEVEL_PCMCIA=y
> > > CONFIG_PCMCIA_AHA152X=m
> > > CONFIG_PCMCIA_FDOMAIN=m
> > > CONFIG_PCMCIA_QLOGIC=m
> > > CONFIG_PCMCIA_SYM53C500=m
> > > CONFIG_SCSI_DH=y
> > > CONFIG_SCSI_DH_RDAC=m
> > > CONFIG_SCSI_DH_HP_SW=m
> > > CONFIG_SCSI_DH_EMC=m
> > > CONFIG_SCSI_DH_ALUA=m
> > > # end of SCSI device support
> > > 
> > > CONFIG_ATA=y
> > > CONFIG_ATA_VERBOSE_ERROR=y
> > > CONFIG_ATA_ACPI=y
> > > CONFIG_SATA_ZPODD=y
> > > CONFIG_SATA_PMP=y
> > > 
> > > #
> > > # Controllers with non-SFF native interface
> > > #
> > > CONFIG_SATA_AHCI=m
> > > CONFIG_SATA_MOBILE_LPM_POLICY=3
> > > CONFIG_SATA_AHCI_PLATFORM=m
> > > CONFIG_SATA_INIC162X=m
> > > CONFIG_SATA_ACARD_AHCI=m
> > > CONFIG_SATA_SIL24=m
> > > CONFIG_ATA_SFF=y
> > > 
> > > #
> > > # SFF controllers with custom DMA interface
> > > #
> > > CONFIG_PDC_ADMA=m
> > > CONFIG_SATA_QSTOR=m
> > > CONFIG_SATA_SX4=m
> > > CONFIG_ATA_BMDMA=y
> > > 
> > > #
> > > # SATA SFF controllers with BMDMA
> > > #
> > > CONFIG_ATA_PIIX=y
> > > CONFIG_SATA_DWC=m
> > > CONFIG_SATA_DWC_OLD_DMA=y
> > > # CONFIG_SATA_DWC_DEBUG is not set
> > > CONFIG_SATA_MV=m
> > > CONFIG_SATA_NV=m
> > > CONFIG_SATA_PROMISE=m
> > > CONFIG_SATA_SIL=m
> > > CONFIG_SATA_SIS=m
> > > CONFIG_SATA_SVW=m
> > > CONFIG_SATA_ULI=m
> > > CONFIG_SATA_VIA=m
> > > CONFIG_SATA_VITESSE=m
> > > 
> > > #
> > > # PATA SFF controllers with BMDMA
> > > #
> > > CONFIG_PATA_ALI=m
> > > CONFIG_PATA_AMD=m
> > > CONFIG_PATA_ARTOP=m
> > > CONFIG_PATA_ATIIXP=m
> > > CONFIG_PATA_ATP867X=m
> > > CONFIG_PATA_CMD64X=m
> > > CONFIG_PATA_CYPRESS=m
> > > CONFIG_PATA_EFAR=m
> > > CONFIG_PATA_HPT366=m
> > > CONFIG_PATA_HPT37X=m
> > > CONFIG_PATA_HPT3X2N=m
> > > CONFIG_PATA_HPT3X3=m
> > > # CONFIG_PATA_HPT3X3_DMA is not set
> > > CONFIG_PATA_IT8213=m
> > > CONFIG_PATA_IT821X=m
> > > CONFIG_PATA_JMICRON=m
> > > CONFIG_PATA_MARVELL=m
> > > CONFIG_PATA_NETCELL=m
> > > CONFIG_PATA_NINJA32=m
> > > CONFIG_PATA_NS87415=m
> > > CONFIG_PATA_OLDPIIX=m
> > > CONFIG_PATA_OPTIDMA=m
> > > CONFIG_PATA_PDC2027X=m
> > > CONFIG_PATA_PDC_OLD=m
> > > CONFIG_PATA_RADISYS=m
> > > CONFIG_PATA_RDC=m
> > > CONFIG_PATA_SCH=m
> > > CONFIG_PATA_SERVERWORKS=m
> > > CONFIG_PATA_SIL680=m
> > > CONFIG_PATA_SIS=y
> > > CONFIG_PATA_TOSHIBA=m
> > > CONFIG_PATA_TRIFLEX=m
> > > CONFIG_PATA_VIA=m
> > > CONFIG_PATA_WINBOND=m
> > > 
> > > #
> > > # PIO-only SFF controllers
> > > #
> > > CONFIG_PATA_CMD640_PCI=m
> > > CONFIG_PATA_MPIIX=m
> > > CONFIG_PATA_NS87410=m
> > > CONFIG_PATA_OPTI=m
> > > CONFIG_PATA_PCMCIA=m
> > > CONFIG_PATA_PLATFORM=m
> > > CONFIG_PATA_RZ1000=m
> > > 
> > > #
> > > # Generic fallback / legacy drivers
> > > #
> > > CONFIG_PATA_ACPI=m
> > > CONFIG_ATA_GENERIC=y
> > > CONFIG_PATA_LEGACY=m
> > > CONFIG_MD=y
> > > CONFIG_BLK_DEV_MD=y
> > > CONFIG_MD_AUTODETECT=y
> > > CONFIG_MD_LINEAR=m
> > > CONFIG_MD_RAID0=m
> > > CONFIG_MD_RAID1=m
> > > CONFIG_MD_RAID10=m
> > > CONFIG_MD_RAID456=m
> > > CONFIG_MD_MULTIPATH=m
> > > CONFIG_MD_FAULTY=m
> > > CONFIG_MD_CLUSTER=m
> > > CONFIG_BCACHE=m
> > > # CONFIG_BCACHE_DEBUG is not set
> > > # CONFIG_BCACHE_CLOSURES_DEBUG is not set
> > > CONFIG_BLK_DEV_DM_BUILTIN=y
> > > CONFIG_BLK_DEV_DM=y
> > > # CONFIG_DM_DEBUG is not set
> > > CONFIG_DM_BUFIO=m
> > > # CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
> > > CONFIG_DM_BIO_PRISON=m
> > > CONFIG_DM_PERSISTENT_DATA=m
> > > CONFIG_DM_UNSTRIPED=m
> > > CONFIG_DM_CRYPT=m
> > > CONFIG_DM_SNAPSHOT=m
> > > CONFIG_DM_THIN_PROVISIONING=m
> > > CONFIG_DM_CACHE=m
> > > CONFIG_DM_CACHE_SMQ=m
> > > CONFIG_DM_WRITECACHE=m
> > > CONFIG_DM_ERA=m
> > > CONFIG_DM_MIRROR=m
> > > CONFIG_DM_LOG_USERSPACE=m
> > > CONFIG_DM_RAID=m
> > > CONFIG_DM_ZERO=m
> > > CONFIG_DM_MULTIPATH=m
> > > CONFIG_DM_MULTIPATH_QL=m
> > > CONFIG_DM_MULTIPATH_ST=m
> > > CONFIG_DM_DELAY=m
> > > # CONFIG_DM_DUST is not set
> > > CONFIG_DM_INIT=y
> > > CONFIG_DM_UEVENT=y
> > > CONFIG_DM_FLAKEY=m
> > > CONFIG_DM_VERITY=m
> > > # CONFIG_DM_VERITY_FEC is not set
> > > CONFIG_DM_SWITCH=m
> > > CONFIG_DM_LOG_WRITES=m
> > > CONFIG_DM_INTEGRITY=m
> > > CONFIG_DM_ZONED=m
> > > CONFIG_TARGET_CORE=m
> > > CONFIG_TCM_IBLOCK=m
> > > CONFIG_TCM_FILEIO=m
> > > CONFIG_TCM_PSCSI=m
> > > CONFIG_TCM_USER2=m
> > > CONFIG_LOOPBACK_TARGET=m
> > > CONFIG_TCM_FC=m
> > > CONFIG_ISCSI_TARGET=m
> > > CONFIG_ISCSI_TARGET_CXGB4=m
> > > CONFIG_SBP_TARGET=m
> > > CONFIG_FUSION=y
> > > CONFIG_FUSION_SPI=m
> > > CONFIG_FUSION_FC=m
> > > CONFIG_FUSION_SAS=m
> > > CONFIG_FUSION_MAX_SGE=128
> > > CONFIG_FUSION_CTL=m
> > > CONFIG_FUSION_LAN=m
> > > CONFIG_FUSION_LOGGING=y
> > > 
> > > #
> > > # IEEE 1394 (FireWire) support
> > > #
> > > CONFIG_FIREWIRE=m
> > > CONFIG_FIREWIRE_OHCI=m
> > > CONFIG_FIREWIRE_SBP2=m
> > > CONFIG_FIREWIRE_NET=m
> > > CONFIG_FIREWIRE_NOSY=m
> > > # end of IEEE 1394 (FireWire) support
> > > 
> > > CONFIG_MACINTOSH_DRIVERS=y
> > > CONFIG_MAC_EMUMOUSEBTN=m
> > > CONFIG_NETDEVICES=y
> > > CONFIG_MII=m
> > > CONFIG_NET_CORE=y
> > > CONFIG_BONDING=m
> > > CONFIG_DUMMY=m
> > > CONFIG_EQUALIZER=m
> > > CONFIG_NET_FC=y
> > > CONFIG_IFB=m
> > > CONFIG_NET_TEAM=m
> > > CONFIG_NET_TEAM_MODE_BROADCAST=m
> > > CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
> > > CONFIG_NET_TEAM_MODE_RANDOM=m
> > > CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
> > > CONFIG_NET_TEAM_MODE_LOADBALANCE=m
> > > CONFIG_MACVLAN=m
> > > CONFIG_MACVTAP=m
> > > CONFIG_IPVLAN_L3S=y
> > > CONFIG_IPVLAN=m
> > > CONFIG_IPVTAP=m
> > > CONFIG_VXLAN=m
> > > CONFIG_GENEVE=m
> > > CONFIG_GTP=m
> > > CONFIG_MACSEC=m
> > > CONFIG_NETCONSOLE=m
> > > CONFIG_NETCONSOLE_DYNAMIC=y
> > > CONFIG_NETPOLL=y
> > > CONFIG_NET_POLL_CONTROLLER=y
> > > CONFIG_NTB_NETDEV=m
> > > CONFIG_RIONET=m
> > > CONFIG_RIONET_TX_SIZE=128
> > > CONFIG_RIONET_RX_SIZE=128
> > > CONFIG_TUN=y
> > > CONFIG_TAP=m
> > > # CONFIG_TUN_VNET_CROSS_LE is not set
> > > CONFIG_VETH=m
> > > CONFIG_VIRTIO_NET=m
> > > CONFIG_NLMON=m
> > > CONFIG_NET_VRF=m
> > > CONFIG_VSOCKMON=m
> > > CONFIG_SUNGEM_PHY=m
> > > CONFIG_ARCNET=m
> > > CONFIG_ARCNET_1201=m
> > > CONFIG_ARCNET_1051=m
> > > CONFIG_ARCNET_RAW=m
> > > CONFIG_ARCNET_CAP=m
> > > CONFIG_ARCNET_COM90xx=m
> > > CONFIG_ARCNET_COM90xxIO=m
> > > CONFIG_ARCNET_RIM_I=m
> > > CONFIG_ARCNET_COM20020=m
> > > CONFIG_ARCNET_COM20020_PCI=m
> > > CONFIG_ARCNET_COM20020_CS=m
> > > CONFIG_ATM_DRIVERS=y
> > > CONFIG_ATM_DUMMY=m
> > > CONFIG_ATM_TCP=m
> > > CONFIG_ATM_LANAI=m
> > > CONFIG_ATM_ENI=m
> > > # CONFIG_ATM_ENI_DEBUG is not set
> > > # CONFIG_ATM_ENI_TUNE_BURST is not set
> > > CONFIG_ATM_FIRESTREAM=m
> > > CONFIG_ATM_ZATM=m
> > > # CONFIG_ATM_ZATM_DEBUG is not set
> > > CONFIG_ATM_NICSTAR=m
> > > # CONFIG_ATM_NICSTAR_USE_SUNI is not set
> > > # CONFIG_ATM_NICSTAR_USE_IDT77105 is not set
> > > CONFIG_ATM_IDT77252=m
> > > # CONFIG_ATM_IDT77252_DEBUG is not set
> > > # CONFIG_ATM_IDT77252_RCV_ALL is not set
> > > CONFIG_ATM_IDT77252_USE_SUNI=y
> > > CONFIG_ATM_AMBASSADOR=m
> > > # CONFIG_ATM_AMBASSADOR_DEBUG is not set
> > > CONFIG_ATM_HORIZON=m
> > > # CONFIG_ATM_HORIZON_DEBUG is not set
> > > CONFIG_ATM_IA=m
> > > # CONFIG_ATM_IA_DEBUG is not set
> > > CONFIG_ATM_FORE200E=m
> > > # CONFIG_ATM_FORE200E_USE_TASKLET is not set
> > > CONFIG_ATM_FORE200E_TX_RETRY=16
> > > CONFIG_ATM_FORE200E_DEBUG=0
> > > CONFIG_ATM_HE=m
> > > CONFIG_ATM_HE_USE_SUNI=y
> > > CONFIG_ATM_SOLOS=m
> > > 
> > > #
> > > # CAIF transport drivers
> > > #
> > > CONFIG_CAIF_TTY=m
> > > CONFIG_CAIF_SPI_SLAVE=m
> > > # CONFIG_CAIF_SPI_SYNC is not set
> > > CONFIG_CAIF_HSI=m
> > > CONFIG_CAIF_VIRTIO=m
> > > 
> > > #
> > > # Distributed Switch Architecture drivers
> > > #
> > > CONFIG_B53=m
> > > CONFIG_B53_SPI_DRIVER=m
> > > CONFIG_B53_MDIO_DRIVER=m
> > > CONFIG_B53_MMAP_DRIVER=m
> > > CONFIG_B53_SRAB_DRIVER=m
> > > CONFIG_B53_SERDES=m
> > > CONFIG_NET_DSA_BCM_SF2=m
> > > # CONFIG_NET_DSA_LOOP is not set
> > > CONFIG_NET_DSA_LANTIQ_GSWIP=m
> > > CONFIG_NET_DSA_MT7530=m
> > > CONFIG_NET_DSA_MV88E6060=m
> > > CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON=m
> > > CONFIG_NET_DSA_MICROCHIP_KSZ9477=m
> > > CONFIG_NET_DSA_MICROCHIP_KSZ9477_SPI=m
> > > CONFIG_NET_DSA_MV88E6XXX=m
> > > CONFIG_NET_DSA_MV88E6XXX_GLOBAL2=y
> > > CONFIG_NET_DSA_MV88E6XXX_PTP=y
> > > CONFIG_NET_DSA_SJA1105=m
> > > CONFIG_NET_DSA_SJA1105_PTP=y
> > > CONFIG_NET_DSA_QCA8K=m
> > > CONFIG_NET_DSA_REALTEK_SMI=m
> > > CONFIG_NET_DSA_SMSC_LAN9303=m
> > > CONFIG_NET_DSA_SMSC_LAN9303_I2C=m
> > > CONFIG_NET_DSA_SMSC_LAN9303_MDIO=m
> > > # end of Distributed Switch Architecture drivers
> > > 
> > > CONFIG_ETHERNET=y
> > > CONFIG_MDIO=m
> > > CONFIG_NET_VENDOR_3COM=y
> > > CONFIG_EL3=m
> > > CONFIG_PCMCIA_3C574=m
> > > CONFIG_PCMCIA_3C589=m
> > > CONFIG_VORTEX=m
> > > CONFIG_TYPHOON=m
> > > CONFIG_NET_VENDOR_ADAPTEC=y
> > > CONFIG_ADAPTEC_STARFIRE=m
> > > CONFIG_NET_VENDOR_AGERE=y
> > > CONFIG_ET131X=m
> > > CONFIG_NET_VENDOR_ALACRITECH=y
> > > CONFIG_SLICOSS=m
> > > CONFIG_NET_VENDOR_ALTEON=y
> > > CONFIG_ACENIC=m
> > > # CONFIG_ACENIC_OMIT_TIGON_I is not set
> > > CONFIG_ALTERA_TSE=m
> > > CONFIG_NET_VENDOR_AMAZON=y
> > > CONFIG_ENA_ETHERNET=m
> > > CONFIG_NET_VENDOR_AMD=y
> > > CONFIG_AMD8111_ETH=m
> > > CONFIG_PCNET32=m
> > > CONFIG_PCMCIA_NMCLAN=m
> > > CONFIG_AMD_XGBE=m
> > > CONFIG_AMD_XGBE_DCB=y
> > > CONFIG_AMD_XGBE_HAVE_ECC=y
> > > CONFIG_NET_VENDOR_AQUANTIA=y
> > > CONFIG_AQTION=m
> > > CONFIG_NET_VENDOR_ARC=y
> > > CONFIG_NET_VENDOR_ATHEROS=y
> > > CONFIG_ATL2=m
> > > CONFIG_ATL1=m
> > > CONFIG_ATL1E=m
> > > CONFIG_ATL1C=m
> > > CONFIG_ALX=m
> > > CONFIG_NET_VENDOR_AURORA=y
> > > CONFIG_AURORA_NB8800=m
> > > CONFIG_NET_VENDOR_BROADCOM=y
> > > CONFIG_B44=m
> > > CONFIG_B44_PCI_AUTOSELECT=y
> > > CONFIG_B44_PCICORE_AUTOSELECT=y
> > > CONFIG_B44_PCI=y
> > > CONFIG_BCMGENET=m
> > > CONFIG_BNX2=m
> > > CONFIG_CNIC=m
> > > CONFIG_TIGON3=m
> > > CONFIG_TIGON3_HWMON=y
> > > CONFIG_BNX2X=m
> > > CONFIG_BNX2X_SRIOV=y
> > > CONFIG_SYSTEMPORT=m
> > > CONFIG_BNXT=m
> > > CONFIG_BNXT_SRIOV=y
> > > CONFIG_BNXT_FLOWER_OFFLOAD=y
> > > CONFIG_BNXT_DCB=y
> > > CONFIG_BNXT_HWMON=y
> > > CONFIG_NET_VENDOR_BROCADE=y
> > > CONFIG_BNA=m
> > > CONFIG_NET_VENDOR_CADENCE=y
> > > CONFIG_MACB=m
> > > CONFIG_MACB_USE_HWSTAMP=y
> > > CONFIG_MACB_PCI=m
> > > CONFIG_NET_VENDOR_CAVIUM=y
> > > CONFIG_THUNDER_NIC_PF=m
> > > CONFIG_THUNDER_NIC_VF=m
> > > CONFIG_THUNDER_NIC_BGX=m
> > > CONFIG_THUNDER_NIC_RGX=m
> > > CONFIG_CAVIUM_PTP=m
> > > CONFIG_LIQUIDIO=m
> > > CONFIG_LIQUIDIO_VF=m
> > > CONFIG_NET_VENDOR_CHELSIO=y
> > > CONFIG_CHELSIO_T1=m
> > > CONFIG_CHELSIO_T1_1G=y
> > > CONFIG_CHELSIO_T3=m
> > > CONFIG_CHELSIO_T4=m
> > > CONFIG_CHELSIO_T4_DCB=y
> > > CONFIG_CHELSIO_T4_FCOE=y
> > > CONFIG_CHELSIO_T4VF=m
> > > CONFIG_CHELSIO_LIB=m
> > > CONFIG_NET_VENDOR_CIRRUS=y
> > > CONFIG_CS89x0=m
> > > CONFIG_CS89x0_PLATFORM=y
> > > CONFIG_NET_VENDOR_CISCO=y
> > > CONFIG_ENIC=m
> > > CONFIG_NET_VENDOR_CORTINA=y
> > > CONFIG_CX_ECAT=m
> > > CONFIG_DNET=m
> > > CONFIG_NET_VENDOR_DEC=y
> > > CONFIG_NET_TULIP=y
> > > CONFIG_DE2104X=m
> > > CONFIG_DE2104X_DSL=0
> > > CONFIG_TULIP=m
> > > # CONFIG_TULIP_MWI is not set
> > > # CONFIG_TULIP_MMIO is not set
> > > # CONFIG_TULIP_NAPI is not set
> > > CONFIG_DE4X5=m
> > > CONFIG_WINBOND_840=m
> > > CONFIG_DM9102=m
> > > CONFIG_ULI526X=m
> > > CONFIG_PCMCIA_XIRCOM=m
> > > CONFIG_NET_VENDOR_DLINK=y
> > > CONFIG_DL2K=m
> > > CONFIG_SUNDANCE=m
> > > # CONFIG_SUNDANCE_MMIO is not set
> > > CONFIG_NET_VENDOR_EMULEX=y
> > > CONFIG_BE2NET=m
> > > CONFIG_BE2NET_HWMON=y
> > > CONFIG_BE2NET_BE2=y
> > > CONFIG_BE2NET_BE3=y
> > > CONFIG_BE2NET_LANCER=y
> > > CONFIG_BE2NET_SKYHAWK=y
> > > CONFIG_NET_VENDOR_EZCHIP=y
> > > CONFIG_NET_VENDOR_FUJITSU=y
> > > CONFIG_PCMCIA_FMVJ18X=m
> > > CONFIG_NET_VENDOR_GOOGLE=y
> > > CONFIG_GVE=m
> > > CONFIG_NET_VENDOR_HP=y
> > > CONFIG_HP100=m
> > > CONFIG_NET_VENDOR_HUAWEI=y
> > > CONFIG_HINIC=m
> > > CONFIG_NET_VENDOR_I825XX=y
> > > CONFIG_NET_VENDOR_INTEL=y
> > > CONFIG_E100=m
> > > CONFIG_E1000=m
> > > CONFIG_E1000E=m
> > > CONFIG_E1000E_HWTS=y
> > > CONFIG_IGB=m
> > > CONFIG_IGB_HWMON=y
> > > CONFIG_IGB_DCA=y
> > > CONFIG_IGBVF=m
> > > CONFIG_IXGB=m
> > > CONFIG_IXGBE=m
> > > CONFIG_IXGBE_HWMON=y
> > > CONFIG_IXGBE_DCA=y
> > > CONFIG_IXGBE_DCB=y
> > > CONFIG_IXGBE_IPSEC=y
> > > CONFIG_IXGBEVF=m
> > > CONFIG_IXGBEVF_IPSEC=y
> > > CONFIG_I40E=m
> > > CONFIG_I40E_DCB=y
> > > CONFIG_IAVF=m
> > > CONFIG_I40EVF=m
> > > CONFIG_ICE=m
> > > CONFIG_FM10K=m
> > > CONFIG_IGC=m
> > > CONFIG_JME=m
> > > CONFIG_NET_VENDOR_MARVELL=y
> > > CONFIG_MVMDIO=m
> > > CONFIG_SKGE=m
> > > # CONFIG_SKGE_DEBUG is not set
> > > CONFIG_SKGE_GENESIS=y
> > > CONFIG_SKY2=m
> > > # CONFIG_SKY2_DEBUG is not set
> > > CONFIG_NET_VENDOR_MELLANOX=y
> > > CONFIG_MLX4_EN=m
> > > CONFIG_MLX4_EN_DCB=y
> > > CONFIG_MLX4_CORE=m
> > > CONFIG_MLX4_DEBUG=y
> > > CONFIG_MLX4_CORE_GEN2=y
> > > CONFIG_MLX5_CORE=m
> > > CONFIG_MLX5_ACCEL=y
> > > CONFIG_MLX5_FPGA=y
> > > CONFIG_MLX5_CORE_EN=y
> > > CONFIG_MLX5_EN_ARFS=y
> > > CONFIG_MLX5_EN_RXNFC=y
> > > CONFIG_MLX5_MPFS=y
> > > CONFIG_MLX5_ESWITCH=y
> > > CONFIG_MLX5_CORE_EN_DCB=y
> > > CONFIG_MLX5_CORE_IPOIB=y
> > > CONFIG_MLX5_FPGA_IPSEC=y
> > > CONFIG_MLX5_EN_IPSEC=y
> > > CONFIG_MLX5_FPGA_TLS=y
> > > CONFIG_MLX5_TLS=y
> > > CONFIG_MLX5_EN_TLS=y
> > > CONFIG_MLXSW_CORE=m
> > > CONFIG_MLXSW_CORE_HWMON=y
> > > CONFIG_MLXSW_CORE_THERMAL=y
> > > CONFIG_MLXSW_PCI=m
> > > CONFIG_MLXSW_I2C=m
> > > CONFIG_MLXSW_SWITCHIB=m
> > > CONFIG_MLXSW_SWITCHX2=m
> > > CONFIG_MLXSW_SPECTRUM=m
> > > CONFIG_MLXSW_SPECTRUM_DCB=y
> > > CONFIG_MLXSW_MINIMAL=m
> > > CONFIG_MLXFW=m
> > > CONFIG_NET_VENDOR_MICREL=y
> > > CONFIG_KS8842=m
> > > CONFIG_KS8851=m
> > > CONFIG_KS8851_MLL=m
> > > CONFIG_KSZ884X_PCI=m
> > > CONFIG_NET_VENDOR_MICROCHIP=y
> > > CONFIG_ENC28J60=m
> > > # CONFIG_ENC28J60_WRITEVERIFY is not set
> > > CONFIG_ENCX24J600=m
> > > CONFIG_LAN743X=m
> > > CONFIG_NET_VENDOR_MICROSEMI=y
> > > CONFIG_MSCC_OCELOT_SWITCH=m
> > > CONFIG_NET_VENDOR_MYRI=y
> > > CONFIG_MYRI10GE=m
> > > CONFIG_MYRI10GE_DCA=y
> > > CONFIG_FEALNX=m
> > > CONFIG_NET_VENDOR_NATSEMI=y
> > > CONFIG_NATSEMI=m
> > > CONFIG_NS83820=m
> > > CONFIG_NET_VENDOR_NETERION=y
> > > CONFIG_S2IO=m
> > > CONFIG_VXGE=m
> > > # CONFIG_VXGE_DEBUG_TRACE_ALL is not set
> > > CONFIG_NET_VENDOR_NETRONOME=y
> > > CONFIG_NFP=m
> > > CONFIG_NFP_APP_FLOWER=y
> > > CONFIG_NFP_APP_ABM_NIC=y
> > > # CONFIG_NFP_DEBUG is not set
> > > CONFIG_NET_VENDOR_NI=y
> > > CONFIG_NI_XGE_MANAGEMENT_ENET=m
> > > CONFIG_NET_VENDOR_8390=y
> > > CONFIG_PCMCIA_AXNET=m
> > > CONFIG_NE2K_PCI=m
> > > CONFIG_PCMCIA_PCNET=m
> > > CONFIG_NET_VENDOR_NVIDIA=y
> > > CONFIG_FORCEDETH=m
> > > CONFIG_NET_VENDOR_OKI=y
> > > CONFIG_ETHOC=m
> > > CONFIG_NET_VENDOR_PACKET_ENGINES=y
> > > CONFIG_HAMACHI=m
> > > CONFIG_YELLOWFIN=m
> > > CONFIG_NET_VENDOR_QLOGIC=y
> > > CONFIG_QLA3XXX=m
> > > CONFIG_QLCNIC=m
> > > CONFIG_QLCNIC_SRIOV=y
> > > CONFIG_QLCNIC_DCB=y
> > > CONFIG_QLCNIC_HWMON=y
> > > CONFIG_QLGE=m
> > > CONFIG_NETXEN_NIC=m
> > > CONFIG_QED=m
> > > CONFIG_QED_LL2=y
> > > CONFIG_QED_SRIOV=y
> > > CONFIG_QEDE=m
> > > CONFIG_QED_RDMA=y
> > > CONFIG_QED_ISCSI=y
> > > CONFIG_QED_FCOE=y
> > > CONFIG_QED_OOO=y
> > > CONFIG_NET_VENDOR_QUALCOMM=y
> > > CONFIG_QCOM_EMAC=m
> > > CONFIG_RMNET=m
> > > CONFIG_NET_VENDOR_RDC=y
> > > CONFIG_R6040=m
> > > CONFIG_NET_VENDOR_REALTEK=y
> > > CONFIG_ATP=m
> > > CONFIG_8139CP=m
> > > CONFIG_8139TOO=m
> > > CONFIG_8139TOO_PIO=y
> > > # CONFIG_8139TOO_TUNE_TWISTER is not set
> > > CONFIG_8139TOO_8129=y
> > > # CONFIG_8139_OLD_RX_RESET is not set
> > > CONFIG_R8169=m
> > > CONFIG_NET_VENDOR_RENESAS=y
> > > CONFIG_NET_VENDOR_ROCKER=y
> > > CONFIG_ROCKER=m
> > > CONFIG_NET_VENDOR_SAMSUNG=y
> > > CONFIG_SXGBE_ETH=m
> > > CONFIG_NET_VENDOR_SEEQ=y
> > > CONFIG_NET_VENDOR_SOLARFLARE=y
> > > CONFIG_SFC=m
> > > CONFIG_SFC_MTD=y
> > > CONFIG_SFC_MCDI_MON=y
> > > CONFIG_SFC_SRIOV=y
> > > CONFIG_SFC_MCDI_LOGGING=y
> > > CONFIG_SFC_FALCON=m
> > > CONFIG_SFC_FALCON_MTD=y
> > > CONFIG_NET_VENDOR_SILAN=y
> > > CONFIG_SC92031=m
> > > CONFIG_NET_VENDOR_SIS=y
> > > CONFIG_SIS900=m
> > > CONFIG_SIS190=m
> > > CONFIG_NET_VENDOR_SMSC=y
> > > CONFIG_PCMCIA_SMC91C92=m
> > > CONFIG_EPIC100=m
> > > CONFIG_SMSC911X=m
> > > CONFIG_SMSC9420=m
> > > CONFIG_NET_VENDOR_SOCIONEXT=y
> > > CONFIG_NET_VENDOR_STMICRO=y
> > > CONFIG_STMMAC_ETH=m
> > > # CONFIG_STMMAC_SELFTESTS is not set
> > > CONFIG_STMMAC_PLATFORM=m
> > > CONFIG_DWMAC_GENERIC=m
> > > # CONFIG_STMMAC_PCI is not set
> > > CONFIG_NET_VENDOR_SUN=y
> > > CONFIG_HAPPYMEAL=m
> > > CONFIG_SUNGEM=m
> > > CONFIG_CASSINI=m
> > > CONFIG_NIU=m
> > > CONFIG_NET_VENDOR_SYNOPSYS=y
> > > CONFIG_DWC_XLGMAC=m
> > > CONFIG_DWC_XLGMAC_PCI=m
> > > CONFIG_NET_VENDOR_TEHUTI=y
> > > CONFIG_TEHUTI=m
> > > CONFIG_NET_VENDOR_TI=y
> > > # CONFIG_TI_CPSW_PHY_SEL is not set
> > > CONFIG_TLAN=m
> > > CONFIG_NET_VENDOR_VIA=y
> > > CONFIG_VIA_RHINE=m
> > > CONFIG_VIA_RHINE_MMIO=y
> > > CONFIG_VIA_VELOCITY=m
> > > CONFIG_NET_VENDOR_WIZNET=y
> > > CONFIG_WIZNET_W5100=m
> > > CONFIG_WIZNET_W5300=m
> > > # CONFIG_WIZNET_BUS_DIRECT is not set
> > > # CONFIG_WIZNET_BUS_INDIRECT is not set
> > > CONFIG_WIZNET_BUS_ANY=y
> > > CONFIG_WIZNET_W5100_SPI=m
> > > CONFIG_NET_VENDOR_XILINX=y
> > > CONFIG_XILINX_AXI_EMAC=m
> > > CONFIG_XILINX_LL_TEMAC=m
> > > CONFIG_NET_VENDOR_XIRCOM=y
> > > CONFIG_PCMCIA_XIRC2PS=m
> > > CONFIG_FDDI=y
> > > CONFIG_DEFXX=m
> > > # CONFIG_DEFXX_MMIO is not set
> > > CONFIG_SKFP=m
> > > # CONFIG_HIPPI is not set
> > > CONFIG_NET_SB1000=m
> > > CONFIG_MDIO_DEVICE=y
> > > CONFIG_MDIO_BUS=y
> > > CONFIG_MDIO_BCM_UNIMAC=m
> > > CONFIG_MDIO_BITBANG=m
> > > CONFIG_MDIO_CAVIUM=m
> > > CONFIG_MDIO_GPIO=m
> > > CONFIG_MDIO_I2C=m
> > > CONFIG_MDIO_MSCC_MIIM=m
> > > CONFIG_MDIO_THUNDER=m
> > > CONFIG_PHYLINK=m
> > > CONFIG_PHYLIB=y
> > > CONFIG_SWPHY=y
> > > CONFIG_LED_TRIGGER_PHY=y
> > > 
> > > #
> > > # MII PHY device drivers
> > > #
> > > CONFIG_SFP=m
> > > CONFIG_AMD_PHY=m
> > > CONFIG_AQUANTIA_PHY=m
> > > CONFIG_AX88796B_PHY=m
> > > CONFIG_AT803X_PHY=m
> > > CONFIG_BCM7XXX_PHY=m
> > > CONFIG_BCM87XX_PHY=m
> > > CONFIG_BCM_NET_PHYLIB=m
> > > CONFIG_BROADCOM_PHY=m
> > > CONFIG_CICADA_PHY=m
> > > CONFIG_CORTINA_PHY=m
> > > CONFIG_DAVICOM_PHY=m
> > > CONFIG_DP83822_PHY=m
> > > CONFIG_DP83TC811_PHY=m
> > > CONFIG_DP83848_PHY=m
> > > CONFIG_DP83867_PHY=m
> > > CONFIG_FIXED_PHY=y
> > > CONFIG_ICPLUS_PHY=m
> > > CONFIG_INTEL_XWAY_PHY=m
> > > CONFIG_LSI_ET1011C_PHY=m
> > > CONFIG_LXT_PHY=m
> > > CONFIG_MARVELL_PHY=m
> > > CONFIG_MARVELL_10G_PHY=m
> > > CONFIG_MICREL_PHY=m
> > > CONFIG_MICROCHIP_PHY=m
> > > CONFIG_MICROCHIP_T1_PHY=m
> > > CONFIG_MICROSEMI_PHY=m
> > > CONFIG_NATIONAL_PHY=m
> > > CONFIG_NXP_TJA11XX_PHY=m
> > > CONFIG_QSEMI_PHY=m
> > > CONFIG_REALTEK_PHY=m
> > > CONFIG_RENESAS_PHY=m
> > > CONFIG_ROCKCHIP_PHY=m
> > > CONFIG_SMSC_PHY=m
> > > CONFIG_STE10XP=m
> > > CONFIG_TERANETICS_PHY=m
> > > CONFIG_VITESSE_PHY=m
> > > CONFIG_XILINX_GMII2RGMII=m
> > > CONFIG_MICREL_KS8995MA=m
> > > CONFIG_PLIP=m
> > > CONFIG_PPP=y
> > > CONFIG_PPP_BSDCOMP=m
> > > CONFIG_PPP_DEFLATE=m
> > > CONFIG_PPP_FILTER=y
> > > CONFIG_PPP_MPPE=m
> > > CONFIG_PPP_MULTILINK=y
> > > CONFIG_PPPOATM=m
> > > CONFIG_PPPOE=m
> > > CONFIG_PPTP=m
> > > CONFIG_PPPOL2TP=m
> > > CONFIG_PPP_ASYNC=m
> > > CONFIG_PPP_SYNC_TTY=m
> > > CONFIG_SLIP=m
> > > CONFIG_SLHC=y
> > > CONFIG_SLIP_COMPRESSED=y
> > > CONFIG_SLIP_SMART=y
> > > CONFIG_SLIP_MODE_SLIP6=y
> > > CONFIG_USB_NET_DRIVERS=m
> > > CONFIG_USB_CATC=m
> > > CONFIG_USB_KAWETH=m
> > > CONFIG_USB_PEGASUS=m
> > > CONFIG_USB_RTL8150=m
> > > CONFIG_USB_RTL8152=m
> > > CONFIG_USB_LAN78XX=m
> > > CONFIG_USB_USBNET=m
> > > CONFIG_USB_NET_AX8817X=m
> > > CONFIG_USB_NET_AX88179_178A=m
> > > CONFIG_USB_NET_CDCETHER=m
> > > CONFIG_USB_NET_CDC_EEM=m
> > > CONFIG_USB_NET_CDC_NCM=m
> > > CONFIG_USB_NET_HUAWEI_CDC_NCM=m
> > > CONFIG_USB_NET_CDC_MBIM=m
> > > CONFIG_USB_NET_DM9601=m
> > > CONFIG_USB_NET_SR9700=m
> > > CONFIG_USB_NET_SR9800=m
> > > CONFIG_USB_NET_SMSC75XX=m
> > > CONFIG_USB_NET_SMSC95XX=m
> > > CONFIG_USB_NET_GL620A=m
> > > CONFIG_USB_NET_NET1080=m
> > > CONFIG_USB_NET_PLUSB=m
> > > CONFIG_USB_NET_MCS7830=m
> > > CONFIG_USB_NET_RNDIS_HOST=m
> > > CONFIG_USB_NET_CDC_SUBSET_ENABLE=m
> > > CONFIG_USB_NET_CDC_SUBSET=m
> > > CONFIG_USB_ALI_M5632=y
> > > CONFIG_USB_AN2720=y
> > > CONFIG_USB_BELKIN=y
> > > CONFIG_USB_ARMLINUX=y
> > > CONFIG_USB_EPSON2888=y
> > > CONFIG_USB_KC2190=y
> > > CONFIG_USB_NET_ZAURUS=m
> > > CONFIG_USB_NET_CX82310_ETH=m
> > > CONFIG_USB_NET_KALMIA=m
> > > CONFIG_USB_NET_QMI_WWAN=m
> > > CONFIG_USB_HSO=m
> > > CONFIG_USB_NET_INT51X1=m
> > > CONFIG_USB_CDC_PHONET=m
> > > CONFIG_USB_IPHETH=m
> > > CONFIG_USB_SIERRA_NET=m
> > > CONFIG_USB_VL600=m
> > > CONFIG_USB_NET_CH9200=m
> > > CONFIG_USB_NET_AQC111=m
> > > CONFIG_WLAN=y
> > > # CONFIG_WIRELESS_WDS is not set
> > > CONFIG_WLAN_VENDOR_ADMTEK=y
> > > CONFIG_ADM8211=m
> > > CONFIG_ATH_COMMON=m
> > > CONFIG_WLAN_VENDOR_ATH=y
> > > # CONFIG_ATH_DEBUG is not set
> > > CONFIG_ATH5K=m
> > > # CONFIG_ATH5K_DEBUG is not set
> > > # CONFIG_ATH5K_TRACER is not set
> > > CONFIG_ATH5K_PCI=y
> > > CONFIG_ATH9K_HW=m
> > > CONFIG_ATH9K_COMMON=m
> > > CONFIG_ATH9K_COMMON_DEBUG=y
> > > CONFIG_ATH9K_BTCOEX_SUPPORT=y
> > > CONFIG_ATH9K=m
> > > CONFIG_ATH9K_PCI=y
> > > CONFIG_ATH9K_AHB=y
> > > CONFIG_ATH9K_DEBUGFS=y
> > > CONFIG_ATH9K_STATION_STATISTICS=y
> > > # CONFIG_ATH9K_DYNACK is not set
> > > CONFIG_ATH9K_WOW=y
> > > CONFIG_ATH9K_RFKILL=y
> > > CONFIG_ATH9K_CHANNEL_CONTEXT=y
> > > CONFIG_ATH9K_PCOEM=y
> > > CONFIG_ATH9K_HTC=m
> > > CONFIG_ATH9K_HTC_DEBUGFS=y
> > > CONFIG_ATH9K_HWRNG=y
> > > CONFIG_ATH9K_COMMON_SPECTRAL=y
> > > CONFIG_CARL9170=m
> > > CONFIG_CARL9170_LEDS=y
> > > # CONFIG_CARL9170_DEBUGFS is not set
> > > CONFIG_CARL9170_WPC=y
> > > CONFIG_CARL9170_HWRNG=y
> > > CONFIG_ATH6KL=m
> > > CONFIG_ATH6KL_SDIO=m
> > > CONFIG_ATH6KL_USB=m
> > > # CONFIG_ATH6KL_DEBUG is not set
> > > # CONFIG_ATH6KL_TRACING is not set
> > > CONFIG_AR5523=m
> > > CONFIG_WIL6210=m
> > > CONFIG_WIL6210_ISR_COR=y
> > > CONFIG_WIL6210_TRACING=y
> > > CONFIG_WIL6210_DEBUGFS=y
> > > CONFIG_ATH10K=m
> > > CONFIG_ATH10K_CE=y
> > > CONFIG_ATH10K_PCI=m
> > > CONFIG_ATH10K_SDIO=m
> > > CONFIG_ATH10K_USB=m
> > > # CONFIG_ATH10K_DEBUG is not set
> > > CONFIG_ATH10K_DEBUGFS=y
> > > CONFIG_ATH10K_SPECTRAL=y
> > > CONFIG_ATH10K_TRACING=y
> > > CONFIG_WCN36XX=m
> > > # CONFIG_WCN36XX_DEBUGFS is not set
> > > # CONFIG_WCN36XX_SNAPDRAGON_HACKS is not set
> > > CONFIG_WLAN_VENDOR_ATMEL=y
> > > CONFIG_ATMEL=m
> > > CONFIG_PCI_ATMEL=m
> > > CONFIG_PCMCIA_ATMEL=m
> > > CONFIG_AT76C50X_USB=m
> > > CONFIG_WLAN_VENDOR_BROADCOM=y
> > > CONFIG_B43=m
> > > CONFIG_B43_BCMA=y
> > > CONFIG_B43_SSB=y
> > > CONFIG_B43_BUSES_BCMA_AND_SSB=y
> > > # CONFIG_B43_BUSES_BCMA is not set
> > > # CONFIG_B43_BUSES_SSB is not set
> > > CONFIG_B43_PCI_AUTOSELECT=y
> > > CONFIG_B43_PCICORE_AUTOSELECT=y
> > > # CONFIG_B43_SDIO is not set
> > > CONFIG_B43_BCMA_PIO=y
> > > CONFIG_B43_PIO=y
> > > CONFIG_B43_PHY_G=y
> > > CONFIG_B43_PHY_N=y
> > > CONFIG_B43_PHY_LP=y
> > > CONFIG_B43_PHY_HT=y
> > > CONFIG_B43_LEDS=y
> > > CONFIG_B43_HWRNG=y
> > > # CONFIG_B43_DEBUG is not set
> > > CONFIG_B43LEGACY=m
> > > CONFIG_B43LEGACY_PCI_AUTOSELECT=y
> > > CONFIG_B43LEGACY_PCICORE_AUTOSELECT=y
> > > CONFIG_B43LEGACY_LEDS=y
> > > CONFIG_B43LEGACY_HWRNG=y
> > > # CONFIG_B43LEGACY_DEBUG is not set
> > > CONFIG_B43LEGACY_DMA=y
> > > CONFIG_B43LEGACY_PIO=y
> > > CONFIG_B43LEGACY_DMA_AND_PIO_MODE=y
> > > # CONFIG_B43LEGACY_DMA_MODE is not set
> > > # CONFIG_B43LEGACY_PIO_MODE is not set
> > > CONFIG_BRCMUTIL=m
> > > CONFIG_BRCMSMAC=m
> > > CONFIG_BRCMFMAC=m
> > > CONFIG_BRCMFMAC_PROTO_BCDC=y
> > > CONFIG_BRCMFMAC_PROTO_MSGBUF=y
> > > CONFIG_BRCMFMAC_SDIO=y
> > > CONFIG_BRCMFMAC_USB=y
> > > CONFIG_BRCMFMAC_PCIE=y
> > > CONFIG_BRCM_TRACING=y
> > > # CONFIG_BRCMDBG is not set
> > > CONFIG_WLAN_VENDOR_CISCO=y
> > > CONFIG_AIRO=m
> > > CONFIG_AIRO_CS=m
> > > CONFIG_WLAN_VENDOR_INTEL=y
> > > CONFIG_IPW2100=m
> > > CONFIG_IPW2100_MONITOR=y
> > > # CONFIG_IPW2100_DEBUG is not set
> > > CONFIG_IPW2200=m
> > > CONFIG_IPW2200_MONITOR=y
> > > CONFIG_IPW2200_RADIOTAP=y
> > > CONFIG_IPW2200_PROMISCUOUS=y
> > > CONFIG_IPW2200_QOS=y
> > > # CONFIG_IPW2200_DEBUG is not set
> > > CONFIG_LIBIPW=m
> > > # CONFIG_LIBIPW_DEBUG is not set
> > > CONFIG_IWLEGACY=m
> > > CONFIG_IWL4965=m
> > > CONFIG_IWL3945=m
> > > 
> > > #
> > > # iwl3945 / iwl4965 Debugging Options
> > > #
> > > # CONFIG_IWLEGACY_DEBUG is not set
> > > CONFIG_IWLEGACY_DEBUGFS=y
> > > # end of iwl3945 / iwl4965 Debugging Options
> > > 
> > > CONFIG_IWLWIFI=m
> > > CONFIG_IWLWIFI_LEDS=y
> > > CONFIG_IWLDVM=m
> > > CONFIG_IWLMVM=m
> > > CONFIG_IWLWIFI_OPMODE_MODULAR=y
> > > # CONFIG_IWLWIFI_BCAST_FILTERING is not set
> > > # CONFIG_IWLWIFI_PCIE_RTPM is not set
> > > 
> > > #
> > > # Debugging Options
> > > #
> > > # CONFIG_IWLWIFI_DEBUG is not set
> > > CONFIG_IWLWIFI_DEBUGFS=y
> > > CONFIG_IWLWIFI_DEVICE_TRACING=y
> > > # end of Debugging Options
> > > 
> > > CONFIG_WLAN_VENDOR_INTERSIL=y
> > > CONFIG_HOSTAP=m
> > > CONFIG_HOSTAP_FIRMWARE=y
> > > CONFIG_HOSTAP_FIRMWARE_NVRAM=y
> > > CONFIG_HOSTAP_PLX=m
> > > CONFIG_HOSTAP_PCI=m
> > > CONFIG_HOSTAP_CS=m
> > > CONFIG_HERMES=m
> > > # CONFIG_HERMES_PRISM is not set
> > > CONFIG_HERMES_CACHE_FW_ON_INIT=y
> > > CONFIG_PLX_HERMES=m
> > > CONFIG_TMD_HERMES=m
> > > CONFIG_NORTEL_HERMES=m
> > > CONFIG_PCMCIA_HERMES=m
> > > CONFIG_PCMCIA_SPECTRUM=m
> > > CONFIG_ORINOCO_USB=m
> > > CONFIG_P54_COMMON=m
> > > CONFIG_P54_USB=m
> > > CONFIG_P54_PCI=m
> > > CONFIG_P54_SPI=m
> > > # CONFIG_P54_SPI_DEFAULT_EEPROM is not set
> > > CONFIG_P54_LEDS=y
> > > # CONFIG_PRISM54 is not set
> > > CONFIG_WLAN_VENDOR_MARVELL=y
> > > CONFIG_LIBERTAS=m
> > > CONFIG_LIBERTAS_USB=m
> > > CONFIG_LIBERTAS_CS=m
> > > CONFIG_LIBERTAS_SDIO=m
> > > CONFIG_LIBERTAS_SPI=m
> > > # CONFIG_LIBERTAS_DEBUG is not set
> > > CONFIG_LIBERTAS_MESH=y
> > > CONFIG_LIBERTAS_THINFIRM=m
> > > # CONFIG_LIBERTAS_THINFIRM_DEBUG is not set
> > > CONFIG_LIBERTAS_THINFIRM_USB=m
> > > CONFIG_MWIFIEX=m
> > > CONFIG_MWIFIEX_SDIO=m
> > > CONFIG_MWIFIEX_PCIE=m
> > > CONFIG_MWIFIEX_USB=m
> > > CONFIG_MWL8K=m
> > > CONFIG_WLAN_VENDOR_MEDIATEK=y
> > > CONFIG_MT7601U=m
> > > CONFIG_MT76_CORE=m
> > > CONFIG_MT76_LEDS=y
> > > CONFIG_MT76_USB=m
> > > CONFIG_MT76x02_LIB=m
> > > CONFIG_MT76x02_USB=m
> > > CONFIG_MT76x0_COMMON=m
> > > CONFIG_MT76x0U=m
> > > CONFIG_MT76x0E=m
> > > CONFIG_MT76x2_COMMON=m
> > > CONFIG_MT76x2E=m
> > > CONFIG_MT76x2U=m
> > > CONFIG_MT7603E=m
> > > CONFIG_MT7615E=m
> > > CONFIG_WLAN_VENDOR_RALINK=y
> > > CONFIG_RT2X00=m
> > > CONFIG_RT2400PCI=m
> > > CONFIG_RT2500PCI=m
> > > CONFIG_RT61PCI=m
> > > CONFIG_RT2800PCI=m
> > > CONFIG_RT2800PCI_RT33XX=y
> > > CONFIG_RT2800PCI_RT35XX=y
> > > CONFIG_RT2800PCI_RT53XX=y
> > > CONFIG_RT2800PCI_RT3290=y
> > > CONFIG_RT2500USB=m
> > > CONFIG_RT73USB=m
> > > CONFIG_RT2800USB=m
> > > CONFIG_RT2800USB_RT33XX=y
> > > CONFIG_RT2800USB_RT35XX=y
> > > CONFIG_RT2800USB_RT3573=y
> > > CONFIG_RT2800USB_RT53XX=y
> > > CONFIG_RT2800USB_RT55XX=y
> > > CONFIG_RT2800USB_UNKNOWN=y
> > > CONFIG_RT2800_LIB=m
> > > CONFIG_RT2800_LIB_MMIO=m
> > > CONFIG_RT2X00_LIB_MMIO=m
> > > CONFIG_RT2X00_LIB_PCI=m
> > > CONFIG_RT2X00_LIB_USB=m
> > > CONFIG_RT2X00_LIB=m
> > > CONFIG_RT2X00_LIB_FIRMWARE=y
> > > CONFIG_RT2X00_LIB_CRYPTO=y
> > > CONFIG_RT2X00_LIB_LEDS=y
> > > # CONFIG_RT2X00_LIB_DEBUGFS is not set
> > > # CONFIG_RT2X00_DEBUG is not set
> > > CONFIG_WLAN_VENDOR_REALTEK=y
> > > CONFIG_RTL8180=m
> > > CONFIG_RTL8187=m
> > > CONFIG_RTL8187_LEDS=y
> > > CONFIG_RTL_CARDS=m
> > > CONFIG_RTL8192CE=m
> > > CONFIG_RTL8192SE=m
> > > CONFIG_RTL8192DE=m
> > > CONFIG_RTL8723AE=m
> > > CONFIG_RTL8723BE=m
> > > CONFIG_RTL8188EE=m
> > > CONFIG_RTL8192EE=m
> > > CONFIG_RTL8821AE=m
> > > CONFIG_RTL8192CU=m
> > > CONFIG_RTLWIFI=m
> > > CONFIG_RTLWIFI_PCI=m
> > > CONFIG_RTLWIFI_USB=m
> > > # CONFIG_RTLWIFI_DEBUG is not set
> > > CONFIG_RTL8192C_COMMON=m
> > > CONFIG_RTL8723_COMMON=m
> > > CONFIG_RTLBTCOEXIST=m
> > > CONFIG_RTL8XXXU=m
> > > CONFIG_RTL8XXXU_UNTESTED=y
> > > CONFIG_RTW88=m
> > > CONFIG_RTW88_CORE=m
> > > CONFIG_RTW88_PCI=m
> > > CONFIG_RTW88_8822BE=y
> > > CONFIG_RTW88_8822CE=y
> > > CONFIG_RTW88_DEBUG=y
> > > CONFIG_RTW88_DEBUGFS=y
> > > CONFIG_WLAN_VENDOR_RSI=y
> > > CONFIG_RSI_91X=m
> > > # CONFIG_RSI_DEBUGFS is not set
> > > CONFIG_RSI_SDIO=m
> > > CONFIG_RSI_USB=m
> > > CONFIG_RSI_COEX=y
> > > CONFIG_WLAN_VENDOR_ST=y
> > > CONFIG_CW1200=m
> > > CONFIG_CW1200_WLAN_SDIO=m
> > > CONFIG_CW1200_WLAN_SPI=m
> > > CONFIG_WLAN_VENDOR_TI=y
> > > CONFIG_WL1251=m
> > > CONFIG_WL1251_SPI=m
> > > CONFIG_WL1251_SDIO=m
> > > CONFIG_WL12XX=m
> > > CONFIG_WL18XX=m
> > > CONFIG_WLCORE=m
> > > CONFIG_WLCORE_SDIO=m
> > > CONFIG_WILINK_PLATFORM_DATA=y
> > > CONFIG_WLAN_VENDOR_ZYDAS=y
> > > CONFIG_USB_ZD1201=m
> > > CONFIG_ZD1211RW=m
> > > # CONFIG_ZD1211RW_DEBUG is not set
> > > CONFIG_WLAN_VENDOR_QUANTENNA=y
> > > CONFIG_QTNFMAC=m
> > > CONFIG_QTNFMAC_PCIE=m
> > > CONFIG_PCMCIA_RAYCS=m
> > > CONFIG_PCMCIA_WL3501=m
> > > CONFIG_MAC80211_HWSIM=m
> > > CONFIG_USB_NET_RNDIS_WLAN=m
> > > CONFIG_VIRT_WIFI=m
> > > 
> > > #
> > > # WiMAX Wireless Broadband devices
> > > #
> > > CONFIG_WIMAX_I2400M=m
> > > CONFIG_WIMAX_I2400M_USB=m
> > > CONFIG_WIMAX_I2400M_DEBUG_LEVEL=8
> > > # end of WiMAX Wireless Broadband devices
> > > 
> > > CONFIG_WAN=y
> > > CONFIG_LANMEDIA=m
> > > CONFIG_HDLC=m
> > > CONFIG_HDLC_RAW=m
> > > CONFIG_HDLC_RAW_ETH=m
> > > CONFIG_HDLC_CISCO=m
> > > CONFIG_HDLC_FR=m
> > > CONFIG_HDLC_PPP=m
> > > CONFIG_HDLC_X25=m
> > > CONFIG_PCI200SYN=m
> > > CONFIG_WANXL=m
> > > CONFIG_PC300TOO=m
> > > CONFIG_FARSYNC=m
> > > CONFIG_DSCC4=m
> > > CONFIG_DSCC4_PCISYNC=y
> > > CONFIG_DSCC4_PCI_RST=y
> > > CONFIG_DLCI=m
> > > CONFIG_DLCI_MAX=8
> > > CONFIG_LAPBETHER=m
> > > CONFIG_X25_ASY=m
> > > CONFIG_SBNI=m
> > > # CONFIG_SBNI_MULTILINE is not set
> > > CONFIG_IEEE802154_DRIVERS=m
> > > CONFIG_IEEE802154_FAKELB=m
> > > CONFIG_IEEE802154_AT86RF230=m
> > > CONFIG_IEEE802154_AT86RF230_DEBUGFS=y
> > > CONFIG_IEEE802154_MRF24J40=m
> > > CONFIG_IEEE802154_CC2520=m
> > > CONFIG_IEEE802154_ATUSB=m
> > > CONFIG_IEEE802154_ADF7242=m
> > > CONFIG_IEEE802154_CA8210=m
> > > CONFIG_IEEE802154_CA8210_DEBUGFS=y
> > > CONFIG_IEEE802154_MCR20A=m
> > > CONFIG_IEEE802154_HWSIM=m
> > > CONFIG_XEN_NETDEV_FRONTEND=y
> > > CONFIG_XEN_NETDEV_BACKEND=m
> > > CONFIG_VMXNET3=m
> > > CONFIG_FUJITSU_ES=m
> > > CONFIG_THUNDERBOLT_NET=m
> > > CONFIG_HYPERV_NET=m
> > > CONFIG_NETDEVSIM=m
> > > CONFIG_NET_FAILOVER=m
> > > CONFIG_ISDN=y
> > > CONFIG_ISDN_CAPI=m
> > > CONFIG_CAPI_TRACE=y
> > > CONFIG_ISDN_CAPI_CAPI20=m
> > > CONFIG_ISDN_CAPI_MIDDLEWARE=y
> > > CONFIG_MISDN=m
> > > CONFIG_MISDN_DSP=m
> > > CONFIG_MISDN_L1OIP=m
> > > 
> > > #
> > > # mISDN hardware drivers
> > > #
> > > CONFIG_MISDN_HFCPCI=m
> > > CONFIG_MISDN_HFCMULTI=m
> > > CONFIG_MISDN_HFCUSB=m
> > > CONFIG_MISDN_AVMFRITZ=m
> > > CONFIG_MISDN_SPEEDFAX=m
> > > CONFIG_MISDN_INFINEON=m
> > > CONFIG_MISDN_W6692=m
> > > CONFIG_MISDN_NETJET=m
> > > CONFIG_MISDN_HDLC=m
> > > CONFIG_MISDN_IPAC=m
> > > CONFIG_MISDN_ISAR=m
> > > CONFIG_NVM=y
> > > CONFIG_NVM_PBLK=m
> > > # CONFIG_NVM_PBLK_DEBUG is not set
> > > 
> > > #
> > > # Input device support
> > > #
> > > CONFIG_INPUT=y
> > > CONFIG_INPUT_LEDS=m
> > > CONFIG_INPUT_FF_MEMLESS=m
> > > CONFIG_INPUT_POLLDEV=m
> > > CONFIG_INPUT_SPARSEKMAP=m
> > > CONFIG_INPUT_MATRIXKMAP=m
> > > 
> > > #
> > > # Userland interfaces
> > > #
> > > CONFIG_INPUT_MOUSEDEV=y
> > > CONFIG_INPUT_MOUSEDEV_PSAUX=y
> > > CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> > > CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> > > CONFIG_INPUT_JOYDEV=m
> > > CONFIG_INPUT_EVDEV=y
> > > CONFIG_INPUT_EVBUG=m
> > > 
> > > #
> > > # Input Device Drivers
> > > #
> > > CONFIG_INPUT_KEYBOARD=y
> > > CONFIG_KEYBOARD_ADC=m
> > > CONFIG_KEYBOARD_ADP5520=m
> > > CONFIG_KEYBOARD_ADP5588=m
> > > CONFIG_KEYBOARD_ADP5589=m
> > > CONFIG_KEYBOARD_APPLESPI=m
> > > CONFIG_KEYBOARD_ATKBD=y
> > > CONFIG_KEYBOARD_QT1050=m
> > > CONFIG_KEYBOARD_QT1070=m
> > > CONFIG_KEYBOARD_QT2160=m
> > > CONFIG_KEYBOARD_DLINK_DIR685=m
> > > CONFIG_KEYBOARD_LKKBD=m
> > > CONFIG_KEYBOARD_GPIO=m
> > > CONFIG_KEYBOARD_GPIO_POLLED=m
> > > CONFIG_KEYBOARD_TCA6416=m
> > > CONFIG_KEYBOARD_TCA8418=m
> > > CONFIG_KEYBOARD_MATRIX=m
> > > CONFIG_KEYBOARD_LM8323=m
> > > CONFIG_KEYBOARD_LM8333=m
> > > CONFIG_KEYBOARD_MAX7359=m
> > > CONFIG_KEYBOARD_MCS=m
> > > CONFIG_KEYBOARD_MPR121=m
> > > CONFIG_KEYBOARD_NEWTON=m
> > > CONFIG_KEYBOARD_OPENCORES=m
> > > CONFIG_KEYBOARD_SAMSUNG=m
> > > CONFIG_KEYBOARD_STOWAWAY=m
> > > CONFIG_KEYBOARD_SUNKBD=m
> > > CONFIG_KEYBOARD_TM2_TOUCHKEY=m
> > > CONFIG_KEYBOARD_TWL4030=m
> > > CONFIG_KEYBOARD_XTKBD=m
> > > CONFIG_KEYBOARD_CROS_EC=m
> > > CONFIG_KEYBOARD_MTK_PMIC=m
> > > CONFIG_INPUT_MOUSE=y
> > > CONFIG_MOUSE_PS2=m
> > > CONFIG_MOUSE_PS2_ALPS=y
> > > CONFIG_MOUSE_PS2_BYD=y
> > > CONFIG_MOUSE_PS2_LOGIPS2PP=y
> > > CONFIG_MOUSE_PS2_SYNAPTICS=y
> > > CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
> > > CONFIG_MOUSE_PS2_CYPRESS=y
> > > CONFIG_MOUSE_PS2_LIFEBOOK=y
> > > CONFIG_MOUSE_PS2_TRACKPOINT=y
> > > CONFIG_MOUSE_PS2_ELANTECH=y
> > > CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
> > > CONFIG_MOUSE_PS2_SENTELIC=y
> > > CONFIG_MOUSE_PS2_TOUCHKIT=y
> > > CONFIG_MOUSE_PS2_FOCALTECH=y
> > > CONFIG_MOUSE_PS2_VMMOUSE=y
> > > CONFIG_MOUSE_PS2_SMBUS=y
> > > CONFIG_MOUSE_SERIAL=m
> > > CONFIG_MOUSE_APPLETOUCH=m
> > > CONFIG_MOUSE_BCM5974=m
> > > CONFIG_MOUSE_CYAPA=m
> > > CONFIG_MOUSE_ELAN_I2C=m
> > > CONFIG_MOUSE_ELAN_I2C_I2C=y
> > > CONFIG_MOUSE_ELAN_I2C_SMBUS=y
> > > CONFIG_MOUSE_VSXXXAA=m
> > > CONFIG_MOUSE_GPIO=m
> > > CONFIG_MOUSE_SYNAPTICS_I2C=m
> > > CONFIG_MOUSE_SYNAPTICS_USB=m
> > > CONFIG_INPUT_JOYSTICK=y
> > > CONFIG_JOYSTICK_ANALOG=m
> > > CONFIG_JOYSTICK_A3D=m
> > > CONFIG_JOYSTICK_ADI=m
> > > CONFIG_JOYSTICK_COBRA=m
> > > CONFIG_JOYSTICK_GF2K=m
> > > CONFIG_JOYSTICK_GRIP=m
> > > CONFIG_JOYSTICK_GRIP_MP=m
> > > CONFIG_JOYSTICK_GUILLEMOT=m
> > > CONFIG_JOYSTICK_INTERACT=m
> > > CONFIG_JOYSTICK_SIDEWINDER=m
> > > CONFIG_JOYSTICK_TMDC=m
> > > CONFIG_JOYSTICK_IFORCE=m
> > > CONFIG_JOYSTICK_IFORCE_USB=m
> > > CONFIG_JOYSTICK_IFORCE_232=m
> > > CONFIG_JOYSTICK_WARRIOR=m
> > > CONFIG_JOYSTICK_MAGELLAN=m
> > > CONFIG_JOYSTICK_SPACEORB=m
> > > CONFIG_JOYSTICK_SPACEBALL=m
> > > CONFIG_JOYSTICK_STINGER=m
> > > CONFIG_JOYSTICK_TWIDJOY=m
> > > CONFIG_JOYSTICK_ZHENHUA=m
> > > CONFIG_JOYSTICK_DB9=m
> > > CONFIG_JOYSTICK_GAMECON=m
> > > CONFIG_JOYSTICK_TURBOGRAFX=m
> > > CONFIG_JOYSTICK_AS5011=m
> > > CONFIG_JOYSTICK_JOYDUMP=m
> > > CONFIG_JOYSTICK_XPAD=m
> > > CONFIG_JOYSTICK_XPAD_FF=y
> > > CONFIG_JOYSTICK_XPAD_LEDS=y
> > > CONFIG_JOYSTICK_WALKERA0701=m
> > > CONFIG_JOYSTICK_PSXPAD_SPI=m
> > > CONFIG_JOYSTICK_PSXPAD_SPI_FF=y
> > > CONFIG_JOYSTICK_PXRC=m
> > > CONFIG_INPUT_TABLET=y
> > > CONFIG_TABLET_USB_ACECAD=m
> > > CONFIG_TABLET_USB_AIPTEK=m
> > > CONFIG_TABLET_USB_GTCO=m
> > > CONFIG_TABLET_USB_HANWANG=m
> > > CONFIG_TABLET_USB_KBTAB=m
> > > CONFIG_TABLET_USB_PEGASUS=m
> > > CONFIG_TABLET_SERIAL_WACOM4=m
> > > CONFIG_INPUT_TOUCHSCREEN=y
> > > CONFIG_TOUCHSCREEN_PROPERTIES=y
> > > CONFIG_TOUCHSCREEN_88PM860X=m
> > > CONFIG_TOUCHSCREEN_ADS7846=m
> > > CONFIG_TOUCHSCREEN_AD7877=m
> > > CONFIG_TOUCHSCREEN_AD7879=m
> > > CONFIG_TOUCHSCREEN_AD7879_I2C=m
> > > CONFIG_TOUCHSCREEN_AD7879_SPI=m
> > > CONFIG_TOUCHSCREEN_ADC=m
> > > CONFIG_TOUCHSCREEN_ATMEL_MXT=m
> > > CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
> > > CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
> > > CONFIG_TOUCHSCREEN_BU21013=m
> > > CONFIG_TOUCHSCREEN_BU21029=m
> > > CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=m
> > > CONFIG_TOUCHSCREEN_CY8CTMG110=m
> > > CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
> > > CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
> > > CONFIG_TOUCHSCREEN_CYTTSP_SPI=m
> > > CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
> > > CONFIG_TOUCHSCREEN_CYTTSP4_I2C=m
> > > CONFIG_TOUCHSCREEN_CYTTSP4_SPI=m
> > > CONFIG_TOUCHSCREEN_DA9034=m
> > > CONFIG_TOUCHSCREEN_DA9052=m
> > > CONFIG_TOUCHSCREEN_DYNAPRO=m
> > > CONFIG_TOUCHSCREEN_HAMPSHIRE=m
> > > CONFIG_TOUCHSCREEN_EETI=m
> > > CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
> > > CONFIG_TOUCHSCREEN_EXC3000=m
> > > CONFIG_TOUCHSCREEN_FUJITSU=m
> > > CONFIG_TOUCHSCREEN_GOODIX=m
> > > CONFIG_TOUCHSCREEN_HIDEEP=m
> > > CONFIG_TOUCHSCREEN_ILI210X=m
> > > CONFIG_TOUCHSCREEN_S6SY761=m
> > > CONFIG_TOUCHSCREEN_GUNZE=m
> > > CONFIG_TOUCHSCREEN_EKTF2127=m
> > > CONFIG_TOUCHSCREEN_ELAN=y
> > > CONFIG_TOUCHSCREEN_ELO=m
> > > CONFIG_TOUCHSCREEN_WACOM_W8001=m
> > > CONFIG_TOUCHSCREEN_WACOM_I2C=m
> > > CONFIG_TOUCHSCREEN_MAX11801=m
> > > CONFIG_TOUCHSCREEN_MCS5000=m
> > > CONFIG_TOUCHSCREEN_MMS114=m
> > > CONFIG_TOUCHSCREEN_MELFAS_MIP4=m
> > > CONFIG_TOUCHSCREEN_MTOUCH=m
> > > CONFIG_TOUCHSCREEN_INEXIO=m
> > > CONFIG_TOUCHSCREEN_MK712=m
> > > CONFIG_TOUCHSCREEN_PENMOUNT=m
> > > CONFIG_TOUCHSCREEN_EDT_FT5X06=m
> > > CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
> > > CONFIG_TOUCHSCREEN_TOUCHWIN=m
> > > CONFIG_TOUCHSCREEN_TI_AM335X_TSC=m
> > > CONFIG_TOUCHSCREEN_UCB1400=m
> > > CONFIG_TOUCHSCREEN_PIXCIR=m
> > > CONFIG_TOUCHSCREEN_WDT87XX_I2C=m
> > > CONFIG_TOUCHSCREEN_WM831X=m
> > > CONFIG_TOUCHSCREEN_WM97XX=m
> > > CONFIG_TOUCHSCREEN_WM9705=y
> > > CONFIG_TOUCHSCREEN_WM9712=y
> > > CONFIG_TOUCHSCREEN_WM9713=y
> > > CONFIG_TOUCHSCREEN_USB_COMPOSITE=m
> > > CONFIG_TOUCHSCREEN_MC13783=m
> > > CONFIG_TOUCHSCREEN_USB_EGALAX=y
> > > CONFIG_TOUCHSCREEN_USB_PANJIT=y
> > > CONFIG_TOUCHSCREEN_USB_3M=y
> > > CONFIG_TOUCHSCREEN_USB_ITM=y
> > > CONFIG_TOUCHSCREEN_USB_ETURBO=y
> > > CONFIG_TOUCHSCREEN_USB_GUNZE=y
> > > CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
> > > CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
> > > CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
> > > CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
> > > CONFIG_TOUCHSCREEN_USB_GOTOP=y
> > > CONFIG_TOUCHSCREEN_USB_JASTEC=y
> > > CONFIG_TOUCHSCREEN_USB_ELO=y
> > > CONFIG_TOUCHSCREEN_USB_E2I=y
> > > CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
> > > CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
> > > CONFIG_TOUCHSCREEN_USB_NEXIO=y
> > > CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
> > > CONFIG_TOUCHSCREEN_TOUCHIT213=m
> > > CONFIG_TOUCHSCREEN_TSC_SERIO=m
> > > CONFIG_TOUCHSCREEN_TSC200X_CORE=m
> > > CONFIG_TOUCHSCREEN_TSC2004=m
> > > CONFIG_TOUCHSCREEN_TSC2005=m
> > > CONFIG_TOUCHSCREEN_TSC2007=m
> > > CONFIG_TOUCHSCREEN_TSC2007_IIO=y
> > > CONFIG_TOUCHSCREEN_PCAP=m
> > > CONFIG_TOUCHSCREEN_RM_TS=m
> > > CONFIG_TOUCHSCREEN_SILEAD=m
> > > CONFIG_TOUCHSCREEN_SIS_I2C=m
> > > CONFIG_TOUCHSCREEN_ST1232=m
> > > CONFIG_TOUCHSCREEN_STMFTS=m
> > > CONFIG_TOUCHSCREEN_SUR40=m
> > > CONFIG_TOUCHSCREEN_SURFACE3_SPI=m
> > > CONFIG_TOUCHSCREEN_SX8654=m
> > > CONFIG_TOUCHSCREEN_TPS6507X=m
> > > CONFIG_TOUCHSCREEN_ZET6223=m
> > > CONFIG_TOUCHSCREEN_ZFORCE=m
> > > CONFIG_TOUCHSCREEN_ROHM_BU21023=m
> > > CONFIG_TOUCHSCREEN_IQS5XX=m
> > > CONFIG_INPUT_MISC=y
> > > CONFIG_INPUT_88PM860X_ONKEY=m
> > > CONFIG_INPUT_88PM80X_ONKEY=m
> > > CONFIG_INPUT_AD714X=m
> > > CONFIG_INPUT_AD714X_I2C=m
> > > CONFIG_INPUT_AD714X_SPI=m
> > > CONFIG_INPUT_ARIZONA_HAPTICS=m
> > > CONFIG_INPUT_BMA150=m
> > > CONFIG_INPUT_E3X0_BUTTON=m
> > > CONFIG_INPUT_MSM_VIBRATOR=m
> > > CONFIG_INPUT_PCSPKR=m
> > > CONFIG_INPUT_MAX77693_HAPTIC=m
> > > CONFIG_INPUT_MAX8925_ONKEY=m
> > > CONFIG_INPUT_MAX8997_HAPTIC=m
> > > CONFIG_INPUT_MC13783_PWRBUTTON=m
> > > CONFIG_INPUT_MMA8450=m
> > > CONFIG_INPUT_APANEL=m
> > > CONFIG_INPUT_GP2A=m
> > > CONFIG_INPUT_GPIO_BEEPER=m
> > > CONFIG_INPUT_GPIO_DECODER=m
> > > CONFIG_INPUT_GPIO_VIBRA=m
> > > CONFIG_INPUT_ATLAS_BTNS=m
> > > CONFIG_INPUT_ATI_REMOTE2=m
> > > CONFIG_INPUT_KEYSPAN_REMOTE=m
> > > CONFIG_INPUT_KXTJ9=m
> > > # CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
> > > CONFIG_INPUT_POWERMATE=m
> > > CONFIG_INPUT_YEALINK=m
> > > CONFIG_INPUT_CM109=m
> > > CONFIG_INPUT_REGULATOR_HAPTIC=m
> > > CONFIG_INPUT_RETU_PWRBUTTON=m
> > > CONFIG_INPUT_AXP20X_PEK=m
> > > CONFIG_INPUT_TWL4030_PWRBUTTON=m
> > > CONFIG_INPUT_TWL4030_VIBRA=m
> > > CONFIG_INPUT_TWL6040_VIBRA=m
> > > CONFIG_INPUT_UINPUT=y
> > > CONFIG_INPUT_PALMAS_PWRBUTTON=m
> > > CONFIG_INPUT_PCF50633_PMU=m
> > > CONFIG_INPUT_PCF8574=m
> > > CONFIG_INPUT_PWM_BEEPER=m
> > > CONFIG_INPUT_PWM_VIBRA=m
> > > CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
> > > CONFIG_INPUT_DA9052_ONKEY=m
> > > CONFIG_INPUT_DA9055_ONKEY=m
> > > CONFIG_INPUT_DA9063_ONKEY=m
> > > CONFIG_INPUT_WM831X_ON=m
> > > CONFIG_INPUT_PCAP=m
> > > CONFIG_INPUT_ADXL34X=m
> > > CONFIG_INPUT_ADXL34X_I2C=m
> > > CONFIG_INPUT_ADXL34X_SPI=m
> > > CONFIG_INPUT_IMS_PCU=m
> > > CONFIG_INPUT_CMA3000=m
> > > CONFIG_INPUT_CMA3000_I2C=m
> > > CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
> > > CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
> > > CONFIG_INPUT_SOC_BUTTON_ARRAY=m
> > > CONFIG_INPUT_DRV260X_HAPTICS=m
> > > CONFIG_INPUT_DRV2665_HAPTICS=m
> > > CONFIG_INPUT_DRV2667_HAPTICS=m
> > > CONFIG_INPUT_RAVE_SP_PWRBUTTON=m
> > > CONFIG_RMI4_CORE=m
> > > CONFIG_RMI4_I2C=m
> > > CONFIG_RMI4_SPI=m
> > > CONFIG_RMI4_SMB=m
> > > CONFIG_RMI4_F03=y
> > > CONFIG_RMI4_F03_SERIO=m
> > > CONFIG_RMI4_2D_SENSOR=y
> > > CONFIG_RMI4_F11=y
> > > CONFIG_RMI4_F12=y
> > > CONFIG_RMI4_F30=y
> > > CONFIG_RMI4_F34=y
> > > CONFIG_RMI4_F54=y
> > > CONFIG_RMI4_F55=y
> > > 
> > > #
> > > # Hardware I/O ports
> > > #
> > > CONFIG_SERIO=y
> > > CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> > > CONFIG_SERIO_I8042=y
> > > CONFIG_SERIO_SERPORT=m
> > > CONFIG_SERIO_CT82C710=m
> > > CONFIG_SERIO_PARKBD=m
> > > CONFIG_SERIO_PCIPS2=m
> > > CONFIG_SERIO_LIBPS2=y
> > > CONFIG_SERIO_RAW=m
> > > CONFIG_SERIO_ALTERA_PS2=m
> > > CONFIG_SERIO_PS2MULT=m
> > > CONFIG_SERIO_ARC_PS2=m
> > > CONFIG_HYPERV_KEYBOARD=m
> > > CONFIG_SERIO_GPIO_PS2=m
> > > CONFIG_USERIO=m
> > > CONFIG_GAMEPORT=m
> > > CONFIG_GAMEPORT_NS558=m
> > > CONFIG_GAMEPORT_L4=m
> > > CONFIG_GAMEPORT_EMU10K1=m
> > > CONFIG_GAMEPORT_FM801=m
> > > # end of Hardware I/O ports
> > > # end of Input device support
> > > 
> > > #
> > > # Character devices
> > > #
> > > CONFIG_TTY=y
> > > CONFIG_VT=y
> > > CONFIG_CONSOLE_TRANSLATIONS=y
> > > CONFIG_VT_CONSOLE=y
> > > CONFIG_VT_CONSOLE_SLEEP=y
> > > CONFIG_HW_CONSOLE=y
> > > CONFIG_VT_HW_CONSOLE_BINDING=y
> > > CONFIG_UNIX98_PTYS=y
> > > CONFIG_LEGACY_PTYS=y
> > > CONFIG_LEGACY_PTY_COUNT=0
> > > CONFIG_SERIAL_NONSTANDARD=y
> > > CONFIG_ROCKETPORT=m
> > > CONFIG_CYCLADES=m
> > > # CONFIG_CYZ_INTR is not set
> > > CONFIG_MOXA_INTELLIO=m
> > > CONFIG_MOXA_SMARTIO=m
> > > CONFIG_SYNCLINK=m
> > > CONFIG_SYNCLINKMP=m
> > > CONFIG_SYNCLINK_GT=m
> > > CONFIG_NOZOMI=m
> > > CONFIG_ISI=m
> > > CONFIG_N_HDLC=m
> > > CONFIG_N_GSM=m
> > > CONFIG_TRACE_ROUTER=m
> > > CONFIG_TRACE_SINK=m
> > > CONFIG_NULL_TTY=m
> > > CONFIG_LDISC_AUTOLOAD=y
> > > CONFIG_DEVMEM=y
> > > # CONFIG_DEVKMEM is not set
> > > 
> > > #
> > > # Serial drivers
> > > #
> > > CONFIG_SERIAL_EARLYCON=y
> > > CONFIG_SERIAL_8250=y
> > > # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> > > CONFIG_SERIAL_8250_PNP=y
> > > CONFIG_SERIAL_8250_FINTEK=y
> > > CONFIG_SERIAL_8250_CONSOLE=y
> > > CONFIG_SERIAL_8250_DMA=y
> > > CONFIG_SERIAL_8250_PCI=y
> > > CONFIG_SERIAL_8250_EXAR=m
> > > CONFIG_SERIAL_8250_CS=m
> > > CONFIG_SERIAL_8250_MEN_MCB=m
> > > CONFIG_SERIAL_8250_NR_UARTS=48
> > > CONFIG_SERIAL_8250_RUNTIME_UARTS=32
> > > CONFIG_SERIAL_8250_EXTENDED=y
> > > CONFIG_SERIAL_8250_MANY_PORTS=y
> > > CONFIG_SERIAL_8250_SHARE_IRQ=y
> > > # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> > > CONFIG_SERIAL_8250_RSA=y
> > > CONFIG_SERIAL_8250_DW=m
> > > CONFIG_SERIAL_8250_RT288X=y
> > > CONFIG_SERIAL_8250_LPSS=m
> > > CONFIG_SERIAL_8250_MID=m
> > > CONFIG_SERIAL_8250_MOXA=m
> > > 
> > > #
> > > # Non-8250 serial port support
> > > #
> > > CONFIG_SERIAL_KGDB_NMI=y
> > > CONFIG_SERIAL_MAX3100=m
> > > CONFIG_SERIAL_MAX310X=y
> > > CONFIG_SERIAL_UARTLITE=m
> > > CONFIG_SERIAL_UARTLITE_NR_UARTS=1
> > > CONFIG_SERIAL_CORE=y
> > > CONFIG_SERIAL_CORE_CONSOLE=y
> > > CONFIG_CONSOLE_POLL=y
> > > CONFIG_SERIAL_JSM=m
> > > CONFIG_SERIAL_SCCNXP=y
> > > CONFIG_SERIAL_SCCNXP_CONSOLE=y
> > > CONFIG_SERIAL_SC16IS7XX_CORE=m
> > > CONFIG_SERIAL_SC16IS7XX=m
> > > CONFIG_SERIAL_SC16IS7XX_I2C=y
> > > CONFIG_SERIAL_SC16IS7XX_SPI=y
> > > CONFIG_SERIAL_ALTERA_JTAGUART=m
> > > CONFIG_SERIAL_ALTERA_UART=m
> > > CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
> > > CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
> > > # CONFIG_SERIAL_IFX6X60 is not set
> > > CONFIG_SERIAL_ARC=m
> > > CONFIG_SERIAL_ARC_NR_PORTS=1
> > > CONFIG_SERIAL_RP2=m
> > > CONFIG_SERIAL_RP2_NR_UARTS=32
> > > CONFIG_SERIAL_FSL_LPUART=m
> > > CONFIG_SERIAL_MEN_Z135=m
> > > # end of Serial drivers
> > > 
> > > CONFIG_SERIAL_MCTRL_GPIO=y
> > > CONFIG_SERIAL_DEV_BUS=y
> > > CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
> > > CONFIG_TTY_PRINTK=y
> > > CONFIG_TTY_PRINTK_LEVEL=6
> > > CONFIG_PRINTER=m
> > > # CONFIG_LP_CONSOLE is not set
> > > CONFIG_PPDEV=m
> > > CONFIG_HVC_DRIVER=y
> > > CONFIG_HVC_IRQ=y
> > > CONFIG_HVC_XEN=y
> > > CONFIG_HVC_XEN_FRONTEND=y
> > > CONFIG_VIRTIO_CONSOLE=y
> > > CONFIG_IPMI_HANDLER=m
> > > CONFIG_IPMI_DMI_DECODE=y
> > > CONFIG_IPMI_PLAT_DATA=y
> > > # CONFIG_IPMI_PANIC_EVENT is not set
> > > CONFIG_IPMI_DEVICE_INTERFACE=m
> > > CONFIG_IPMI_SI=m
> > > CONFIG_IPMI_SSIF=m
> > > CONFIG_IPMI_WATCHDOG=m
> > > CONFIG_IPMI_POWEROFF=m
> > > CONFIG_HW_RANDOM=y
> > > CONFIG_HW_RANDOM_TIMERIOMEM=m
> > > CONFIG_HW_RANDOM_INTEL=m
> > > CONFIG_HW_RANDOM_AMD=m
> > > CONFIG_HW_RANDOM_VIA=m
> > > CONFIG_HW_RANDOM_VIRTIO=m
> > > CONFIG_NVRAM=m
> > > CONFIG_APPLICOM=m
> > > 
> > > #
> > > # PCMCIA character devices
> > > #
> > > CONFIG_SYNCLINK_CS=m
> > > CONFIG_CARDMAN_4000=m
> > > CONFIG_CARDMAN_4040=m
> > > CONFIG_SCR24X=m
> > > CONFIG_IPWIRELESS=m
> > > # end of PCMCIA character devices
> > > 
> > > CONFIG_MWAVE=m
> > > CONFIG_RAW_DRIVER=m
> > > CONFIG_MAX_RAW_DEVS=256
> > > CONFIG_HPET=y
> > > CONFIG_HPET_MMAP=y
> > > CONFIG_HPET_MMAP_DEFAULT=y
> > > CONFIG_HANGCHECK_TIMER=m
> > > CONFIG_TCG_TPM=y
> > > CONFIG_HW_RANDOM_TPM=y
> > > CONFIG_TCG_TIS_CORE=y
> > > CONFIG_TCG_TIS=y
> > > CONFIG_TCG_TIS_SPI=m
> > > CONFIG_TCG_TIS_I2C_ATMEL=m
> > > CONFIG_TCG_TIS_I2C_INFINEON=m
> > > CONFIG_TCG_TIS_I2C_NUVOTON=m
> > > CONFIG_TCG_NSC=m
> > > CONFIG_TCG_ATMEL=m
> > > CONFIG_TCG_INFINEON=m
> > > CONFIG_TCG_XEN=m
> > > CONFIG_TCG_CRB=y
> > > CONFIG_TCG_VTPM_PROXY=m
> > > CONFIG_TCG_TIS_ST33ZP24=m
> > > CONFIG_TCG_TIS_ST33ZP24_I2C=m
> > > CONFIG_TCG_TIS_ST33ZP24_SPI=m
> > > CONFIG_TELCLOCK=m
> > > CONFIG_DEVPORT=y
> > > CONFIG_XILLYBUS=m
> > > CONFIG_XILLYBUS_PCIE=m
> > > # end of Character devices
> > > 
> > > CONFIG_RANDOM_TRUST_CPU=y
> > > 
> > > #
> > > # I2C support
> > > #
> > > CONFIG_I2C=y
> > > CONFIG_ACPI_I2C_OPREGION=y
> > > CONFIG_I2C_BOARDINFO=y
> > > CONFIG_I2C_COMPAT=y
> > > CONFIG_I2C_CHARDEV=y
> > > CONFIG_I2C_MUX=m
> > > 
> > > #
> > > # Multiplexer I2C Chip support
> > > #
> > > CONFIG_I2C_MUX_GPIO=m
> > > CONFIG_I2C_MUX_LTC4306=m
> > > CONFIG_I2C_MUX_PCA9541=m
> > > CONFIG_I2C_MUX_PCA954x=m
> > > CONFIG_I2C_MUX_REG=m
> > > CONFIG_I2C_MUX_MLXCPLD=m
> > > # end of Multiplexer I2C Chip support
> > > 
> > > CONFIG_I2C_HELPER_AUTO=y
> > > CONFIG_I2C_SMBUS=m
> > > CONFIG_I2C_ALGOBIT=m
> > > CONFIG_I2C_ALGOPCA=m
> > > 
> > > #
> > > # I2C Hardware Bus support
> > > #
> > > 
> > > #
> > > # PC SMBus host controller drivers
> > > #
> > > CONFIG_I2C_ALI1535=m
> > > CONFIG_I2C_ALI1563=m
> > > CONFIG_I2C_ALI15X3=m
> > > CONFIG_I2C_AMD756=m
> > > CONFIG_I2C_AMD756_S4882=m
> > > CONFIG_I2C_AMD8111=m
> > > CONFIG_I2C_AMD_MP2=m
> > > CONFIG_I2C_I801=m
> > > CONFIG_I2C_ISCH=m
> > > CONFIG_I2C_ISMT=m
> > > CONFIG_I2C_PIIX4=m
> > > CONFIG_I2C_CHT_WC=m
> > > CONFIG_I2C_NFORCE2=m
> > > CONFIG_I2C_NFORCE2_S4985=m
> > > CONFIG_I2C_NVIDIA_GPU=m
> > > CONFIG_I2C_SIS5595=m
> > > CONFIG_I2C_SIS630=m
> > > CONFIG_I2C_SIS96X=m
> > > CONFIG_I2C_VIA=m
> > > CONFIG_I2C_VIAPRO=m
> > > 
> > > #
> > > # ACPI drivers
> > > #
> > > CONFIG_I2C_SCMI=m
> > > 
> > > #
> > > # I2C system bus drivers (mostly embedded / system-on-chip)
> > > #
> > > CONFIG_I2C_CBUS_GPIO=m
> > > CONFIG_I2C_DESIGNWARE_CORE=y
> > > CONFIG_I2C_DESIGNWARE_PLATFORM=y
> > > # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> > > CONFIG_I2C_DESIGNWARE_PCI=m
> > > CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
> > > # CONFIG_I2C_EMEV2 is not set
> > > CONFIG_I2C_GPIO=m
> > > # CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
> > > CONFIG_I2C_KEMPLD=m
> > > CONFIG_I2C_OCORES=m
> > > CONFIG_I2C_PCA_PLATFORM=m
> > > CONFIG_I2C_SIMTEC=m
> > > CONFIG_I2C_XILINX=m
> > > 
> > > #
> > > # External I2C/SMBus adapter drivers
> > > #
> > > CONFIG_I2C_DIOLAN_U2C=m
> > > CONFIG_I2C_DLN2=m
> > > CONFIG_I2C_PARPORT=m
> > > CONFIG_I2C_PARPORT_LIGHT=m
> > > CONFIG_I2C_ROBOTFUZZ_OSIF=m
> > > CONFIG_I2C_TAOS_EVM=m
> > > CONFIG_I2C_TINY_USB=m
> > > CONFIG_I2C_VIPERBOARD=m
> > > 
> > > #
> > > # Other I2C/SMBus bus drivers
> > > #
> > > CONFIG_I2C_MLXCPLD=m
> > > CONFIG_I2C_CROS_EC_TUNNEL=m
> > > # end of I2C Hardware Bus support
> > > 
> > > CONFIG_I2C_STUB=m
> > > # CONFIG_I2C_SLAVE is not set
> > > # CONFIG_I2C_DEBUG_CORE is not set
> > > # CONFIG_I2C_DEBUG_ALGO is not set
> > > # CONFIG_I2C_DEBUG_BUS is not set
> > > # end of I2C support
> > > 
> > > CONFIG_I3C=m
> > > CONFIG_CDNS_I3C_MASTER=m
> > > CONFIG_DW_I3C_MASTER=m
> > > CONFIG_SPI=y
> > > # CONFIG_SPI_DEBUG is not set
> > > CONFIG_SPI_MASTER=y
> > > CONFIG_SPI_MEM=y
> > > 
> > > #
> > > # SPI Master Controller Drivers
> > > #
> > > CONFIG_SPI_ALTERA=m
> > > CONFIG_SPI_AXI_SPI_ENGINE=m
> > > CONFIG_SPI_BITBANG=m
> > > CONFIG_SPI_BUTTERFLY=m
> > > CONFIG_SPI_CADENCE=m
> > > CONFIG_SPI_DESIGNWARE=m
> > > CONFIG_SPI_DW_PCI=m
> > > CONFIG_SPI_DW_MID_DMA=y
> > > CONFIG_SPI_DW_MMIO=m
> > > CONFIG_SPI_DLN2=m
> > > CONFIG_SPI_NXP_FLEXSPI=m
> > > CONFIG_SPI_GPIO=m
> > > CONFIG_SPI_LM70_LLP=m
> > > CONFIG_SPI_OC_TINY=m
> > > CONFIG_SPI_PXA2XX=m
> > > CONFIG_SPI_PXA2XX_PCI=m
> > > # CONFIG_SPI_ROCKCHIP is not set
> > > CONFIG_SPI_SC18IS602=m
> > > CONFIG_SPI_SIFIVE=m
> > > CONFIG_SPI_MXIC=m
> > > CONFIG_SPI_XCOMM=m
> > > # CONFIG_SPI_XILINX is not set
> > > CONFIG_SPI_ZYNQMP_GQSPI=m
> > > 
> > > #
> > > # SPI Protocol Masters
> > > #
> > > CONFIG_SPI_SPIDEV=m
> > > CONFIG_SPI_LOOPBACK_TEST=m
> > > CONFIG_SPI_TLE62X0=m
> > > CONFIG_SPI_SLAVE=y
> > > CONFIG_SPI_SLAVE_TIME=m
> > > CONFIG_SPI_SLAVE_SYSTEM_CONTROL=m
> > > CONFIG_SPMI=m
> > > CONFIG_HSI=m
> > > CONFIG_HSI_BOARDINFO=y
> > > 
> > > #
> > > # HSI controllers
> > > #
> > > 
> > > #
> > > # HSI clients
> > > #
> > > CONFIG_HSI_CHAR=m
> > > CONFIG_PPS=y
> > > # CONFIG_PPS_DEBUG is not set
> > > 
> > > #
> > > # PPS clients support
> > > #
> > > # CONFIG_PPS_CLIENT_KTIMER is not set
> > > CONFIG_PPS_CLIENT_LDISC=m
> > > CONFIG_PPS_CLIENT_PARPORT=m
> > > CONFIG_PPS_CLIENT_GPIO=m
> > > 
> > > #
> > > # PPS generators support
> > > #
> > > 
> > > #
> > > # PTP clock support
> > > #
> > > CONFIG_PTP_1588_CLOCK=y
> > > CONFIG_DP83640_PHY=m
> > > CONFIG_PTP_1588_CLOCK_KVM=m
> > > # end of PTP clock support
> > > 
> > > CONFIG_PINCTRL=y
> > > CONFIG_PINMUX=y
> > > CONFIG_PINCONF=y
> > > CONFIG_GENERIC_PINCONF=y
> > > # CONFIG_DEBUG_PINCTRL is not set
> > > CONFIG_PINCTRL_AMD=y
> > > CONFIG_PINCTRL_MCP23S08=m
> > > CONFIG_PINCTRL_SX150X=y
> > > CONFIG_PINCTRL_BAYTRAIL=y
> > > CONFIG_PINCTRL_CHERRYVIEW=y
> > > CONFIG_PINCTRL_INTEL=m
> > > CONFIG_PINCTRL_BROXTON=m
> > > CONFIG_PINCTRL_CANNONLAKE=m
> > > CONFIG_PINCTRL_CEDARFORK=m
> > > CONFIG_PINCTRL_DENVERTON=m
> > > CONFIG_PINCTRL_GEMINILAKE=m
> > > CONFIG_PINCTRL_ICELAKE=m
> > > CONFIG_PINCTRL_LEWISBURG=m
> > > CONFIG_PINCTRL_SUNRISEPOINT=m
> > > CONFIG_PINCTRL_MADERA=m
> > > CONFIG_PINCTRL_CS47L35=y
> > > CONFIG_PINCTRL_CS47L85=y
> > > CONFIG_PINCTRL_CS47L90=y
> > > CONFIG_GPIOLIB=y
> > > CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> > > CONFIG_GPIO_ACPI=y
> > > CONFIG_GPIOLIB_IRQCHIP=y
> > > # CONFIG_DEBUG_GPIO is not set
> > > CONFIG_GPIO_SYSFS=y
> > > CONFIG_GPIO_GENERIC=m
> > > CONFIG_GPIO_MAX730X=m
> > > 
> > > #
> > > # Memory mapped GPIO drivers
> > > #
> > > CONFIG_GPIO_AMDPT=m
> > > CONFIG_GPIO_DWAPB=m
> > > CONFIG_GPIO_EXAR=m
> > > CONFIG_GPIO_GENERIC_PLATFORM=m
> > > CONFIG_GPIO_ICH=m
> > > CONFIG_GPIO_LYNXPOINT=y
> > > CONFIG_GPIO_MB86S7X=m
> > > CONFIG_GPIO_MENZ127=m
> > > CONFIG_GPIO_SIOX=m
> > > CONFIG_GPIO_VX855=m
> > > CONFIG_GPIO_XILINX=y
> > > CONFIG_GPIO_AMD_FCH=m
> > > # end of Memory mapped GPIO drivers
> > > 
> > > #
> > > # Port-mapped I/O GPIO drivers
> > > #
> > > CONFIG_GPIO_104_DIO_48E=m
> > > CONFIG_GPIO_104_IDIO_16=m
> > > CONFIG_GPIO_104_IDI_48=m
> > > CONFIG_GPIO_F7188X=m
> > > CONFIG_GPIO_GPIO_MM=m
> > > CONFIG_GPIO_IT87=m
> > > CONFIG_GPIO_SCH=m
> > > CONFIG_GPIO_SCH311X=m
> > > CONFIG_GPIO_WINBOND=m
> > > CONFIG_GPIO_WS16C48=m
> > > # end of Port-mapped I/O GPIO drivers
> > > 
> > > #
> > > # I2C GPIO expanders
> > > #
> > > CONFIG_GPIO_ADP5588=m
> > > CONFIG_GPIO_MAX7300=m
> > > CONFIG_GPIO_MAX732X=m
> > > CONFIG_GPIO_PCA953X=m
> > > CONFIG_GPIO_PCF857X=m
> > > CONFIG_GPIO_TPIC2810=m
> > > # end of I2C GPIO expanders
> > > 
> > > #
> > > # MFD GPIO expanders
> > > #
> > > CONFIG_GPIO_ADP5520=m
> > > CONFIG_GPIO_ARIZONA=m
> > > CONFIG_GPIO_BD9571MWV=m
> > > CONFIG_GPIO_CRYSTAL_COVE=m
> > > CONFIG_GPIO_DA9052=m
> > > CONFIG_GPIO_DA9055=m
> > > CONFIG_GPIO_DLN2=m
> > > CONFIG_GPIO_JANZ_TTL=m
> > > CONFIG_GPIO_KEMPLD=m
> > > CONFIG_GPIO_LP3943=m
> > > CONFIG_GPIO_LP873X=m
> > > CONFIG_GPIO_MADERA=m
> > > CONFIG_GPIO_PALMAS=y
> > > CONFIG_GPIO_RC5T583=y
> > > CONFIG_GPIO_TPS65086=m
> > > CONFIG_GPIO_TPS6586X=y
> > > CONFIG_GPIO_TPS65910=y
> > > CONFIG_GPIO_TPS65912=m
> > > CONFIG_GPIO_TPS68470=y
> > > CONFIG_GPIO_TQMX86=m
> > > CONFIG_GPIO_TWL4030=m
> > > CONFIG_GPIO_TWL6040=m
> > > CONFIG_GPIO_UCB1400=m
> > > CONFIG_GPIO_WHISKEY_COVE=m
> > > CONFIG_GPIO_WM831X=m
> > > CONFIG_GPIO_WM8350=m
> > > CONFIG_GPIO_WM8994=m
> > > # end of MFD GPIO expanders
> > > 
> > > #
> > > # PCI GPIO expanders
> > > #
> > > CONFIG_GPIO_AMD8111=m
> > > CONFIG_GPIO_ML_IOH=m
> > > CONFIG_GPIO_PCI_IDIO_16=m
> > > CONFIG_GPIO_PCIE_IDIO_24=m
> > > CONFIG_GPIO_RDC321X=m
> > > # end of PCI GPIO expanders
> > > 
> > > #
> > > # SPI GPIO expanders
> > > #
> > > CONFIG_GPIO_MAX3191X=m
> > > CONFIG_GPIO_MAX7301=m
> > > CONFIG_GPIO_MC33880=m
> > > CONFIG_GPIO_PISOSR=m
> > > CONFIG_GPIO_XRA1403=m
> > > # end of SPI GPIO expanders
> > > 
> > > #
> > > # USB GPIO expanders
> > > #
> > > CONFIG_GPIO_VIPERBOARD=m
> > > # end of USB GPIO expanders
> > > 
> > > # CONFIG_GPIO_MOCKUP is not set
> > > CONFIG_W1=m
> > > CONFIG_W1_CON=y
> > > 
> > > #
> > > # 1-wire Bus Masters
> > > #
> > > CONFIG_W1_MASTER_MATROX=m
> > > CONFIG_W1_MASTER_DS2490=m
> > > CONFIG_W1_MASTER_DS2482=m
> > > CONFIG_W1_MASTER_DS1WM=m
> > > CONFIG_W1_MASTER_GPIO=m
> > > # end of 1-wire Bus Masters
> > > 
> > > #
> > > # 1-wire Slaves
> > > #
> > > CONFIG_W1_SLAVE_THERM=m
> > > CONFIG_W1_SLAVE_SMEM=m
> > > CONFIG_W1_SLAVE_DS2405=m
> > > CONFIG_W1_SLAVE_DS2408=m
> > > CONFIG_W1_SLAVE_DS2408_READBACK=y
> > > CONFIG_W1_SLAVE_DS2413=m
> > > CONFIG_W1_SLAVE_DS2406=m
> > > CONFIG_W1_SLAVE_DS2423=m
> > > CONFIG_W1_SLAVE_DS2805=m
> > > CONFIG_W1_SLAVE_DS2431=m
> > > CONFIG_W1_SLAVE_DS2433=m
> > > # CONFIG_W1_SLAVE_DS2433_CRC is not set
> > > CONFIG_W1_SLAVE_DS2438=m
> > > CONFIG_W1_SLAVE_DS2780=m
> > > CONFIG_W1_SLAVE_DS2781=m
> > > CONFIG_W1_SLAVE_DS28E04=m
> > > CONFIG_W1_SLAVE_DS28E17=m
> > > # end of 1-wire Slaves
> > > 
> > > CONFIG_POWER_AVS=y
> > > CONFIG_POWER_RESET=y
> > > CONFIG_POWER_RESET_RESTART=y
> > > CONFIG_POWER_SUPPLY=y
> > > # CONFIG_POWER_SUPPLY_DEBUG is not set
> > > CONFIG_POWER_SUPPLY_HWMON=y
> > > CONFIG_PDA_POWER=m
> > > CONFIG_GENERIC_ADC_BATTERY=m
> > > CONFIG_MAX8925_POWER=m
> > > CONFIG_WM831X_BACKUP=m
> > > CONFIG_WM831X_POWER=m
> > > CONFIG_WM8350_POWER=m
> > > CONFIG_TEST_POWER=m
> > > CONFIG_BATTERY_88PM860X=m
> > > CONFIG_CHARGER_ADP5061=m
> > > CONFIG_BATTERY_DS2760=m
> > > CONFIG_BATTERY_DS2780=m
> > > CONFIG_BATTERY_DS2781=m
> > > CONFIG_BATTERY_DS2782=m
> > > CONFIG_BATTERY_SBS=m
> > > CONFIG_CHARGER_SBS=m
> > > CONFIG_MANAGER_SBS=m
> > > CONFIG_BATTERY_BQ27XXX=m
> > > CONFIG_BATTERY_BQ27XXX_I2C=m
> > > CONFIG_BATTERY_BQ27XXX_HDQ=m
> > > # CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
> > > CONFIG_BATTERY_DA9030=m
> > > CONFIG_BATTERY_DA9052=m
> > > CONFIG_CHARGER_DA9150=m
> > > CONFIG_BATTERY_DA9150=m
> > > CONFIG_CHARGER_AXP20X=m
> > > CONFIG_BATTERY_AXP20X=m
> > > CONFIG_AXP20X_POWER=m
> > > CONFIG_AXP288_CHARGER=m
> > > CONFIG_AXP288_FUEL_GAUGE=m
> > > CONFIG_BATTERY_MAX17040=m
> > > CONFIG_BATTERY_MAX17042=m
> > > CONFIG_BATTERY_MAX1721X=m
> > > CONFIG_BATTERY_TWL4030_MADC=m
> > > CONFIG_CHARGER_88PM860X=m
> > > CONFIG_CHARGER_PCF50633=m
> > > CONFIG_BATTERY_RX51=m
> > > CONFIG_CHARGER_ISP1704=m
> > > CONFIG_CHARGER_MAX8903=m
> > > CONFIG_CHARGER_TWL4030=m
> > > CONFIG_CHARGER_LP8727=m
> > > CONFIG_CHARGER_LP8788=m
> > > CONFIG_CHARGER_GPIO=m
> > > CONFIG_CHARGER_MANAGER=y
> > > CONFIG_CHARGER_LT3651=m
> > > CONFIG_CHARGER_MAX14577=m
> > > CONFIG_CHARGER_MAX77693=m
> > > CONFIG_CHARGER_MAX8997=m
> > > CONFIG_CHARGER_MAX8998=m
> > > CONFIG_CHARGER_BQ2415X=m
> > > CONFIG_CHARGER_BQ24190=m
> > > CONFIG_CHARGER_BQ24257=m
> > > CONFIG_CHARGER_BQ24735=m
> > > CONFIG_CHARGER_BQ25890=m
> > > CONFIG_CHARGER_SMB347=m
> > > CONFIG_CHARGER_TPS65090=m
> > > CONFIG_BATTERY_GAUGE_LTC2941=m
> > > CONFIG_BATTERY_RT5033=m
> > > CONFIG_CHARGER_RT9455=m
> > > CONFIG_CHARGER_CROS_USBPD=m
> > > CONFIG_CHARGER_WILCO=m
> > > CONFIG_HWMON=y
> > > CONFIG_HWMON_VID=m
> > > # CONFIG_HWMON_DEBUG_CHIP is not set
> > > 
> > > #
> > > # Native drivers
> > > #
> > > CONFIG_SENSORS_ABITUGURU=m
> > > CONFIG_SENSORS_ABITUGURU3=m
> > > CONFIG_SENSORS_AD7314=m
> > > CONFIG_SENSORS_AD7414=m
> > > CONFIG_SENSORS_AD7418=m
> > > CONFIG_SENSORS_ADM1021=m
> > > CONFIG_SENSORS_ADM1025=m
> > > CONFIG_SENSORS_ADM1026=m
> > > CONFIG_SENSORS_ADM1029=m
> > > CONFIG_SENSORS_ADM1031=m
> > > CONFIG_SENSORS_ADM9240=m
> > > CONFIG_SENSORS_ADT7X10=m
> > > CONFIG_SENSORS_ADT7310=m
> > > CONFIG_SENSORS_ADT7410=m
> > > CONFIG_SENSORS_ADT7411=m
> > > CONFIG_SENSORS_ADT7462=m
> > > CONFIG_SENSORS_ADT7470=m
> > > CONFIG_SENSORS_ADT7475=m
> > > CONFIG_SENSORS_ASC7621=m
> > > CONFIG_SENSORS_K8TEMP=m
> > > CONFIG_SENSORS_K10TEMP=m
> > > CONFIG_SENSORS_FAM15H_POWER=m
> > > CONFIG_SENSORS_APPLESMC=m
> > > CONFIG_SENSORS_ASB100=m
> > > CONFIG_SENSORS_ASPEED=m
> > > CONFIG_SENSORS_ATXP1=m
> > > CONFIG_SENSORS_DS620=m
> > > CONFIG_SENSORS_DS1621=m
> > > CONFIG_SENSORS_DELL_SMM=m
> > > CONFIG_SENSORS_DA9052_ADC=m
> > > CONFIG_SENSORS_DA9055=m
> > > CONFIG_SENSORS_I5K_AMB=m
> > > CONFIG_SENSORS_F71805F=m
> > > CONFIG_SENSORS_F71882FG=m
> > > CONFIG_SENSORS_F75375S=m
> > > CONFIG_SENSORS_MC13783_ADC=m
> > > CONFIG_SENSORS_FSCHMD=m
> > > CONFIG_SENSORS_FTSTEUTATES=m
> > > CONFIG_SENSORS_GL518SM=m
> > > CONFIG_SENSORS_GL520SM=m
> > > CONFIG_SENSORS_G760A=m
> > > CONFIG_SENSORS_G762=m
> > > CONFIG_SENSORS_HIH6130=m
> > > CONFIG_SENSORS_IBMAEM=m
> > > CONFIG_SENSORS_IBMPEX=m
> > > CONFIG_SENSORS_IIO_HWMON=m
> > > CONFIG_SENSORS_I5500=m
> > > CONFIG_SENSORS_CORETEMP=m
> > > CONFIG_SENSORS_IT87=m
> > > CONFIG_SENSORS_JC42=m
> > > CONFIG_SENSORS_POWR1220=m
> > > CONFIG_SENSORS_LINEAGE=m
> > > CONFIG_SENSORS_LTC2945=m
> > > CONFIG_SENSORS_LTC2990=m
> > > CONFIG_SENSORS_LTC4151=m
> > > CONFIG_SENSORS_LTC4215=m
> > > CONFIG_SENSORS_LTC4222=m
> > > CONFIG_SENSORS_LTC4245=m
> > > CONFIG_SENSORS_LTC4260=m
> > > CONFIG_SENSORS_LTC4261=m
> > > CONFIG_SENSORS_MAX1111=m
> > > CONFIG_SENSORS_MAX16065=m
> > > CONFIG_SENSORS_MAX1619=m
> > > CONFIG_SENSORS_MAX1668=m
> > > CONFIG_SENSORS_MAX197=m
> > > CONFIG_SENSORS_MAX31722=m
> > > CONFIG_SENSORS_MAX6621=m
> > > CONFIG_SENSORS_MAX6639=m
> > > CONFIG_SENSORS_MAX6642=m
> > > CONFIG_SENSORS_MAX6650=m
> > > CONFIG_SENSORS_MAX6697=m
> > > CONFIG_SENSORS_MAX31790=m
> > > CONFIG_SENSORS_MCP3021=m
> > > CONFIG_SENSORS_MLXREG_FAN=m
> > > CONFIG_SENSORS_TC654=m
> > > CONFIG_SENSORS_MENF21BMC_HWMON=m
> > > CONFIG_SENSORS_ADCXX=m
> > > CONFIG_SENSORS_LM63=m
> > > CONFIG_SENSORS_LM70=m
> > > CONFIG_SENSORS_LM73=m
> > > CONFIG_SENSORS_LM75=m
> > > CONFIG_SENSORS_LM77=m
> > > CONFIG_SENSORS_LM78=m
> > > CONFIG_SENSORS_LM80=m
> > > CONFIG_SENSORS_LM83=m
> > > CONFIG_SENSORS_LM85=m
> > > CONFIG_SENSORS_LM87=m
> > > CONFIG_SENSORS_LM90=m
> > > CONFIG_SENSORS_LM92=m
> > > CONFIG_SENSORS_LM93=m
> > > CONFIG_SENSORS_LM95234=m
> > > CONFIG_SENSORS_LM95241=m
> > > CONFIG_SENSORS_LM95245=m
> > > CONFIG_SENSORS_PC87360=m
> > > CONFIG_SENSORS_PC87427=m
> > > CONFIG_SENSORS_NTC_THERMISTOR=m
> > > CONFIG_SENSORS_NCT6683=m
> > > CONFIG_SENSORS_NCT6775=m
> > > CONFIG_SENSORS_NCT7802=m
> > > CONFIG_SENSORS_NCT7904=m
> > > CONFIG_SENSORS_NPCM7XX=m
> > > CONFIG_SENSORS_PCF8591=m
> > > CONFIG_PMBUS=m
> > > CONFIG_SENSORS_PMBUS=m
> > > CONFIG_SENSORS_ADM1275=m
> > > CONFIG_SENSORS_IBM_CFFPS=m
> > > CONFIG_SENSORS_IR35221=m
> > > CONFIG_SENSORS_IR38064=m
> > > CONFIG_SENSORS_IRPS5401=m
> > > CONFIG_SENSORS_ISL68137=m
> > > CONFIG_SENSORS_LM25066=m
> > > CONFIG_SENSORS_LTC2978=m
> > > CONFIG_SENSORS_LTC2978_REGULATOR=y
> > > CONFIG_SENSORS_LTC3815=m
> > > CONFIG_SENSORS_MAX16064=m
> > > CONFIG_SENSORS_MAX20751=m
> > > CONFIG_SENSORS_MAX31785=m
> > > CONFIG_SENSORS_MAX34440=m
> > > CONFIG_SENSORS_MAX8688=m
> > > CONFIG_SENSORS_PXE1610=m
> > > CONFIG_SENSORS_TPS40422=m
> > > CONFIG_SENSORS_TPS53679=m
> > > CONFIG_SENSORS_UCD9000=m
> > > CONFIG_SENSORS_UCD9200=m
> > > CONFIG_SENSORS_ZL6100=m
> > > CONFIG_SENSORS_SHT15=m
> > > CONFIG_SENSORS_SHT21=m
> > > CONFIG_SENSORS_SHT3x=m
> > > CONFIG_SENSORS_SHTC1=m
> > > CONFIG_SENSORS_SIS5595=m
> > > CONFIG_SENSORS_DME1737=m
> > > CONFIG_SENSORS_EMC1403=m
> > > CONFIG_SENSORS_EMC2103=m
> > > CONFIG_SENSORS_EMC6W201=m
> > > CONFIG_SENSORS_SMSC47M1=m
> > > CONFIG_SENSORS_SMSC47M192=m
> > > CONFIG_SENSORS_SMSC47B397=m
> > > CONFIG_SENSORS_SCH56XX_COMMON=m
> > > CONFIG_SENSORS_SCH5627=m
> > > CONFIG_SENSORS_SCH5636=m
> > > CONFIG_SENSORS_STTS751=m
> > > CONFIG_SENSORS_SMM665=m
> > > CONFIG_SENSORS_ADC128D818=m
> > > CONFIG_SENSORS_ADS1015=m
> > > CONFIG_SENSORS_ADS7828=m
> > > CONFIG_SENSORS_ADS7871=m
> > > CONFIG_SENSORS_AMC6821=m
> > > CONFIG_SENSORS_INA209=m
> > > CONFIG_SENSORS_INA2XX=m
> > > CONFIG_SENSORS_INA3221=m
> > > CONFIG_SENSORS_TC74=m
> > > CONFIG_SENSORS_THMC50=m
> > > CONFIG_SENSORS_TMP102=m
> > > CONFIG_SENSORS_TMP103=m
> > > CONFIG_SENSORS_TMP108=m
> > > CONFIG_SENSORS_TMP401=m
> > > CONFIG_SENSORS_TMP421=m
> > > CONFIG_SENSORS_VIA_CPUTEMP=m
> > > CONFIG_SENSORS_VIA686A=m
> > > CONFIG_SENSORS_VT1211=m
> > > CONFIG_SENSORS_VT8231=m
> > > CONFIG_SENSORS_W83773G=m
> > > CONFIG_SENSORS_W83781D=m
> > > CONFIG_SENSORS_W83791D=m
> > > CONFIG_SENSORS_W83792D=m
> > > CONFIG_SENSORS_W83793=m
> > > CONFIG_SENSORS_W83795=m
> > > # CONFIG_SENSORS_W83795_FANCTRL is not set
> > > CONFIG_SENSORS_W83L785TS=m
> > > CONFIG_SENSORS_W83L786NG=m
> > > CONFIG_SENSORS_W83627HF=m
> > > CONFIG_SENSORS_W83627EHF=m
> > > CONFIG_SENSORS_WM831X=m
> > > CONFIG_SENSORS_WM8350=m
> > > CONFIG_SENSORS_XGENE=m
> > > 
> > > #
> > > # ACPI drivers
> > > #
> > > CONFIG_SENSORS_ACPI_POWER=m
> > > CONFIG_SENSORS_ATK0110=m
> > > CONFIG_THERMAL=y
> > > CONFIG_THERMAL_STATISTICS=y
> > > CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> > > CONFIG_THERMAL_HWMON=y
> > > CONFIG_THERMAL_WRITABLE_TRIPS=y
> > > CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> > > # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> > > # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> > > # CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
> > > CONFIG_THERMAL_GOV_FAIR_SHARE=y
> > > CONFIG_THERMAL_GOV_STEP_WISE=y
> > > CONFIG_THERMAL_GOV_BANG_BANG=y
> > > CONFIG_THERMAL_GOV_USER_SPACE=y
> > > CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
> > > # CONFIG_CLOCK_THERMAL is not set
> > > CONFIG_DEVFREQ_THERMAL=y
> > > CONFIG_THERMAL_EMULATION=y
> > > 
> > > #
> > > # Intel thermal drivers
> > > #
> > > CONFIG_INTEL_POWERCLAMP=m
> > > CONFIG_X86_PKG_TEMP_THERMAL=m
> > > CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
> > > CONFIG_INTEL_SOC_DTS_THERMAL=m
> > > 
> > > #
> > > # ACPI INT340X thermal drivers
> > > #
> > > CONFIG_INT340X_THERMAL=m
> > > CONFIG_ACPI_THERMAL_REL=m
> > > CONFIG_INT3406_THERMAL=m
> > > CONFIG_PROC_THERMAL_MMIO_RAPL=y
> > > # end of ACPI INT340X thermal drivers
> > > 
> > > CONFIG_INTEL_BXT_PMIC_THERMAL=m
> > > CONFIG_INTEL_PCH_THERMAL=m
> > > # end of Intel thermal drivers
> > > 
> > > CONFIG_GENERIC_ADC_THERMAL=m
> > > CONFIG_WATCHDOG=y
> > > CONFIG_WATCHDOG_CORE=y
> > > # CONFIG_WATCHDOG_NOWAYOUT is not set
> > > CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
> > > CONFIG_WATCHDOG_OPEN_TIMEOUT=0
> > > CONFIG_WATCHDOG_SYSFS=y
> > > 
> > > #
> > > # Watchdog Pretimeout Governors
> > > #
> > > CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
> > > CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
> > > CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
> > > CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=m
> > > CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
> > > # CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set
> > > 
> > > #
> > > # Watchdog Device Drivers
> > > #
> > > CONFIG_SOFT_WATCHDOG=m
> > > CONFIG_SOFT_WATCHDOG_PRETIMEOUT=y
> > > CONFIG_DA9052_WATCHDOG=m
> > > CONFIG_DA9055_WATCHDOG=m
> > > CONFIG_DA9063_WATCHDOG=m
> > > CONFIG_DA9062_WATCHDOG=m
> > > CONFIG_MENF21BMC_WATCHDOG=m
> > > CONFIG_MENZ069_WATCHDOG=m
> > > CONFIG_WDAT_WDT=m
> > > CONFIG_WM831X_WATCHDOG=m
> > > CONFIG_WM8350_WATCHDOG=m
> > > CONFIG_XILINX_WATCHDOG=m
> > > CONFIG_ZIIRAVE_WATCHDOG=m
> > > CONFIG_RAVE_SP_WATCHDOG=m
> > > CONFIG_MLX_WDT=m
> > > CONFIG_CADENCE_WATCHDOG=m
> > > CONFIG_DW_WATCHDOG=m
> > > CONFIG_TWL4030_WATCHDOG=m
> > > CONFIG_MAX63XX_WATCHDOG=m
> > > CONFIG_RETU_WATCHDOG=m
> > > CONFIG_ACQUIRE_WDT=m
> > > CONFIG_ADVANTECH_WDT=m
> > > CONFIG_ALIM1535_WDT=m
> > > CONFIG_ALIM7101_WDT=m
> > > CONFIG_EBC_C384_WDT=m
> > > CONFIG_F71808E_WDT=m
> > > CONFIG_SP5100_TCO=m
> > > CONFIG_SBC_FITPC2_WATCHDOG=m
> > > CONFIG_EUROTECH_WDT=m
> > > CONFIG_IB700_WDT=m
> > > CONFIG_IBMASR=m
> > > CONFIG_WAFER_WDT=m
> > > CONFIG_I6300ESB_WDT=m
> > > CONFIG_IE6XX_WDT=m
> > > CONFIG_ITCO_WDT=m
> > > CONFIG_ITCO_VENDOR_SUPPORT=y
> > > CONFIG_IT8712F_WDT=m
> > > CONFIG_IT87_WDT=m
> > > CONFIG_HP_WATCHDOG=m
> > > CONFIG_HPWDT_NMI_DECODING=y
> > > CONFIG_KEMPLD_WDT=m
> > > CONFIG_SC1200_WDT=m
> > > CONFIG_PC87413_WDT=m
> > > CONFIG_NV_TCO=m
> > > CONFIG_60XX_WDT=m
> > > CONFIG_CPU5_WDT=m
> > > CONFIG_SMSC_SCH311X_WDT=m
> > > CONFIG_SMSC37B787_WDT=m
> > > CONFIG_TQMX86_WDT=m
> > > CONFIG_VIA_WDT=m
> > > CONFIG_W83627HF_WDT=m
> > > CONFIG_W83877F_WDT=m
> > > CONFIG_W83977F_WDT=m
> > > CONFIG_MACHZ_WDT=m
> > > CONFIG_SBC_EPX_C3_WATCHDOG=m
> > > CONFIG_INTEL_MEI_WDT=m
> > > CONFIG_NI903X_WDT=m
> > > CONFIG_NIC7018_WDT=m
> > > CONFIG_MEN_A21_WDT=m
> > > CONFIG_XEN_WDT=m
> > > 
> > > #
> > > # PCI-based Watchdog Cards
> > > #
> > > CONFIG_PCIPCWATCHDOG=m
> > > CONFIG_WDTPCI=m
> > > 
> > > #
> > > # USB-based Watchdog Cards
> > > #
> > > CONFIG_USBPCWATCHDOG=m
> > > CONFIG_SSB_POSSIBLE=y
> > > CONFIG_SSB=m
> > > CONFIG_SSB_SPROM=y
> > > CONFIG_SSB_BLOCKIO=y
> > > CONFIG_SSB_PCIHOST_POSSIBLE=y
> > > CONFIG_SSB_PCIHOST=y
> > > CONFIG_SSB_B43_PCI_BRIDGE=y
> > > CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
> > > # CONFIG_SSB_PCMCIAHOST is not set
> > > CONFIG_SSB_SDIOHOST_POSSIBLE=y
> > > CONFIG_SSB_SDIOHOST=y
> > > CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
> > > CONFIG_SSB_DRIVER_PCICORE=y
> > > CONFIG_SSB_DRIVER_GPIO=y
> > > CONFIG_BCMA_POSSIBLE=y
> > > CONFIG_BCMA=m
> > > CONFIG_BCMA_BLOCKIO=y
> > > CONFIG_BCMA_HOST_PCI_POSSIBLE=y
> > > CONFIG_BCMA_HOST_PCI=y
> > > CONFIG_BCMA_HOST_SOC=y
> > > CONFIG_BCMA_DRIVER_PCI=y
> > > CONFIG_BCMA_SFLASH=y
> > > CONFIG_BCMA_DRIVER_GMAC_CMN=y
> > > CONFIG_BCMA_DRIVER_GPIO=y
> > > # CONFIG_BCMA_DEBUG is not set
> > > 
> > > #
> > > # Multifunction device drivers
> > > #
> > > CONFIG_MFD_CORE=y
> > > CONFIG_MFD_AS3711=y
> > > CONFIG_PMIC_ADP5520=y
> > > CONFIG_MFD_AAT2870_CORE=y
> > > CONFIG_MFD_BCM590XX=m
> > > CONFIG_MFD_BD9571MWV=m
> > > CONFIG_MFD_AXP20X=m
> > > CONFIG_MFD_AXP20X_I2C=m
> > > CONFIG_MFD_CROS_EC=m
> > > CONFIG_MFD_CROS_EC_CHARDEV=m
> > > CONFIG_MFD_MADERA=m
> > > CONFIG_MFD_MADERA_I2C=m
> > > CONFIG_MFD_MADERA_SPI=m
> > > CONFIG_MFD_CS47L15=y
> > > CONFIG_MFD_CS47L35=y
> > > CONFIG_MFD_CS47L85=y
> > > CONFIG_MFD_CS47L90=y
> > > CONFIG_MFD_CS47L92=y
> > > CONFIG_PMIC_DA903X=y
> > > CONFIG_PMIC_DA9052=y
> > > CONFIG_MFD_DA9052_SPI=y
> > > CONFIG_MFD_DA9052_I2C=y
> > > CONFIG_MFD_DA9055=y
> > > CONFIG_MFD_DA9062=m
> > > CONFIG_MFD_DA9063=y
> > > CONFIG_MFD_DA9150=m
> > > CONFIG_MFD_DLN2=m
> > > CONFIG_MFD_MC13XXX=m
> > > CONFIG_MFD_MC13XXX_SPI=m
> > > CONFIG_MFD_MC13XXX_I2C=m
> > > CONFIG_HTC_PASIC3=m
> > > CONFIG_HTC_I2CPLD=y
> > > CONFIG_MFD_INTEL_QUARK_I2C_GPIO=m
> > > CONFIG_LPC_ICH=m
> > > CONFIG_LPC_SCH=m
> > > CONFIG_INTEL_SOC_PMIC=y
> > > CONFIG_INTEL_SOC_PMIC_BXTWC=m
> > > CONFIG_INTEL_SOC_PMIC_CHTWC=y
> > > CONFIG_INTEL_SOC_PMIC_CHTDC_TI=m
> > > CONFIG_MFD_INTEL_LPSS=m
> > > CONFIG_MFD_INTEL_LPSS_ACPI=m
> > > CONFIG_MFD_INTEL_LPSS_PCI=m
> > > CONFIG_MFD_JANZ_CMODIO=m
> > > CONFIG_MFD_KEMPLD=m
> > > CONFIG_MFD_88PM800=m
> > > CONFIG_MFD_88PM805=m
> > > CONFIG_MFD_88PM860X=y
> > > CONFIG_MFD_MAX14577=y
> > > CONFIG_MFD_MAX77693=y
> > > CONFIG_MFD_MAX77843=y
> > > CONFIG_MFD_MAX8907=m
> > > CONFIG_MFD_MAX8925=y
> > > CONFIG_MFD_MAX8997=y
> > > CONFIG_MFD_MAX8998=y
> > > CONFIG_MFD_MT6397=m
> > > CONFIG_MFD_MENF21BMC=m
> > > CONFIG_EZX_PCAP=y
> > > CONFIG_MFD_VIPERBOARD=m
> > > CONFIG_MFD_RETU=m
> > > CONFIG_MFD_PCF50633=m
> > > CONFIG_PCF50633_ADC=m
> > > CONFIG_PCF50633_GPIO=m
> > > CONFIG_UCB1400_CORE=m
> > > CONFIG_MFD_RDC321X=m
> > > CONFIG_MFD_RT5033=m
> > > CONFIG_MFD_RC5T583=y
> > > CONFIG_MFD_SEC_CORE=y
> > > CONFIG_MFD_SI476X_CORE=m
> > > CONFIG_MFD_SM501=m
> > > CONFIG_MFD_SM501_GPIO=y
> > > CONFIG_MFD_SKY81452=m
> > > CONFIG_MFD_SMSC=y
> > > CONFIG_ABX500_CORE=y
> > > CONFIG_AB3100_CORE=y
> > > CONFIG_AB3100_OTP=m
> > > CONFIG_MFD_SYSCON=y
> > > CONFIG_MFD_TI_AM335X_TSCADC=m
> > > CONFIG_MFD_LP3943=m
> > > CONFIG_MFD_LP8788=y
> > > CONFIG_MFD_TI_LMU=m
> > > CONFIG_MFD_PALMAS=y
> > > CONFIG_TPS6105X=m
> > > CONFIG_TPS65010=m
> > > CONFIG_TPS6507X=m
> > > CONFIG_MFD_TPS65086=m
> > > CONFIG_MFD_TPS65090=y
> > > CONFIG_MFD_TPS68470=y
> > > CONFIG_MFD_TI_LP873X=m
> > > CONFIG_MFD_TPS6586X=y
> > > CONFIG_MFD_TPS65910=y
> > > CONFIG_MFD_TPS65912=y
> > > CONFIG_MFD_TPS65912_I2C=y
> > > CONFIG_MFD_TPS65912_SPI=y
> > > CONFIG_MFD_TPS80031=y
> > > CONFIG_TWL4030_CORE=y
> > > CONFIG_MFD_TWL4030_AUDIO=y
> > > CONFIG_TWL6040_CORE=y
> > > CONFIG_MFD_WL1273_CORE=m
> > > CONFIG_MFD_LM3533=m
> > > CONFIG_MFD_TQMX86=m
> > > CONFIG_MFD_VX855=m
> > > CONFIG_MFD_ARIZONA=y
> > > CONFIG_MFD_ARIZONA_I2C=m
> > > CONFIG_MFD_ARIZONA_SPI=m
> > > CONFIG_MFD_CS47L24=y
> > > CONFIG_MFD_WM5102=y
> > > CONFIG_MFD_WM5110=y
> > > CONFIG_MFD_WM8997=y
> > > CONFIG_MFD_WM8998=y
> > > CONFIG_MFD_WM8400=y
> > > CONFIG_MFD_WM831X=y
> > > CONFIG_MFD_WM831X_I2C=y
> > > CONFIG_MFD_WM831X_SPI=y
> > > CONFIG_MFD_WM8350=y
> > > CONFIG_MFD_WM8350_I2C=y
> > > CONFIG_MFD_WM8994=m
> > > CONFIG_RAVE_SP_CORE=m
> > > # end of Multifunction device drivers
> > > 
> > > CONFIG_REGULATOR=y
> > > # CONFIG_REGULATOR_DEBUG is not set
> > > CONFIG_REGULATOR_FIXED_VOLTAGE=m
> > > CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
> > > CONFIG_REGULATOR_USERSPACE_CONSUMER=m
> > > CONFIG_REGULATOR_88PG86X=m
> > > CONFIG_REGULATOR_88PM800=m
> > > CONFIG_REGULATOR_88PM8607=m
> > > CONFIG_REGULATOR_ACT8865=m
> > > CONFIG_REGULATOR_AD5398=m
> > > CONFIG_REGULATOR_ANATOP=m
> > > CONFIG_REGULATOR_AAT2870=m
> > > CONFIG_REGULATOR_AB3100=m
> > > CONFIG_REGULATOR_ARIZONA_LDO1=m
> > > CONFIG_REGULATOR_ARIZONA_MICSUPP=m
> > > CONFIG_REGULATOR_AS3711=m
> > > CONFIG_REGULATOR_AXP20X=m
> > > CONFIG_REGULATOR_BCM590XX=m
> > > CONFIG_REGULATOR_BD9571MWV=m
> > > CONFIG_REGULATOR_DA903X=m
> > > CONFIG_REGULATOR_DA9052=m
> > > CONFIG_REGULATOR_DA9055=m
> > > CONFIG_REGULATOR_DA9062=m
> > > CONFIG_REGULATOR_DA9210=m
> > > CONFIG_REGULATOR_DA9211=m
> > > CONFIG_REGULATOR_FAN53555=m
> > > CONFIG_REGULATOR_GPIO=m
> > > CONFIG_REGULATOR_ISL9305=m
> > > CONFIG_REGULATOR_ISL6271A=m
> > > CONFIG_REGULATOR_LM363X=m
> > > CONFIG_REGULATOR_LP3971=m
> > > CONFIG_REGULATOR_LP3972=m
> > > CONFIG_REGULATOR_LP872X=m
> > > CONFIG_REGULATOR_LP8755=m
> > > CONFIG_REGULATOR_LP8788=m
> > > CONFIG_REGULATOR_LTC3589=m
> > > CONFIG_REGULATOR_LTC3676=m
> > > CONFIG_REGULATOR_MAX14577=m
> > > CONFIG_REGULATOR_MAX1586=m
> > > CONFIG_REGULATOR_MAX8649=m
> > > CONFIG_REGULATOR_MAX8660=m
> > > CONFIG_REGULATOR_MAX8907=m
> > > CONFIG_REGULATOR_MAX8925=m
> > > CONFIG_REGULATOR_MAX8952=m
> > > CONFIG_REGULATOR_MAX8997=m
> > > CONFIG_REGULATOR_MAX8998=m
> > > CONFIG_REGULATOR_MAX77693=m
> > > CONFIG_REGULATOR_MC13XXX_CORE=m
> > > CONFIG_REGULATOR_MC13783=m
> > > CONFIG_REGULATOR_MC13892=m
> > > CONFIG_REGULATOR_MT6311=m
> > > CONFIG_REGULATOR_MT6323=m
> > > CONFIG_REGULATOR_MT6397=m
> > > CONFIG_REGULATOR_PALMAS=m
> > > CONFIG_REGULATOR_PCAP=m
> > > CONFIG_REGULATOR_PCF50633=m
> > > CONFIG_REGULATOR_PFUZE100=m
> > > CONFIG_REGULATOR_PV88060=m
> > > CONFIG_REGULATOR_PV88080=m
> > > CONFIG_REGULATOR_PV88090=m
> > > CONFIG_REGULATOR_PWM=m
> > > CONFIG_REGULATOR_QCOM_SPMI=m
> > > CONFIG_REGULATOR_RC5T583=m
> > > CONFIG_REGULATOR_RT5033=m
> > > CONFIG_REGULATOR_S2MPA01=m
> > > CONFIG_REGULATOR_S2MPS11=m
> > > CONFIG_REGULATOR_S5M8767=m
> > > CONFIG_REGULATOR_SKY81452=m
> > > CONFIG_REGULATOR_SLG51000=m
> > > CONFIG_REGULATOR_TPS51632=m
> > > CONFIG_REGULATOR_TPS6105X=m
> > > CONFIG_REGULATOR_TPS62360=m
> > > CONFIG_REGULATOR_TPS65023=m
> > > CONFIG_REGULATOR_TPS6507X=m
> > > CONFIG_REGULATOR_TPS65086=m
> > > CONFIG_REGULATOR_TPS65090=m
> > > CONFIG_REGULATOR_TPS65132=m
> > > CONFIG_REGULATOR_TPS6524X=m
> > > CONFIG_REGULATOR_TPS6586X=m
> > > CONFIG_REGULATOR_TPS65910=m
> > > CONFIG_REGULATOR_TPS65912=m
> > > CONFIG_REGULATOR_TPS80031=m
> > > CONFIG_REGULATOR_TWL4030=m
> > > CONFIG_REGULATOR_WM831X=m
> > > CONFIG_REGULATOR_WM8350=m
> > > CONFIG_REGULATOR_WM8400=m
> > > CONFIG_REGULATOR_WM8994=m
> > > CONFIG_CEC_CORE=y
> > > CONFIG_CEC_NOTIFIER=y
> > > CONFIG_RC_CORE=m
> > > CONFIG_RC_MAP=m
> > > CONFIG_LIRC=y
> > > CONFIG_RC_DECODERS=y
> > > CONFIG_IR_NEC_DECODER=m
> > > CONFIG_IR_RC5_DECODER=m
> > > CONFIG_IR_RC6_DECODER=m
> > > CONFIG_IR_JVC_DECODER=m
> > > CONFIG_IR_SONY_DECODER=m
> > > CONFIG_IR_SANYO_DECODER=m
> > > CONFIG_IR_SHARP_DECODER=m
> > > CONFIG_IR_MCE_KBD_DECODER=m
> > > CONFIG_IR_XMP_DECODER=m
> > > CONFIG_IR_IMON_DECODER=m
> > > CONFIG_IR_RCMM_DECODER=m
> > > CONFIG_RC_DEVICES=y
> > > CONFIG_RC_ATI_REMOTE=m
> > > CONFIG_IR_ENE=m
> > > CONFIG_IR_IMON=m
> > > CONFIG_IR_IMON_RAW=m
> > > CONFIG_IR_MCEUSB=m
> > > CONFIG_IR_ITE_CIR=m
> > > CONFIG_IR_FINTEK=m
> > > CONFIG_IR_NUVOTON=m
> > > CONFIG_IR_REDRAT3=m
> > > CONFIG_IR_STREAMZAP=m
> > > CONFIG_IR_WINBOND_CIR=m
> > > CONFIG_IR_IGORPLUGUSB=m
> > > CONFIG_IR_IGUANA=m
> > > CONFIG_IR_TTUSBIR=m
> > > CONFIG_RC_LOOPBACK=m
> > > CONFIG_IR_SERIAL=m
> > > CONFIG_IR_SERIAL_TRANSMITTER=y
> > > CONFIG_IR_SIR=m
> > > CONFIG_RC_XBOX_DVD=m
> > > CONFIG_MEDIA_SUPPORT=m
> > > 
> > > #
> > > # Multimedia core support
> > > #
> > > CONFIG_MEDIA_CAMERA_SUPPORT=y
> > > CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
> > > CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
> > > CONFIG_MEDIA_RADIO_SUPPORT=y
> > > CONFIG_MEDIA_SDR_SUPPORT=y
> > > CONFIG_MEDIA_CEC_SUPPORT=y
> > > CONFIG_MEDIA_CONTROLLER=y
> > > CONFIG_MEDIA_CONTROLLER_DVB=y
> > > # CONFIG_MEDIA_CONTROLLER_REQUEST_API is not set
> > > CONFIG_VIDEO_DEV=m
> > > CONFIG_VIDEO_V4L2_SUBDEV_API=y
> > > CONFIG_VIDEO_V4L2=m
> > > # CONFIG_VIDEO_ADV_DEBUG is not set
> > > # CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
> > > # CONFIG_VIDEO_PCI_SKELETON is not set
> > > CONFIG_VIDEO_TUNER=m
> > > CONFIG_V4L2_MEM2MEM_DEV=m
> > > CONFIG_V4L2_FLASH_LED_CLASS=m
> > > CONFIG_V4L2_FWNODE=m
> > > CONFIG_VIDEOBUF_GEN=m
> > > CONFIG_VIDEOBUF_DMA_SG=m
> > > CONFIG_VIDEOBUF_VMALLOC=m
> > > CONFIG_DVB_CORE=m
> > > # CONFIG_DVB_MMAP is not set
> > > CONFIG_DVB_NET=y
> > > CONFIG_TTPCI_EEPROM=m
> > > CONFIG_DVB_MAX_ADAPTERS=8
> > > CONFIG_DVB_DYNAMIC_MINORS=y
> > > # CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
> > > # CONFIG_DVB_ULE_DEBUG is not set
> > > 
> > > #
> > > # Media drivers
> > > #
> > > CONFIG_MEDIA_USB_SUPPORT=y
> > > 
> > > #
> > > # Webcam devices
> > > #
> > > CONFIG_USB_VIDEO_CLASS=m
> > > CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
> > > CONFIG_USB_GSPCA=m
> > > CONFIG_USB_M5602=m
> > > CONFIG_USB_STV06XX=m
> > > CONFIG_USB_GL860=m
> > > CONFIG_USB_GSPCA_BENQ=m
> > > CONFIG_USB_GSPCA_CONEX=m
> > > CONFIG_USB_GSPCA_CPIA1=m
> > > CONFIG_USB_GSPCA_DTCS033=m
> > > CONFIG_USB_GSPCA_ETOMS=m
> > > CONFIG_USB_GSPCA_FINEPIX=m
> > > CONFIG_USB_GSPCA_JEILINJ=m
> > > CONFIG_USB_GSPCA_JL2005BCD=m
> > > CONFIG_USB_GSPCA_KINECT=m
> > > CONFIG_USB_GSPCA_KONICA=m
> > > CONFIG_USB_GSPCA_MARS=m
> > > CONFIG_USB_GSPCA_MR97310A=m
> > > CONFIG_USB_GSPCA_NW80X=m
> > > CONFIG_USB_GSPCA_OV519=m
> > > CONFIG_USB_GSPCA_OV534=m
> > > CONFIG_USB_GSPCA_OV534_9=m
> > > CONFIG_USB_GSPCA_PAC207=m
> > > CONFIG_USB_GSPCA_PAC7302=m
> > > CONFIG_USB_GSPCA_PAC7311=m
> > > CONFIG_USB_GSPCA_SE401=m
> > > CONFIG_USB_GSPCA_SN9C2028=m
> > > CONFIG_USB_GSPCA_SN9C20X=m
> > > CONFIG_USB_GSPCA_SONIXB=m
> > > CONFIG_USB_GSPCA_SONIXJ=m
> > > CONFIG_USB_GSPCA_SPCA500=m
> > > CONFIG_USB_GSPCA_SPCA501=m
> > > CONFIG_USB_GSPCA_SPCA505=m
> > > CONFIG_USB_GSPCA_SPCA506=m
> > > CONFIG_USB_GSPCA_SPCA508=m
> > > CONFIG_USB_GSPCA_SPCA561=m
> > > CONFIG_USB_GSPCA_SPCA1528=m
> > > CONFIG_USB_GSPCA_SQ905=m
> > > CONFIG_USB_GSPCA_SQ905C=m
> > > CONFIG_USB_GSPCA_SQ930X=m
> > > CONFIG_USB_GSPCA_STK014=m
> > > CONFIG_USB_GSPCA_STK1135=m
> > > CONFIG_USB_GSPCA_STV0680=m
> > > CONFIG_USB_GSPCA_SUNPLUS=m
> > > CONFIG_USB_GSPCA_T613=m
> > > CONFIG_USB_GSPCA_TOPRO=m
> > > CONFIG_USB_GSPCA_TOUPTEK=m
> > > CONFIG_USB_GSPCA_TV8532=m
> > > CONFIG_USB_GSPCA_VC032X=m
> > > CONFIG_USB_GSPCA_VICAM=m
> > > CONFIG_USB_GSPCA_XIRLINK_CIT=m
> > > CONFIG_USB_GSPCA_ZC3XX=m
> > > CONFIG_USB_PWC=m
> > > # CONFIG_USB_PWC_DEBUG is not set
> > > CONFIG_USB_PWC_INPUT_EVDEV=y
> > > CONFIG_VIDEO_CPIA2=m
> > > CONFIG_USB_ZR364XX=m
> > > CONFIG_USB_STKWEBCAM=m
> > > CONFIG_USB_S2255=m
> > > CONFIG_VIDEO_USBTV=m
> > > 
> > > #
> > > # Analog TV USB devices
> > > #
> > > CONFIG_VIDEO_PVRUSB2=m
> > > CONFIG_VIDEO_PVRUSB2_SYSFS=y
> > > CONFIG_VIDEO_PVRUSB2_DVB=y
> > > # CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
> > > CONFIG_VIDEO_HDPVR=m
> > > CONFIG_VIDEO_USBVISION=m
> > > CONFIG_VIDEO_STK1160_COMMON=m
> > > CONFIG_VIDEO_STK1160=m
> > > CONFIG_VIDEO_GO7007=m
> > > CONFIG_VIDEO_GO7007_USB=m
> > > CONFIG_VIDEO_GO7007_LOADER=m
> > > CONFIG_VIDEO_GO7007_USB_S2250_BOARD=m
> > > 
> > > #
> > > # Analog/digital TV USB devices
> > > #
> > > CONFIG_VIDEO_AU0828=m
> > > CONFIG_VIDEO_AU0828_V4L2=y
> > > CONFIG_VIDEO_AU0828_RC=y
> > > CONFIG_VIDEO_CX231XX=m
> > > CONFIG_VIDEO_CX231XX_RC=y
> > > CONFIG_VIDEO_CX231XX_ALSA=m
> > > CONFIG_VIDEO_CX231XX_DVB=m
> > > CONFIG_VIDEO_TM6000=m
> > > CONFIG_VIDEO_TM6000_ALSA=m
> > > CONFIG_VIDEO_TM6000_DVB=m
> > > 
> > > #
> > > # Digital TV USB devices
> > > #
> > > CONFIG_DVB_USB=m
> > > # CONFIG_DVB_USB_DEBUG is not set
> > > CONFIG_DVB_USB_DIB3000MC=m
> > > CONFIG_DVB_USB_A800=m
> > > CONFIG_DVB_USB_DIBUSB_MB=m
> > > # CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
> > > CONFIG_DVB_USB_DIBUSB_MC=m
> > > CONFIG_DVB_USB_DIB0700=m
> > > CONFIG_DVB_USB_UMT_010=m
> > > CONFIG_DVB_USB_CXUSB=m
> > > CONFIG_DVB_USB_CXUSB_ANALOG=y
> > > CONFIG_DVB_USB_M920X=m
> > > CONFIG_DVB_USB_DIGITV=m
> > > CONFIG_DVB_USB_VP7045=m
> > > CONFIG_DVB_USB_VP702X=m
> > > CONFIG_DVB_USB_GP8PSK=m
> > > CONFIG_DVB_USB_NOVA_T_USB2=m
> > > CONFIG_DVB_USB_TTUSB2=m
> > > CONFIG_DVB_USB_DTT200U=m
> > > CONFIG_DVB_USB_OPERA1=m
> > > CONFIG_DVB_USB_AF9005=m
> > > CONFIG_DVB_USB_AF9005_REMOTE=m
> > > CONFIG_DVB_USB_PCTV452E=m
> > > CONFIG_DVB_USB_DW2102=m
> > > CONFIG_DVB_USB_CINERGY_T2=m
> > > CONFIG_DVB_USB_DTV5100=m
> > > CONFIG_DVB_USB_AZ6027=m
> > > CONFIG_DVB_USB_TECHNISAT_USB2=m
> > > CONFIG_DVB_USB_V2=m
> > > CONFIG_DVB_USB_AF9015=m
> > > CONFIG_DVB_USB_AF9035=m
> > > CONFIG_DVB_USB_ANYSEE=m
> > > CONFIG_DVB_USB_AU6610=m
> > > CONFIG_DVB_USB_AZ6007=m
> > > CONFIG_DVB_USB_CE6230=m
> > > CONFIG_DVB_USB_EC168=m
> > > CONFIG_DVB_USB_GL861=m
> > > CONFIG_DVB_USB_LME2510=m
> > > CONFIG_DVB_USB_MXL111SF=m
> > > CONFIG_DVB_USB_RTL28XXU=m
> > > CONFIG_DVB_USB_DVBSKY=m
> > > CONFIG_DVB_USB_ZD1301=m
> > > CONFIG_DVB_TTUSB_BUDGET=m
> > > CONFIG_DVB_TTUSB_DEC=m
> > > CONFIG_SMS_USB_DRV=m
> > > CONFIG_DVB_B2C2_FLEXCOP_USB=m
> > > # CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
> > > CONFIG_DVB_AS102=m
> > > 
> > > #
> > > # Webcam, TV (analog/digital) USB devices
> > > #
> > > CONFIG_VIDEO_EM28XX=m
> > > CONFIG_VIDEO_EM28XX_V4L2=m
> > > CONFIG_VIDEO_EM28XX_ALSA=m
> > > CONFIG_VIDEO_EM28XX_DVB=m
> > > CONFIG_VIDEO_EM28XX_RC=m
> > > 
> > > #
> > > # Software defined radio USB devices
> > > #
> > > CONFIG_USB_AIRSPY=m
> > > CONFIG_USB_HACKRF=m
> > > CONFIG_USB_MSI2500=m
> > > 
> > > #
> > > # USB HDMI CEC adapters
> > > #
> > > CONFIG_USB_PULSE8_CEC=m
> > > CONFIG_USB_RAINSHADOW_CEC=m
> > > CONFIG_MEDIA_PCI_SUPPORT=y
> > > 
> > > #
> > > # Media capture support
> > > #
> > > CONFIG_VIDEO_MEYE=m
> > > CONFIG_VIDEO_SOLO6X10=m
> > > CONFIG_VIDEO_TW5864=m
> > > CONFIG_VIDEO_TW68=m
> > > CONFIG_VIDEO_TW686X=m
> > > 
> > > #
> > > # Media capture/analog TV support
> > > #
> > > CONFIG_VIDEO_IVTV=m
> > > # CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
> > > CONFIG_VIDEO_IVTV_ALSA=m
> > > CONFIG_VIDEO_FB_IVTV=m
> > > CONFIG_VIDEO_FB_IVTV_FORCE_PAT=y
> > > CONFIG_VIDEO_HEXIUM_GEMINI=m
> > > CONFIG_VIDEO_HEXIUM_ORION=m
> > > CONFIG_VIDEO_MXB=m
> > > CONFIG_VIDEO_DT3155=m
> > > 
> > > #
> > > # Media capture/analog/hybrid TV support
> > > #
> > > CONFIG_VIDEO_CX18=m
> > > CONFIG_VIDEO_CX18_ALSA=m
> > > CONFIG_VIDEO_CX23885=m
> > > CONFIG_MEDIA_ALTERA_CI=m
> > > CONFIG_VIDEO_CX25821=m
> > > CONFIG_VIDEO_CX25821_ALSA=m
> > > CONFIG_VIDEO_CX88=m
> > > CONFIG_VIDEO_CX88_ALSA=m
> > > CONFIG_VIDEO_CX88_BLACKBIRD=m
> > > CONFIG_VIDEO_CX88_DVB=m
> > > CONFIG_VIDEO_CX88_ENABLE_VP3054=y
> > > CONFIG_VIDEO_CX88_VP3054=m
> > > CONFIG_VIDEO_CX88_MPEG=m
> > > CONFIG_VIDEO_BT848=m
> > > CONFIG_DVB_BT8XX=m
> > > CONFIG_VIDEO_SAA7134=m
> > > CONFIG_VIDEO_SAA7134_ALSA=m
> > > CONFIG_VIDEO_SAA7134_RC=y
> > > CONFIG_VIDEO_SAA7134_DVB=m
> > > CONFIG_VIDEO_SAA7134_GO7007=m
> > > CONFIG_VIDEO_SAA7164=m
> > > CONFIG_VIDEO_COBALT=m
> > > 
> > > #
> > > # Media digital TV PCI Adapters
> > > #
> > > CONFIG_DVB_AV7110_IR=y
> > > CONFIG_DVB_AV7110=m
> > > CONFIG_DVB_AV7110_OSD=y
> > > CONFIG_DVB_BUDGET_CORE=m
> > > CONFIG_DVB_BUDGET=m
> > > CONFIG_DVB_BUDGET_CI=m
> > > CONFIG_DVB_BUDGET_AV=m
> > > CONFIG_DVB_BUDGET_PATCH=m
> > > CONFIG_DVB_B2C2_FLEXCOP_PCI=m
> > > # CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
> > > CONFIG_DVB_PLUTO2=m
> > > CONFIG_DVB_DM1105=m
> > > CONFIG_DVB_PT1=m
> > > CONFIG_DVB_PT3=m
> > > CONFIG_MANTIS_CORE=m
> > > CONFIG_DVB_MANTIS=m
> > > CONFIG_DVB_HOPPER=m
> > > CONFIG_DVB_NGENE=m
> > > CONFIG_DVB_DDBRIDGE=m
> > > # CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
> > > CONFIG_DVB_SMIPCIE=m
> > > CONFIG_DVB_NETUP_UNIDVB=m
> > > CONFIG_VIDEO_IPU3_CIO2=m
> > > CONFIG_V4L_PLATFORM_DRIVERS=y
> > > CONFIG_VIDEO_CAFE_CCIC=m
> > > CONFIG_VIDEO_VIA_CAMERA=m
> > > CONFIG_VIDEO_CADENCE=y
> > > CONFIG_VIDEO_CADENCE_CSI2RX=m
> > > CONFIG_VIDEO_CADENCE_CSI2TX=m
> > > CONFIG_VIDEO_ASPEED=m
> > > CONFIG_V4L_MEM2MEM_DRIVERS=y
> > > CONFIG_VIDEO_MEM2MEM_DEINTERLACE=m
> > > CONFIG_VIDEO_SH_VEU=m
> > > CONFIG_V4L_TEST_DRIVERS=y
> > > CONFIG_VIDEO_VIMC=m
> > > CONFIG_VIDEO_VIVID=m
> > > CONFIG_VIDEO_VIVID_CEC=y
> > > CONFIG_VIDEO_VIVID_MAX_DEVS=64
> > > CONFIG_VIDEO_VIM2M=m
> > > CONFIG_VIDEO_VICODEC=m
> > > CONFIG_DVB_PLATFORM_DRIVERS=y
> > > CONFIG_CEC_PLATFORM_DRIVERS=y
> > > CONFIG_VIDEO_CROS_EC_CEC=m
> > > CONFIG_VIDEO_SECO_CEC=m
> > > CONFIG_VIDEO_SECO_RC=y
> > > CONFIG_SDR_PLATFORM_DRIVERS=y
> > > 
> > > #
> > > # Supported MMC/SDIO adapters
> > > #
> > > CONFIG_SMS_SDIO_DRV=m
> > > CONFIG_RADIO_ADAPTERS=y
> > > CONFIG_RADIO_TEA575X=m
> > > CONFIG_RADIO_SI470X=m
> > > CONFIG_USB_SI470X=m
> > > CONFIG_I2C_SI470X=m
> > > CONFIG_RADIO_SI4713=m
> > > CONFIG_USB_SI4713=m
> > > CONFIG_PLATFORM_SI4713=m
> > > CONFIG_I2C_SI4713=m
> > > CONFIG_RADIO_SI476X=m
> > > CONFIG_USB_MR800=m
> > > CONFIG_USB_DSBR=m
> > > CONFIG_RADIO_MAXIRADIO=m
> > > CONFIG_RADIO_SHARK=m
> > > CONFIG_RADIO_SHARK2=m
> > > CONFIG_USB_KEENE=m
> > > CONFIG_USB_RAREMONO=m
> > > CONFIG_USB_MA901=m
> > > CONFIG_RADIO_TEA5764=m
> > > CONFIG_RADIO_SAA7706H=m
> > > CONFIG_RADIO_TEF6862=m
> > > CONFIG_RADIO_WL1273=m
> > > 
> > > #
> > > # Texas Instruments WL128x FM driver (ST based)
> > > #
> > > CONFIG_RADIO_WL128X=m
> > > # end of Texas Instruments WL128x FM driver (ST based)
> > > 
> > > #
> > > # Supported FireWire (IEEE 1394) Adapters
> > > #
> > > CONFIG_DVB_FIREDTV=m
> > > CONFIG_DVB_FIREDTV_INPUT=y
> > > CONFIG_MEDIA_COMMON_OPTIONS=y
> > > 
> > > #
> > > # common driver options
> > > #
> > > CONFIG_VIDEO_CX2341X=m
> > > CONFIG_VIDEO_TVEEPROM=m
> > > CONFIG_CYPRESS_FIRMWARE=m
> > > CONFIG_VIDEOBUF2_CORE=m
> > > CONFIG_VIDEOBUF2_V4L2=m
> > > CONFIG_VIDEOBUF2_MEMOPS=m
> > > CONFIG_VIDEOBUF2_DMA_CONTIG=m
> > > CONFIG_VIDEOBUF2_VMALLOC=m
> > > CONFIG_VIDEOBUF2_DMA_SG=m
> > > CONFIG_VIDEOBUF2_DVB=m
> > > CONFIG_DVB_B2C2_FLEXCOP=m
> > > CONFIG_VIDEO_SAA7146=m
> > > CONFIG_VIDEO_SAA7146_VV=m
> > > CONFIG_SMS_SIANO_MDTV=m
> > > CONFIG_SMS_SIANO_RC=y
> > > CONFIG_SMS_SIANO_DEBUGFS=y
> > > CONFIG_VIDEO_V4L2_TPG=m
> > > 
> > > #
> > > # Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
> > > #
> > > CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
> > > CONFIG_MEDIA_ATTACH=y
> > > CONFIG_VIDEO_IR_I2C=m
> > > 
> > > #
> > > # I2C Encoders, decoders, sensors and other helper chips
> > > #
> > > 
> > > #
> > > # Audio decoders, processors and mixers
> > > #
> > > CONFIG_VIDEO_TVAUDIO=m
> > > CONFIG_VIDEO_TDA7432=m
> > > CONFIG_VIDEO_TDA9840=m
> > > CONFIG_VIDEO_TDA1997X=m
> > > CONFIG_VIDEO_TEA6415C=m
> > > CONFIG_VIDEO_TEA6420=m
> > > CONFIG_VIDEO_MSP3400=m
> > > CONFIG_VIDEO_CS3308=m
> > > CONFIG_VIDEO_CS5345=m
> > > CONFIG_VIDEO_CS53L32A=m
> > > CONFIG_VIDEO_TLV320AIC23B=m
> > > CONFIG_VIDEO_UDA1342=m
> > > CONFIG_VIDEO_WM8775=m
> > > CONFIG_VIDEO_WM8739=m
> > > CONFIG_VIDEO_VP27SMPX=m
> > > CONFIG_VIDEO_SONY_BTF_MPX=m
> > > 
> > > #
> > > # RDS decoders
> > > #
> > > CONFIG_VIDEO_SAA6588=m
> > > 
> > > #
> > > # Video decoders
> > > #
> > > CONFIG_VIDEO_ADV7180=m
> > > CONFIG_VIDEO_ADV7183=m
> > > CONFIG_VIDEO_ADV7604=m
> > > CONFIG_VIDEO_ADV7604_CEC=y
> > > CONFIG_VIDEO_ADV7842=m
> > > CONFIG_VIDEO_ADV7842_CEC=y
> > > CONFIG_VIDEO_BT819=m
> > > CONFIG_VIDEO_BT856=m
> > > CONFIG_VIDEO_BT866=m
> > > CONFIG_VIDEO_KS0127=m
> > > CONFIG_VIDEO_ML86V7667=m
> > > CONFIG_VIDEO_SAA7110=m
> > > CONFIG_VIDEO_SAA711X=m
> > > CONFIG_VIDEO_TC358743=m
> > > CONFIG_VIDEO_TC358743_CEC=y
> > > CONFIG_VIDEO_TVP514X=m
> > > CONFIG_VIDEO_TVP5150=m
> > > CONFIG_VIDEO_TVP7002=m
> > > CONFIG_VIDEO_TW2804=m
> > > CONFIG_VIDEO_TW9903=m
> > > CONFIG_VIDEO_TW9906=m
> > > CONFIG_VIDEO_TW9910=m
> > > CONFIG_VIDEO_VPX3220=m
> > > 
> > > #
> > > # Video and audio decoders
> > > #
> > > CONFIG_VIDEO_SAA717X=m
> > > CONFIG_VIDEO_CX25840=m
> > > 
> > > #
> > > # Video encoders
> > > #
> > > CONFIG_VIDEO_SAA7127=m
> > > CONFIG_VIDEO_SAA7185=m
> > > CONFIG_VIDEO_ADV7170=m
> > > CONFIG_VIDEO_ADV7175=m
> > > CONFIG_VIDEO_ADV7343=m
> > > CONFIG_VIDEO_ADV7393=m
> > > CONFIG_VIDEO_ADV7511=m
> > > CONFIG_VIDEO_ADV7511_CEC=y
> > > CONFIG_VIDEO_AD9389B=m
> > > CONFIG_VIDEO_AK881X=m
> > > CONFIG_VIDEO_THS8200=m
> > > 
> > > #
> > > # Camera sensor devices
> > > #
> > > CONFIG_VIDEO_APTINA_PLL=m
> > > CONFIG_VIDEO_SMIAPP_PLL=m
> > > CONFIG_VIDEO_IMX214=m
> > > CONFIG_VIDEO_IMX258=m
> > > CONFIG_VIDEO_IMX274=m
> > > CONFIG_VIDEO_IMX319=m
> > > CONFIG_VIDEO_IMX355=m
> > > CONFIG_VIDEO_OV2640=m
> > > CONFIG_VIDEO_OV2659=m
> > > CONFIG_VIDEO_OV2680=m
> > > CONFIG_VIDEO_OV2685=m
> > > CONFIG_VIDEO_OV5647=m
> > > CONFIG_VIDEO_OV6650=m
> > > CONFIG_VIDEO_OV5670=m
> > > CONFIG_VIDEO_OV5695=m
> > > CONFIG_VIDEO_OV7251=m
> > > CONFIG_VIDEO_OV772X=m
> > > CONFIG_VIDEO_OV7640=m
> > > CONFIG_VIDEO_OV7670=m
> > > CONFIG_VIDEO_OV7740=m
> > > CONFIG_VIDEO_OV8856=m
> > > CONFIG_VIDEO_OV9640=m
> > > CONFIG_VIDEO_OV9650=m
> > > CONFIG_VIDEO_OV13858=m
> > > CONFIG_VIDEO_VS6624=m
> > > CONFIG_VIDEO_MT9M001=m
> > > CONFIG_VIDEO_MT9M032=m
> > > CONFIG_VIDEO_MT9M111=m
> > > CONFIG_VIDEO_MT9P031=m
> > > CONFIG_VIDEO_MT9T001=m
> > > CONFIG_VIDEO_MT9T112=m
> > > CONFIG_VIDEO_MT9V011=m
> > > CONFIG_VIDEO_MT9V032=m
> > > CONFIG_VIDEO_MT9V111=m
> > > CONFIG_VIDEO_SR030PC30=m
> > > CONFIG_VIDEO_NOON010PC30=m
> > > CONFIG_VIDEO_M5MOLS=m
> > > CONFIG_VIDEO_RJ54N1=m
> > > CONFIG_VIDEO_S5K6AA=m
> > > CONFIG_VIDEO_S5K6A3=m
> > > CONFIG_VIDEO_S5K4ECGX=m
> > > CONFIG_VIDEO_S5K5BAF=m
> > > CONFIG_VIDEO_SMIAPP=m
> > > CONFIG_VIDEO_ET8EK8=m
> > > CONFIG_VIDEO_S5C73M3=m
> > > 
> > > #
> > > # Lens drivers
> > > #
> > > CONFIG_VIDEO_AD5820=m
> > > CONFIG_VIDEO_AK7375=m
> > > CONFIG_VIDEO_DW9714=m
> > > CONFIG_VIDEO_DW9807_VCM=m
> > > 
> > > #
> > > # Flash devices
> > > #
> > > CONFIG_VIDEO_ADP1653=m
> > > CONFIG_VIDEO_LM3560=m
> > > CONFIG_VIDEO_LM3646=m
> > > 
> > > #
> > > # Video improvement chips
> > > #
> > > CONFIG_VIDEO_UPD64031A=m
> > > CONFIG_VIDEO_UPD64083=m
> > > 
> > > #
> > > # Audio/Video compression chips
> > > #
> > > CONFIG_VIDEO_SAA6752HS=m
> > > 
> > > #
> > > # SDR tuner chips
> > > #
> > > CONFIG_SDR_MAX2175=m
> > > 
> > > #
> > > # Miscellaneous helper chips
> > > #
> > > CONFIG_VIDEO_THS7303=m
> > > CONFIG_VIDEO_M52790=m
> > > CONFIG_VIDEO_I2C=m
> > > CONFIG_VIDEO_ST_MIPID02=m
> > > # end of I2C Encoders, decoders, sensors and other helper chips
> > > 
> > > #
> > > # SPI helper chips
> > > #
> > > CONFIG_VIDEO_GS1662=m
> > > # end of SPI helper chips
> > > 
> > > #
> > > # Media SPI Adapters
> > > #
> > > CONFIG_CXD2880_SPI_DRV=m
> > > # end of Media SPI Adapters
> > > 
> > > CONFIG_MEDIA_TUNER=m
> > > 
> > > #
> > > # Customize TV tuners
> > > #
> > > CONFIG_MEDIA_TUNER_SIMPLE=m
> > > CONFIG_MEDIA_TUNER_TDA18250=m
> > > CONFIG_MEDIA_TUNER_TDA8290=m
> > > CONFIG_MEDIA_TUNER_TDA827X=m
> > > CONFIG_MEDIA_TUNER_TDA18271=m
> > > CONFIG_MEDIA_TUNER_TDA9887=m
> > > CONFIG_MEDIA_TUNER_TEA5761=m
> > > CONFIG_MEDIA_TUNER_TEA5767=m
> > > CONFIG_MEDIA_TUNER_MSI001=m
> > > CONFIG_MEDIA_TUNER_MT20XX=m
> > > CONFIG_MEDIA_TUNER_MT2060=m
> > > CONFIG_MEDIA_TUNER_MT2063=m
> > > CONFIG_MEDIA_TUNER_MT2266=m
> > > CONFIG_MEDIA_TUNER_MT2131=m
> > > CONFIG_MEDIA_TUNER_QT1010=m
> > > CONFIG_MEDIA_TUNER_XC2028=m
> > > CONFIG_MEDIA_TUNER_XC5000=m
> > > CONFIG_MEDIA_TUNER_XC4000=m
> > > CONFIG_MEDIA_TUNER_MXL5005S=m
> > > CONFIG_MEDIA_TUNER_MXL5007T=m
> > > CONFIG_MEDIA_TUNER_MC44S803=m
> > > CONFIG_MEDIA_TUNER_MAX2165=m
> > > CONFIG_MEDIA_TUNER_TDA18218=m
> > > CONFIG_MEDIA_TUNER_FC0011=m
> > > CONFIG_MEDIA_TUNER_FC0012=m
> > > CONFIG_MEDIA_TUNER_FC0013=m
> > > CONFIG_MEDIA_TUNER_TDA18212=m
> > > CONFIG_MEDIA_TUNER_E4000=m
> > > CONFIG_MEDIA_TUNER_FC2580=m
> > > CONFIG_MEDIA_TUNER_M88RS6000T=m
> > > CONFIG_MEDIA_TUNER_TUA9001=m
> > > CONFIG_MEDIA_TUNER_SI2157=m
> > > CONFIG_MEDIA_TUNER_IT913X=m
> > > CONFIG_MEDIA_TUNER_R820T=m
> > > CONFIG_MEDIA_TUNER_MXL301RF=m
> > > CONFIG_MEDIA_TUNER_QM1D1C0042=m
> > > CONFIG_MEDIA_TUNER_QM1D1B0004=m
> > > # end of Customize TV tuners
> > > 
> > > #
> > > # Customise DVB Frontends
> > > #
> > > 
> > > #
> > > # Multistandard (satellite) frontends
> > > #
> > > CONFIG_DVB_STB0899=m
> > > CONFIG_DVB_STB6100=m
> > > CONFIG_DVB_STV090x=m
> > > CONFIG_DVB_STV0910=m
> > > CONFIG_DVB_STV6110x=m
> > > CONFIG_DVB_STV6111=m
> > > CONFIG_DVB_MXL5XX=m
> > > CONFIG_DVB_M88DS3103=m
> > > 
> > > #
> > > # Multistandard (cable + terrestrial) frontends
> > > #
> > > CONFIG_DVB_DRXK=m
> > > CONFIG_DVB_TDA18271C2DD=m
> > > CONFIG_DVB_SI2165=m
> > > CONFIG_DVB_MN88472=m
> > > CONFIG_DVB_MN88473=m
> > > 
> > > #
> > > # DVB-S (satellite) frontends
> > > #
> > > CONFIG_DVB_CX24110=m
> > > CONFIG_DVB_CX24123=m
> > > CONFIG_DVB_MT312=m
> > > CONFIG_DVB_ZL10036=m
> > > CONFIG_DVB_ZL10039=m
> > > CONFIG_DVB_S5H1420=m
> > > CONFIG_DVB_STV0288=m
> > > CONFIG_DVB_STB6000=m
> > > CONFIG_DVB_STV0299=m
> > > CONFIG_DVB_STV6110=m
> > > CONFIG_DVB_STV0900=m
> > > CONFIG_DVB_TDA8083=m
> > > CONFIG_DVB_TDA10086=m
> > > CONFIG_DVB_TDA8261=m
> > > CONFIG_DVB_VES1X93=m
> > > CONFIG_DVB_TUNER_ITD1000=m
> > > CONFIG_DVB_TUNER_CX24113=m
> > > CONFIG_DVB_TDA826X=m
> > > CONFIG_DVB_TUA6100=m
> > > CONFIG_DVB_CX24116=m
> > > CONFIG_DVB_CX24117=m
> > > CONFIG_DVB_CX24120=m
> > > CONFIG_DVB_SI21XX=m
> > > CONFIG_DVB_TS2020=m
> > > CONFIG_DVB_DS3000=m
> > > CONFIG_DVB_MB86A16=m
> > > CONFIG_DVB_TDA10071=m
> > > 
> > > #
> > > # DVB-T (terrestrial) frontends
> > > #
> > > CONFIG_DVB_SP8870=m
> > > CONFIG_DVB_SP887X=m
> > > CONFIG_DVB_CX22700=m
> > > CONFIG_DVB_CX22702=m
> > > CONFIG_DVB_S5H1432=m
> > > CONFIG_DVB_DRXD=m
> > > CONFIG_DVB_L64781=m
> > > CONFIG_DVB_TDA1004X=m
> > > CONFIG_DVB_NXT6000=m
> > > CONFIG_DVB_MT352=m
> > > CONFIG_DVB_ZL10353=m
> > > CONFIG_DVB_DIB3000MB=m
> > > CONFIG_DVB_DIB3000MC=m
> > > CONFIG_DVB_DIB7000M=m
> > > CONFIG_DVB_DIB7000P=m
> > > CONFIG_DVB_DIB9000=m
> > > CONFIG_DVB_TDA10048=m
> > > CONFIG_DVB_AF9013=m
> > > CONFIG_DVB_EC100=m
> > > CONFIG_DVB_STV0367=m
> > > CONFIG_DVB_CXD2820R=m
> > > CONFIG_DVB_CXD2841ER=m
> > > CONFIG_DVB_RTL2830=m
> > > CONFIG_DVB_RTL2832=m
> > > CONFIG_DVB_RTL2832_SDR=m
> > > CONFIG_DVB_SI2168=m
> > > CONFIG_DVB_AS102_FE=m
> > > CONFIG_DVB_ZD1301_DEMOD=m
> > > CONFIG_DVB_GP8PSK_FE=m
> > > CONFIG_DVB_CXD2880=m
> > > 
> > > #
> > > # DVB-C (cable) frontends
> > > #
> > > CONFIG_DVB_VES1820=m
> > > CONFIG_DVB_TDA10021=m
> > > CONFIG_DVB_TDA10023=m
> > > CONFIG_DVB_STV0297=m
> > > 
> > > #
> > > # ATSC (North American/Korean Terrestrial/Cable DTV) frontends
> > > #
> > > CONFIG_DVB_NXT200X=m
> > > CONFIG_DVB_OR51211=m
> > > CONFIG_DVB_OR51132=m
> > > CONFIG_DVB_BCM3510=m
> > > CONFIG_DVB_LGDT330X=m
> > > CONFIG_DVB_LGDT3305=m
> > > CONFIG_DVB_LGDT3306A=m
> > > CONFIG_DVB_LG2160=m
> > > CONFIG_DVB_S5H1409=m
> > > CONFIG_DVB_AU8522=m
> > > CONFIG_DVB_AU8522_DTV=m
> > > CONFIG_DVB_AU8522_V4L=m
> > > CONFIG_DVB_S5H1411=m
> > > 
> > > #
> > > # ISDB-T (terrestrial) frontends
> > > #
> > > CONFIG_DVB_S921=m
> > > CONFIG_DVB_DIB8000=m
> > > CONFIG_DVB_MB86A20S=m
> > > 
> > > #
> > > # ISDB-S (satellite) & ISDB-T (terrestrial) frontends
> > > #
> > > CONFIG_DVB_TC90522=m
> > > CONFIG_DVB_MN88443X=m
> > > 
> > > #
> > > # Digital terrestrial only tuners/PLL
> > > #
> > > CONFIG_DVB_PLL=m
> > > CONFIG_DVB_TUNER_DIB0070=m
> > > CONFIG_DVB_TUNER_DIB0090=m
> > > 
> > > #
> > > # SEC control devices for DVB-S
> > > #
> > > CONFIG_DVB_DRX39XYJ=m
> > > CONFIG_DVB_LNBH25=m
> > > CONFIG_DVB_LNBH29=m
> > > CONFIG_DVB_LNBP21=m
> > > CONFIG_DVB_LNBP22=m
> > > CONFIG_DVB_ISL6405=m
> > > CONFIG_DVB_ISL6421=m
> > > CONFIG_DVB_ISL6423=m
> > > CONFIG_DVB_A8293=m
> > > CONFIG_DVB_LGS8GL5=m
> > > CONFIG_DVB_LGS8GXX=m
> > > CONFIG_DVB_ATBM8830=m
> > > CONFIG_DVB_TDA665x=m
> > > CONFIG_DVB_IX2505V=m
> > > CONFIG_DVB_M88RS2000=m
> > > CONFIG_DVB_AF9033=m
> > > CONFIG_DVB_HORUS3A=m
> > > CONFIG_DVB_ASCOT2E=m
> > > CONFIG_DVB_HELENE=m
> > > 
> > > #
> > > # Common Interface (EN50221) controller drivers
> > > #
> > > CONFIG_DVB_CXD2099=m
> > > CONFIG_DVB_SP2=m
> > > 
> > > #
> > > # Tools to develop new frontends
> > > #
> > > CONFIG_DVB_DUMMY_FE=m
> > > # end of Customise DVB Frontends
> > > 
> > > #
> > > # Graphics support
> > > #
> > > CONFIG_AGP=y
> > > CONFIG_AGP_AMD64=y
> > > CONFIG_AGP_INTEL=y
> > > CONFIG_AGP_SIS=m
> > > CONFIG_AGP_VIA=y
> > > CONFIG_INTEL_GTT=y
> > > CONFIG_VGA_ARB=y
> > > CONFIG_VGA_ARB_MAX_GPUS=16
> > > CONFIG_VGA_SWITCHEROO=y
> > > CONFIG_DRM=m
> > > CONFIG_DRM_MIPI_DSI=y
> > > CONFIG_DRM_DP_AUX_CHARDEV=y
> > > # CONFIG_DRM_DEBUG_SELFTEST is not set
> > > CONFIG_DRM_KMS_HELPER=m
> > > CONFIG_DRM_KMS_FB_HELPER=y
> > > CONFIG_DRM_FBDEV_EMULATION=y
> > > CONFIG_DRM_FBDEV_OVERALLOC=100
> > > # CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
> > > CONFIG_DRM_LOAD_EDID_FIRMWARE=y
> > > CONFIG_DRM_DP_CEC=y
> > > CONFIG_DRM_TTM=m
> > > CONFIG_DRM_VRAM_HELPER=m
> > > CONFIG_DRM_GEM_CMA_HELPER=y
> > > CONFIG_DRM_KMS_CMA_HELPER=y
> > > CONFIG_DRM_GEM_SHMEM_HELPER=y
> > > CONFIG_DRM_SCHED=m
> > > 
> > > #
> > > # I2C encoder or helper chips
> > > #
> > > CONFIG_DRM_I2C_CH7006=m
> > > CONFIG_DRM_I2C_SIL164=m
> > > CONFIG_DRM_I2C_NXP_TDA998X=m
> > > CONFIG_DRM_I2C_NXP_TDA9950=m
> > > # end of I2C encoder or helper chips
> > > 
> > > #
> > > # ARM devices
> > > #
> > > # end of ARM devices
> > > 
> > > CONFIG_DRM_RADEON=m
> > > # CONFIG_DRM_RADEON_USERPTR is not set
> > > CONFIG_DRM_AMDGPU=m
> > > CONFIG_DRM_AMDGPU_SI=y
> > > CONFIG_DRM_AMDGPU_CIK=y
> > > CONFIG_DRM_AMDGPU_USERPTR=y
> > > # CONFIG_DRM_AMDGPU_GART_DEBUGFS is not set
> > > 
> > > #
> > > # ACP (Audio CoProcessor) Configuration
> > > #
> > > CONFIG_DRM_AMD_ACP=y
> > > # end of ACP (Audio CoProcessor) Configuration
> > > 
> > > #
> > > # Display Engine Configuration
> > > #
> > > CONFIG_DRM_AMD_DC=y
> > > CONFIG_DRM_AMD_DC_DCN1_0=y
> > > CONFIG_DRM_AMD_DC_DCN2_0=y
> > > CONFIG_DRM_AMD_DC_DSC_SUPPORT=y
> > > # CONFIG_DEBUG_KERNEL_DC is not set
> > > # end of Display Engine Configuration
> > > 
> > > CONFIG_HSA_AMD=y
> > > CONFIG_DRM_NOUVEAU=m
> > > # CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT is not set
> > > CONFIG_NOUVEAU_DEBUG=5
> > > CONFIG_NOUVEAU_DEBUG_DEFAULT=3
> > > # CONFIG_NOUVEAU_DEBUG_MMU is not set
> > > CONFIG_DRM_NOUVEAU_BACKLIGHT=y
> > > # CONFIG_DRM_NOUVEAU_SVM is not set
> > > CONFIG_DRM_I915=m
> > > # CONFIG_DRM_I915_ALPHA_SUPPORT is not set
> > > CONFIG_DRM_I915_FORCE_PROBE=""
> > > CONFIG_DRM_I915_CAPTURE_ERROR=y
> > > CONFIG_DRM_I915_COMPRESS_ERROR=y
> > > CONFIG_DRM_I915_USERPTR=y
> > > CONFIG_DRM_I915_GVT=y
> > > CONFIG_DRM_I915_GVT_KVMGT=m
> > > 
> > > #
> > > # drm/i915 Debugging
> > > #
> > > # CONFIG_DRM_I915_WERROR is not set
> > > # CONFIG_DRM_I915_DEBUG is not set
> > > # CONFIG_DRM_I915_DEBUG_MMIO is not set
> > > # CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
> > > # CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
> > > # CONFIG_DRM_I915_DEBUG_GUC is not set
> > > # CONFIG_DRM_I915_SELFTEST is not set
> > > # CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
> > > # CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
> > > # CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
> > > # end of drm/i915 Debugging
> > > 
> > > #
> > > # drm/i915 Profile Guided Optimisation
> > > #
> > > CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
> > > CONFIG_DRM_I915_SPIN_REQUEST=5
> > > # end of drm/i915 Profile Guided Optimisation
> > > 
> > > CONFIG_DRM_VGEM=m
> > > CONFIG_DRM_VKMS=m
> > > CONFIG_DRM_VMWGFX=m
> > > CONFIG_DRM_VMWGFX_FBCON=y
> > > CONFIG_DRM_GMA500=m
> > > CONFIG_DRM_GMA600=y
> > > CONFIG_DRM_GMA3600=y
> > > CONFIG_DRM_UDL=m
> > > CONFIG_DRM_AST=m
> > > CONFIG_DRM_MGAG200=m
> > > CONFIG_DRM_CIRRUS_QEMU=m
> > > CONFIG_DRM_QXL=m
> > > CONFIG_DRM_BOCHS=m
> > > CONFIG_DRM_VIRTIO_GPU=m
> > > CONFIG_DRM_PANEL=y
> > > 
> > > #
> > > # Display Panels
> > > #
> > > CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
> > > # end of Display Panels
> > > 
> > > CONFIG_DRM_BRIDGE=y
> > > CONFIG_DRM_PANEL_BRIDGE=y
> > > 
> > > #
> > > # Display Interface Bridges
> > > #
> > > CONFIG_DRM_ANALOGIX_ANX78XX=m
> > > # end of Display Interface Bridges
> > > 
> > > # CONFIG_DRM_ETNAVIV is not set
> > > CONFIG_DRM_TINYDRM=m
> > > CONFIG_TINYDRM_MIPI_DBI=m
> > > CONFIG_TINYDRM_HX8357D=m
> > > CONFIG_TINYDRM_ILI9225=m
> > > CONFIG_TINYDRM_ILI9341=m
> > > CONFIG_TINYDRM_MI0283QT=m
> > > CONFIG_TINYDRM_REPAPER=m
> > > CONFIG_TINYDRM_ST7586=m
> > > CONFIG_TINYDRM_ST7735R=m
> > > CONFIG_DRM_XEN=y
> > > CONFIG_DRM_XEN_FRONTEND=m
> > > CONFIG_DRM_VBOXVIDEO=m
> > > # CONFIG_DRM_LEGACY is not set
> > > CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
> > > 
> > > #
> > > # Frame buffer Devices
> > > #
> > > CONFIG_FB_CMDLINE=y
> > > CONFIG_FB_NOTIFY=y
> > > CONFIG_FB=y
> > > CONFIG_FIRMWARE_EDID=y
> > > CONFIG_FB_DDC=m
> > > CONFIG_FB_BOOT_VESA_SUPPORT=y
> > > CONFIG_FB_CFB_FILLRECT=y
> > > CONFIG_FB_CFB_COPYAREA=y
> > > CONFIG_FB_CFB_IMAGEBLIT=y
> > > CONFIG_FB_SYS_FILLRECT=m
> > > CONFIG_FB_SYS_COPYAREA=m
> > > CONFIG_FB_SYS_IMAGEBLIT=m
> > > # CONFIG_FB_FOREIGN_ENDIAN is not set
> > > CONFIG_FB_SYS_FOPS=m
> > > CONFIG_FB_DEFERRED_IO=y
> > > CONFIG_FB_HECUBA=m
> > > CONFIG_FB_SVGALIB=m
> > > CONFIG_FB_BACKLIGHT=m
> > > CONFIG_FB_MODE_HELPERS=y
> > > CONFIG_FB_TILEBLITTING=y
> > > 
> > > #
> > > # Frame buffer hardware drivers
> > > #
> > > CONFIG_FB_CIRRUS=m
> > > CONFIG_FB_PM2=m
> > > CONFIG_FB_PM2_FIFO_DISCONNECT=y
> > > CONFIG_FB_CYBER2000=m
> > > CONFIG_FB_CYBER2000_DDC=y
> > > CONFIG_FB_ARC=m
> > > CONFIG_FB_ASILIANT=y
> > > CONFIG_FB_IMSTT=y
> > > CONFIG_FB_VGA16=m
> > > CONFIG_FB_UVESA=m
> > > CONFIG_FB_VESA=y
> > > CONFIG_FB_EFI=y
> > > CONFIG_FB_N411=m
> > > CONFIG_FB_HGA=m
> > > CONFIG_FB_OPENCORES=m
> > > CONFIG_FB_S1D13XXX=m
> > > CONFIG_FB_NVIDIA=m
> > > CONFIG_FB_NVIDIA_I2C=y
> > > # CONFIG_FB_NVIDIA_DEBUG is not set
> > > CONFIG_FB_NVIDIA_BACKLIGHT=y
> > > CONFIG_FB_RIVA=m
> > > CONFIG_FB_RIVA_I2C=y
> > > # CONFIG_FB_RIVA_DEBUG is not set
> > > CONFIG_FB_RIVA_BACKLIGHT=y
> > > CONFIG_FB_I740=m
> > > CONFIG_FB_LE80578=m
> > > CONFIG_FB_CARILLO_RANCH=m
> > > CONFIG_FB_INTEL=m
> > > # CONFIG_FB_INTEL_DEBUG is not set
> > > CONFIG_FB_INTEL_I2C=y
> > > CONFIG_FB_MATROX=m
> > > CONFIG_FB_MATROX_MILLENIUM=y
> > > CONFIG_FB_MATROX_MYSTIQUE=y
> > > CONFIG_FB_MATROX_G=y
> > > CONFIG_FB_MATROX_I2C=m
> > > CONFIG_FB_MATROX_MAVEN=m
> > > CONFIG_FB_RADEON=m
> > > CONFIG_FB_RADEON_I2C=y
> > > CONFIG_FB_RADEON_BACKLIGHT=y
> > > # CONFIG_FB_RADEON_DEBUG is not set
> > > CONFIG_FB_ATY128=m
> > > CONFIG_FB_ATY128_BACKLIGHT=y
> > > CONFIG_FB_ATY=m
> > > CONFIG_FB_ATY_CT=y
> > > # CONFIG_FB_ATY_GENERIC_LCD is not set
> > > CONFIG_FB_ATY_GX=y
> > > CONFIG_FB_ATY_BACKLIGHT=y
> > > CONFIG_FB_S3=m
> > > CONFIG_FB_S3_DDC=y
> > > CONFIG_FB_SAVAGE=m
> > > CONFIG_FB_SAVAGE_I2C=y
> > > # CONFIG_FB_SAVAGE_ACCEL is not set
> > > CONFIG_FB_SIS=m
> > > CONFIG_FB_SIS_300=y
> > > CONFIG_FB_SIS_315=y
> > > CONFIG_FB_VIA=m
> > > # CONFIG_FB_VIA_DIRECT_PROCFS is not set
> > > CONFIG_FB_VIA_X_COMPATIBILITY=y
> > > CONFIG_FB_NEOMAGIC=m
> > > CONFIG_FB_KYRO=m
> > > CONFIG_FB_3DFX=m
> > > # CONFIG_FB_3DFX_ACCEL is not set
> > > # CONFIG_FB_3DFX_I2C is not set
> > > CONFIG_FB_VOODOO1=m
> > > CONFIG_FB_VT8623=m
> > > CONFIG_FB_TRIDENT=m
> > > CONFIG_FB_ARK=m
> > > CONFIG_FB_PM3=m
> > > CONFIG_FB_CARMINE=m
> > > CONFIG_FB_CARMINE_DRAM_EVAL=y
> > > # CONFIG_CARMINE_DRAM_CUSTOM is not set
> > > CONFIG_FB_SM501=m
> > > CONFIG_FB_SMSCUFX=m
> > > CONFIG_FB_UDL=m
> > > # CONFIG_FB_IBM_GXT4500 is not set
> > > # CONFIG_FB_VIRTUAL is not set
> > > CONFIG_XEN_FBDEV_FRONTEND=m
> > > CONFIG_FB_METRONOME=m
> > > CONFIG_FB_MB862XX=m
> > > CONFIG_FB_MB862XX_PCI_GDC=y
> > > CONFIG_FB_MB862XX_I2C=y
> > > CONFIG_FB_HYPERV=m
> > > CONFIG_FB_SIMPLE=y
> > > CONFIG_FB_SM712=m
> > > # end of Frame buffer Devices
> > > 
> > > #
> > > # Backlight & LCD device support
> > > #
> > > CONFIG_LCD_CLASS_DEVICE=m
> > > CONFIG_LCD_L4F00242T03=m
> > > CONFIG_LCD_LMS283GF05=m
> > > CONFIG_LCD_LTV350QV=m
> > > CONFIG_LCD_ILI922X=m
> > > CONFIG_LCD_ILI9320=m
> > > CONFIG_LCD_TDO24M=m
> > > CONFIG_LCD_VGG2432A4=m
> > > CONFIG_LCD_PLATFORM=m
> > > CONFIG_LCD_AMS369FG06=m
> > > CONFIG_LCD_LMS501KF03=m
> > > CONFIG_LCD_HX8357=m
> > > CONFIG_LCD_OTM3225A=m
> > > CONFIG_BACKLIGHT_CLASS_DEVICE=y
> > > CONFIG_BACKLIGHT_GENERIC=m
> > > CONFIG_BACKLIGHT_LM3533=m
> > > CONFIG_BACKLIGHT_CARILLO_RANCH=m
> > > CONFIG_BACKLIGHT_PWM=m
> > > CONFIG_BACKLIGHT_DA903X=m
> > > CONFIG_BACKLIGHT_DA9052=m
> > > CONFIG_BACKLIGHT_MAX8925=m
> > > CONFIG_BACKLIGHT_APPLE=m
> > > CONFIG_BACKLIGHT_PM8941_WLED=m
> > > CONFIG_BACKLIGHT_SAHARA=m
> > > CONFIG_BACKLIGHT_WM831X=m
> > > CONFIG_BACKLIGHT_ADP5520=m
> > > CONFIG_BACKLIGHT_ADP8860=m
> > > CONFIG_BACKLIGHT_ADP8870=m
> > > CONFIG_BACKLIGHT_88PM860X=m
> > > CONFIG_BACKLIGHT_PCF50633=m
> > > CONFIG_BACKLIGHT_AAT2870=m
> > > CONFIG_BACKLIGHT_LM3630A=m
> > > CONFIG_BACKLIGHT_LM3639=m
> > > CONFIG_BACKLIGHT_LP855X=m
> > > CONFIG_BACKLIGHT_LP8788=m
> > > CONFIG_BACKLIGHT_PANDORA=m
> > > CONFIG_BACKLIGHT_SKY81452=m
> > > CONFIG_BACKLIGHT_AS3711=m
> > > CONFIG_BACKLIGHT_GPIO=m
> > > CONFIG_BACKLIGHT_LV5207LP=m
> > > CONFIG_BACKLIGHT_BD6107=m
> > > CONFIG_BACKLIGHT_ARCXCNN=m
> > > CONFIG_BACKLIGHT_RAVE_SP=m
> > > # end of Backlight & LCD device support
> > > 
> > > CONFIG_VGASTATE=m
> > > CONFIG_VIDEOMODE_HELPERS=y
> > > CONFIG_HDMI=y
> > > 
> > > #
> > > # Console display driver support
> > > #
> > > CONFIG_VGA_CONSOLE=y
> > > # CONFIG_VGACON_SOFT_SCROLLBACK is not set
> > > CONFIG_DUMMY_CONSOLE=y
> > > CONFIG_DUMMY_CONSOLE_COLUMNS=80
> > > CONFIG_DUMMY_CONSOLE_ROWS=25
> > > CONFIG_FRAMEBUFFER_CONSOLE=y
> > > CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
> > > CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
> > > # CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
> > > # end of Console display driver support
> > > 
> > > # CONFIG_LOGO is not set
> > > # end of Graphics support
> > > 
> > > CONFIG_SOUND=m
> > > CONFIG_SOUND_OSS_CORE=y
> > > # CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
> > > CONFIG_SND=m
> > > CONFIG_SND_TIMER=m
> > > CONFIG_SND_PCM=m
> > > CONFIG_SND_PCM_ELD=y
> > > CONFIG_SND_PCM_IEC958=y
> > > CONFIG_SND_DMAENGINE_PCM=m
> > > CONFIG_SND_HWDEP=m
> > > CONFIG_SND_SEQ_DEVICE=m
> > > CONFIG_SND_RAWMIDI=m
> > > CONFIG_SND_COMPRESS_OFFLOAD=m
> > > CONFIG_SND_JACK=y
> > > CONFIG_SND_JACK_INPUT_DEV=y
> > > CONFIG_SND_OSSEMUL=y
> > > CONFIG_SND_MIXER_OSS=m
> > > # CONFIG_SND_PCM_OSS is not set
> > > CONFIG_SND_PCM_TIMER=y
> > > CONFIG_SND_HRTIMER=m
> > > CONFIG_SND_DYNAMIC_MINORS=y
> > > CONFIG_SND_MAX_CARDS=32
> > > CONFIG_SND_SUPPORT_OLD_API=y
> > > CONFIG_SND_PROC_FS=y
> > > CONFIG_SND_VERBOSE_PROCFS=y
> > > # CONFIG_SND_VERBOSE_PRINTK is not set
> > > # CONFIG_SND_DEBUG is not set
> > > CONFIG_SND_VMASTER=y
> > > CONFIG_SND_DMA_SGBUF=y
> > > CONFIG_SND_SEQUENCER=m
> > > CONFIG_SND_SEQ_DUMMY=m
> > > # CONFIG_SND_SEQUENCER_OSS is not set
> > > CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
> > > CONFIG_SND_SEQ_MIDI_EVENT=m
> > > CONFIG_SND_SEQ_MIDI=m
> > > CONFIG_SND_SEQ_MIDI_EMUL=m
> > > CONFIG_SND_SEQ_VIRMIDI=m
> > > CONFIG_SND_MPU401_UART=m
> > > CONFIG_SND_OPL3_LIB=m
> > > CONFIG_SND_OPL3_LIB_SEQ=m
> > > CONFIG_SND_VX_LIB=m
> > > CONFIG_SND_AC97_CODEC=m
> > > CONFIG_SND_DRIVERS=y
> > > CONFIG_SND_PCSP=m
> > > CONFIG_SND_DUMMY=m
> > > CONFIG_SND_ALOOP=m
> > > CONFIG_SND_VIRMIDI=m
> > > CONFIG_SND_MTPAV=m
> > > CONFIG_SND_MTS64=m
> > > CONFIG_SND_SERIAL_U16550=m
> > > CONFIG_SND_MPU401=m
> > > CONFIG_SND_PORTMAN2X4=m
> > > CONFIG_SND_AC97_POWER_SAVE=y
> > > CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
> > > CONFIG_SND_SB_COMMON=m
> > > CONFIG_SND_PCI=y
> > > CONFIG_SND_AD1889=m
> > > CONFIG_SND_ALS300=m
> > > CONFIG_SND_ALS4000=m
> > > CONFIG_SND_ALI5451=m
> > > CONFIG_SND_ASIHPI=m
> > > CONFIG_SND_ATIIXP=m
> > > CONFIG_SND_ATIIXP_MODEM=m
> > > CONFIG_SND_AU8810=m
> > > CONFIG_SND_AU8820=m
> > > CONFIG_SND_AU8830=m
> > > CONFIG_SND_AW2=m
> > > CONFIG_SND_AZT3328=m
> > > CONFIG_SND_BT87X=m
> > > # CONFIG_SND_BT87X_OVERCLOCK is not set
> > > CONFIG_SND_CA0106=m
> > > CONFIG_SND_CMIPCI=m
> > > CONFIG_SND_OXYGEN_LIB=m
> > > CONFIG_SND_OXYGEN=m
> > > CONFIG_SND_CS4281=m
> > > CONFIG_SND_CS46XX=m
> > > CONFIG_SND_CS46XX_NEW_DSP=y
> > > CONFIG_SND_CTXFI=m
> > > CONFIG_SND_DARLA20=m
> > > CONFIG_SND_GINA20=m
> > > CONFIG_SND_LAYLA20=m
> > > CONFIG_SND_DARLA24=m
> > > CONFIG_SND_GINA24=m
> > > CONFIG_SND_LAYLA24=m
> > > CONFIG_SND_MONA=m
> > > CONFIG_SND_MIA=m
> > > CONFIG_SND_ECHO3G=m
> > > CONFIG_SND_INDIGO=m
> > > CONFIG_SND_INDIGOIO=m
> > > CONFIG_SND_INDIGODJ=m
> > > CONFIG_SND_INDIGOIOX=m
> > > CONFIG_SND_INDIGODJX=m
> > > CONFIG_SND_EMU10K1=m
> > > CONFIG_SND_EMU10K1_SEQ=m
> > > CONFIG_SND_EMU10K1X=m
> > > CONFIG_SND_ENS1370=m
> > > CONFIG_SND_ENS1371=m
> > > CONFIG_SND_ES1938=m
> > > CONFIG_SND_ES1968=m
> > > CONFIG_SND_ES1968_INPUT=y
> > > CONFIG_SND_ES1968_RADIO=y
> > > CONFIG_SND_FM801=m
> > > CONFIG_SND_FM801_TEA575X_BOOL=y
> > > CONFIG_SND_HDSP=m
> > > CONFIG_SND_HDSPM=m
> > > CONFIG_SND_ICE1712=m
> > > CONFIG_SND_ICE1724=m
> > > CONFIG_SND_INTEL8X0=m
> > > CONFIG_SND_INTEL8X0M=m
> > > CONFIG_SND_KORG1212=m
> > > CONFIG_SND_LOLA=m
> > > CONFIG_SND_LX6464ES=m
> > > CONFIG_SND_MAESTRO3=m
> > > CONFIG_SND_MAESTRO3_INPUT=y
> > > CONFIG_SND_MIXART=m
> > > CONFIG_SND_NM256=m
> > > CONFIG_SND_PCXHR=m
> > > CONFIG_SND_RIPTIDE=m
> > > CONFIG_SND_RME32=m
> > > CONFIG_SND_RME96=m
> > > CONFIG_SND_RME9652=m
> > > CONFIG_SND_SONICVIBES=m
> > > CONFIG_SND_TRIDENT=m
> > > CONFIG_SND_VIA82XX=m
> > > CONFIG_SND_VIA82XX_MODEM=m
> > > CONFIG_SND_VIRTUOSO=m
> > > CONFIG_SND_VX222=m
> > > CONFIG_SND_YMFPCI=m
> > > 
> > > #
> > > # HD-Audio
> > > #
> > > CONFIG_SND_HDA=m
> > > CONFIG_SND_HDA_INTEL=m
> > > CONFIG_SND_HDA_HWDEP=y
> > > CONFIG_SND_HDA_RECONFIG=y
> > > CONFIG_SND_HDA_INPUT_BEEP=y
> > > CONFIG_SND_HDA_INPUT_BEEP_MODE=0
> > > CONFIG_SND_HDA_PATCH_LOADER=y
> > > CONFIG_SND_HDA_CODEC_REALTEK=m
> > > CONFIG_SND_HDA_CODEC_ANALOG=m
> > > CONFIG_SND_HDA_CODEC_SIGMATEL=m
> > > CONFIG_SND_HDA_CODEC_VIA=m
> > > CONFIG_SND_HDA_CODEC_HDMI=m
> > > CONFIG_SND_HDA_CODEC_CIRRUS=m
> > > CONFIG_SND_HDA_CODEC_CONEXANT=m
> > > CONFIG_SND_HDA_CODEC_CA0110=m
> > > CONFIG_SND_HDA_CODEC_CA0132=m
> > > CONFIG_SND_HDA_CODEC_CA0132_DSP=y
> > > CONFIG_SND_HDA_CODEC_CMEDIA=m
> > > CONFIG_SND_HDA_CODEC_SI3054=m
> > > CONFIG_SND_HDA_GENERIC=m
> > > CONFIG_SND_HDA_POWER_SAVE_DEFAULT=1
> > > # end of HD-Audio
> > > 
> > > CONFIG_SND_HDA_CORE=m
> > > CONFIG_SND_HDA_DSP_LOADER=y
> > > CONFIG_SND_HDA_COMPONENT=y
> > > CONFIG_SND_HDA_I915=y
> > > CONFIG_SND_HDA_EXT_CORE=m
> > > CONFIG_SND_HDA_PREALLOC_SIZE=64
> > > CONFIG_SND_SPI=y
> > > CONFIG_SND_USB=y
> > > CONFIG_SND_USB_AUDIO=m
> > > CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
> > > CONFIG_SND_USB_UA101=m
> > > CONFIG_SND_USB_USX2Y=m
> > > CONFIG_SND_USB_CAIAQ=m
> > > CONFIG_SND_USB_CAIAQ_INPUT=y
> > > CONFIG_SND_USB_US122L=m
> > > CONFIG_SND_USB_6FIRE=m
> > > CONFIG_SND_USB_HIFACE=m
> > > CONFIG_SND_BCD2000=m
> > > CONFIG_SND_USB_LINE6=m
> > > CONFIG_SND_USB_POD=m
> > > CONFIG_SND_USB_PODHD=m
> > > CONFIG_SND_USB_TONEPORT=m
> > > CONFIG_SND_USB_VARIAX=m
> > > CONFIG_SND_FIREWIRE=y
> > > CONFIG_SND_FIREWIRE_LIB=m
> > > CONFIG_SND_DICE=m
> > > CONFIG_SND_OXFW=m
> > > CONFIG_SND_ISIGHT=m
> > > CONFIG_SND_FIREWORKS=m
> > > CONFIG_SND_BEBOB=m
> > > CONFIG_SND_FIREWIRE_DIGI00X=m
> > > CONFIG_SND_FIREWIRE_TASCAM=m
> > > CONFIG_SND_FIREWIRE_MOTU=m
> > > CONFIG_SND_FIREFACE=m
> > > CONFIG_SND_PCMCIA=y
> > > CONFIG_SND_VXPOCKET=m
> > > CONFIG_SND_PDAUDIOCF=m
> > > CONFIG_SND_SOC=m
> > > CONFIG_SND_SOC_AC97_BUS=y
> > > CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
> > > CONFIG_SND_SOC_COMPRESS=y
> > > CONFIG_SND_SOC_TOPOLOGY=y
> > > CONFIG_SND_SOC_ACPI=m
> > > CONFIG_SND_SOC_AMD_ACP=m
> > > CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH=m
> > > CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=m
> > > CONFIG_SND_SOC_AMD_ACP3x=m
> > > CONFIG_SND_ATMEL_SOC=m
> > > CONFIG_SND_DESIGNWARE_I2S=m
> > > CONFIG_SND_DESIGNWARE_PCM=y
> > > 
> > > #
> > > # SoC Audio for Freescale CPUs
> > > #
> > > 
> > > #
> > > # Common SoC Audio options for Freescale CPUs:
> > > #
> > > CONFIG_SND_SOC_FSL_ASRC=m
> > > CONFIG_SND_SOC_FSL_SAI=m
> > > CONFIG_SND_SOC_FSL_AUDMIX=m
> > > CONFIG_SND_SOC_FSL_SSI=m
> > > CONFIG_SND_SOC_FSL_SPDIF=m
> > > CONFIG_SND_SOC_FSL_ESAI=m
> > > CONFIG_SND_SOC_FSL_MICFIL=m
> > > CONFIG_SND_SOC_IMX_AUDMUX=m
> > > # end of SoC Audio for Freescale CPUs
> > > 
> > > CONFIG_SND_I2S_HI6210_I2S=m
> > > CONFIG_SND_SOC_IMG=y
> > > CONFIG_SND_SOC_IMG_I2S_IN=m
> > > CONFIG_SND_SOC_IMG_I2S_OUT=m
> > > CONFIG_SND_SOC_IMG_PARALLEL_OUT=m
> > > CONFIG_SND_SOC_IMG_SPDIF_IN=m
> > > CONFIG_SND_SOC_IMG_SPDIF_OUT=m
> > > CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=m
> > > CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
> > > CONFIG_SND_SST_IPC=m
> > > CONFIG_SND_SST_IPC_PCI=m
> > > CONFIG_SND_SST_IPC_ACPI=m
> > > CONFIG_SND_SOC_INTEL_SST_ACPI=m
> > > CONFIG_SND_SOC_INTEL_SST=m
> > > CONFIG_SND_SOC_INTEL_SST_FIRMWARE=m
> > > CONFIG_SND_SOC_INTEL_HASWELL=m
> > > CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
> > > CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI=m
> > > CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
> > > CONFIG_SND_SOC_INTEL_SKYLAKE=m
> > > CONFIG_SND_SOC_INTEL_SKL=m
> > > CONFIG_SND_SOC_INTEL_APL=m
> > > CONFIG_SND_SOC_INTEL_KBL=m
> > > CONFIG_SND_SOC_INTEL_GLK=m
> > > CONFIG_SND_SOC_INTEL_CNL=m
> > > CONFIG_SND_SOC_INTEL_CFL=m
> > > CONFIG_SND_SOC_INTEL_CML_H=m
> > > CONFIG_SND_SOC_INTEL_CML_LP=m
> > > CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
> > > CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
> > > CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC=y
> > > CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
> > > CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
> > > CONFIG_SND_SOC_INTEL_MACH=y
> > > CONFIG_SND_SOC_INTEL_HASWELL_MACH=m
> > > CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=m
> > > CONFIG_SND_SOC_INTEL_BROADWELL_MACH=m
> > > CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
> > > CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
> > > CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
> > > CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
> > > CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
> > > CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH=m
> > > CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH=m
> > > CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
> > > CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
> > > # CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH is not set
> > > CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
> > > CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
> > > CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
> > > CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
> > > CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
> > > CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
> > > CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
> > > CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH=m
> > > CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH=m
> > > CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH=m
> > > CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH=m
> > > CONFIG_SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=m
> > > CONFIG_SND_SOC_INTEL_SOF_RT5682_MACH=m
> > > CONFIG_SND_SOC_MTK_BTCVSD=m
> > > CONFIG_SND_SOC_SOF_TOPLEVEL=y
> > > CONFIG_SND_SOC_SOF_PCI=m
> > > CONFIG_SND_SOC_SOF_ACPI=m
> > > CONFIG_SND_SOC_SOF_OPTIONS=m
> > > # CONFIG_SND_SOC_SOF_NOCODEC_SUPPORT is not set
> > > # CONFIG_SND_SOC_SOF_STRICT_ABI_CHECKS is not set
> > > # CONFIG_SND_SOC_SOF_DEBUG is not set
> > > CONFIG_SND_SOC_SOF=m
> > > CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE=y
> > > CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=y
> > > CONFIG_SND_SOC_SOF_INTEL_ACPI=m
> > > CONFIG_SND_SOC_SOF_INTEL_PCI=m
> > > CONFIG_SND_SOC_SOF_INTEL_HIFI_EP_IPC=m
> > > CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP=m
> > > CONFIG_SND_SOC_SOF_INTEL_COMMON=m
> > > CONFIG_SND_SOC_SOF_BAYTRAIL_SUPPORT=y
> > > CONFIG_SND_SOC_SOF_BAYTRAIL=m
> > > CONFIG_SND_SOC_SOF_BROADWELL_SUPPORT=y
> > > CONFIG_SND_SOC_SOF_BROADWELL=m
> > > CONFIG_SND_SOC_SOF_MERRIFIELD_SUPPORT=y
> > > CONFIG_SND_SOC_SOF_MERRIFIELD=m
> > > CONFIG_SND_SOC_SOF_APOLLOLAKE_SUPPORT=y
> > > CONFIG_SND_SOC_SOF_APOLLOLAKE=m
> > > CONFIG_SND_SOC_SOF_GEMINILAKE_SUPPORT=y
> > > CONFIG_SND_SOC_SOF_GEMINILAKE=m
> > > CONFIG_SND_SOC_SOF_CANNONLAKE_SUPPORT=y
> > > CONFIG_SND_SOC_SOF_CANNONLAKE=m
> > > CONFIG_SND_SOC_SOF_COFFEELAKE_SUPPORT=y
> > > CONFIG_SND_SOC_SOF_COFFEELAKE=m
> > > CONFIG_SND_SOC_SOF_ICELAKE_SUPPORT=y
> > > CONFIG_SND_SOC_SOF_ICELAKE=m
> > > CONFIG_SND_SOC_SOF_COMETLAKE_LP=m
> > > CONFIG_SND_SOC_SOF_COMETLAKE_LP_SUPPORT=y
> > > CONFIG_SND_SOC_SOF_COMETLAKE_H=m
> > > CONFIG_SND_SOC_SOF_COMETLAKE_H_SUPPORT=y
> > > CONFIG_SND_SOC_SOF_HDA_COMMON=m
> > > CONFIG_SND_SOC_SOF_HDA_LINK=y
> > > CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC=y
> > > CONFIG_SND_SOC_SOF_HDA_LINK_BASELINE=m
> > > CONFIG_SND_SOC_SOF_HDA=m
> > > CONFIG_SND_SOC_SOF_XTENSA=m
> > > 
> > > #
> > > # STMicroelectronics STM32 SOC audio support
> > > #
> > > # end of STMicroelectronics STM32 SOC audio support
> > > 
> > > CONFIG_SND_SOC_XILINX_I2S=m
> > > CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=m
> > > CONFIG_SND_SOC_XILINX_SPDIF=m
> > > CONFIG_SND_SOC_XTFPGA_I2S=m
> > > CONFIG_ZX_TDM=m
> > > CONFIG_SND_SOC_I2C_AND_SPI=m
> > > 
> > > #
> > > # CODEC drivers
> > > #
> > > CONFIG_SND_SOC_AC97_CODEC=m
> > > CONFIG_SND_SOC_ADAU_UTILS=m
> > > CONFIG_SND_SOC_ADAU1701=m
> > > CONFIG_SND_SOC_ADAU17X1=m
> > > CONFIG_SND_SOC_ADAU1761=m
> > > CONFIG_SND_SOC_ADAU1761_I2C=m
> > > CONFIG_SND_SOC_ADAU1761_SPI=m
> > > CONFIG_SND_SOC_ADAU7002=m
> > > CONFIG_SND_SOC_AK4104=m
> > > CONFIG_SND_SOC_AK4118=m
> > > CONFIG_SND_SOC_AK4458=m
> > > CONFIG_SND_SOC_AK4554=m
> > > CONFIG_SND_SOC_AK4613=m
> > > CONFIG_SND_SOC_AK4642=m
> > > CONFIG_SND_SOC_AK5386=m
> > > CONFIG_SND_SOC_AK5558=m
> > > CONFIG_SND_SOC_ALC5623=m
> > > CONFIG_SND_SOC_BD28623=m
> > > CONFIG_SND_SOC_BT_SCO=m
> > > CONFIG_SND_SOC_CROS_EC_CODEC=m
> > > CONFIG_SND_SOC_CS35L32=m
> > > CONFIG_SND_SOC_CS35L33=m
> > > CONFIG_SND_SOC_CS35L34=m
> > > CONFIG_SND_SOC_CS35L35=m
> > > CONFIG_SND_SOC_CS35L36=m
> > > CONFIG_SND_SOC_CS42L42=m
> > > CONFIG_SND_SOC_CS42L51=m
> > > CONFIG_SND_SOC_CS42L51_I2C=m
> > > CONFIG_SND_SOC_CS42L52=m
> > > CONFIG_SND_SOC_CS42L56=m
> > > CONFIG_SND_SOC_CS42L73=m
> > > CONFIG_SND_SOC_CS4265=m
> > > CONFIG_SND_SOC_CS4270=m
> > > CONFIG_SND_SOC_CS4271=m
> > > CONFIG_SND_SOC_CS4271_I2C=m
> > > CONFIG_SND_SOC_CS4271_SPI=m
> > > CONFIG_SND_SOC_CS42XX8=m
> > > CONFIG_SND_SOC_CS42XX8_I2C=m
> > > CONFIG_SND_SOC_CS43130=m
> > > CONFIG_SND_SOC_CS4341=m
> > > CONFIG_SND_SOC_CS4349=m
> > > CONFIG_SND_SOC_CS53L30=m
> > > CONFIG_SND_SOC_CX2072X=m
> > > CONFIG_SND_SOC_DA7213=m
> > > CONFIG_SND_SOC_DA7219=m
> > > CONFIG_SND_SOC_DMIC=m
> > > CONFIG_SND_SOC_HDMI_CODEC=m
> > > CONFIG_SND_SOC_ES7134=m
> > > CONFIG_SND_SOC_ES7241=m
> > > CONFIG_SND_SOC_ES8316=m
> > > CONFIG_SND_SOC_ES8328=m
> > > CONFIG_SND_SOC_ES8328_I2C=m
> > > CONFIG_SND_SOC_ES8328_SPI=m
> > > CONFIG_SND_SOC_GTM601=m
> > > CONFIG_SND_SOC_HDAC_HDMI=m
> > > CONFIG_SND_SOC_HDAC_HDA=m
> > > CONFIG_SND_SOC_INNO_RK3036=m
> > > CONFIG_SND_SOC_MAX98088=m
> > > CONFIG_SND_SOC_MAX98090=m
> > > CONFIG_SND_SOC_MAX98357A=m
> > > CONFIG_SND_SOC_MAX98504=m
> > > CONFIG_SND_SOC_MAX9867=m
> > > CONFIG_SND_SOC_MAX98927=m
> > > CONFIG_SND_SOC_MAX98373=m
> > > CONFIG_SND_SOC_MAX9860=m
> > > CONFIG_SND_SOC_MSM8916_WCD_ANALOG=m
> > > CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
> > > CONFIG_SND_SOC_PCM1681=m
> > > CONFIG_SND_SOC_PCM1789=m
> > > CONFIG_SND_SOC_PCM1789_I2C=m
> > > CONFIG_SND_SOC_PCM179X=m
> > > CONFIG_SND_SOC_PCM179X_I2C=m
> > > CONFIG_SND_SOC_PCM179X_SPI=m
> > > CONFIG_SND_SOC_PCM186X=m
> > > CONFIG_SND_SOC_PCM186X_I2C=m
> > > CONFIG_SND_SOC_PCM186X_SPI=m
> > > CONFIG_SND_SOC_PCM3060=m
> > > CONFIG_SND_SOC_PCM3060_I2C=m
> > > CONFIG_SND_SOC_PCM3060_SPI=m
> > > CONFIG_SND_SOC_PCM3168A=m
> > > CONFIG_SND_SOC_PCM3168A_I2C=m
> > > CONFIG_SND_SOC_PCM3168A_SPI=m
> > > CONFIG_SND_SOC_PCM512x=m
> > > CONFIG_SND_SOC_PCM512x_I2C=m
> > > CONFIG_SND_SOC_PCM512x_SPI=m
> > > CONFIG_SND_SOC_RK3328=m
> > > CONFIG_SND_SOC_RL6231=m
> > > CONFIG_SND_SOC_RL6347A=m
> > > CONFIG_SND_SOC_RT286=m
> > > CONFIG_SND_SOC_RT298=m
> > > CONFIG_SND_SOC_RT5514=m
> > > CONFIG_SND_SOC_RT5514_SPI=m
> > > CONFIG_SND_SOC_RT5616=m
> > > CONFIG_SND_SOC_RT5631=m
> > > CONFIG_SND_SOC_RT5640=m
> > > CONFIG_SND_SOC_RT5645=m
> > > CONFIG_SND_SOC_RT5651=m
> > > CONFIG_SND_SOC_RT5660=m
> > > CONFIG_SND_SOC_RT5663=m
> > > CONFIG_SND_SOC_RT5670=m
> > > CONFIG_SND_SOC_RT5677=m
> > > CONFIG_SND_SOC_RT5677_SPI=m
> > > CONFIG_SND_SOC_RT5682=m
> > > CONFIG_SND_SOC_SGTL5000=m
> > > CONFIG_SND_SOC_SI476X=m
> > > CONFIG_SND_SOC_SIGMADSP=m
> > > CONFIG_SND_SOC_SIGMADSP_I2C=m
> > > CONFIG_SND_SOC_SIGMADSP_REGMAP=m
> > > CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
> > > CONFIG_SND_SOC_SIRF_AUDIO_CODEC=m
> > > CONFIG_SND_SOC_SPDIF=m
> > > CONFIG_SND_SOC_SSM2305=m
> > > CONFIG_SND_SOC_SSM2602=m
> > > CONFIG_SND_SOC_SSM2602_SPI=m
> > > CONFIG_SND_SOC_SSM2602_I2C=m
> > > CONFIG_SND_SOC_SSM4567=m
> > > CONFIG_SND_SOC_STA32X=m
> > > CONFIG_SND_SOC_STA350=m
> > > CONFIG_SND_SOC_STI_SAS=m
> > > CONFIG_SND_SOC_TAS2552=m
> > > CONFIG_SND_SOC_TAS5086=m
> > > CONFIG_SND_SOC_TAS571X=m
> > > CONFIG_SND_SOC_TAS5720=m
> > > CONFIG_SND_SOC_TAS6424=m
> > > CONFIG_SND_SOC_TDA7419=m
> > > CONFIG_SND_SOC_TFA9879=m
> > > CONFIG_SND_SOC_TLV320AIC23=m
> > > CONFIG_SND_SOC_TLV320AIC23_I2C=m
> > > CONFIG_SND_SOC_TLV320AIC23_SPI=m
> > > CONFIG_SND_SOC_TLV320AIC31XX=m
> > > CONFIG_SND_SOC_TLV320AIC32X4=m
> > > CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
> > > CONFIG_SND_SOC_TLV320AIC32X4_SPI=m
> > > CONFIG_SND_SOC_TLV320AIC3X=m
> > > CONFIG_SND_SOC_TS3A227E=m
> > > CONFIG_SND_SOC_TSCS42XX=m
> > > CONFIG_SND_SOC_TSCS454=m
> > > CONFIG_SND_SOC_WCD9335=m
> > > CONFIG_SND_SOC_WM8510=m
> > > CONFIG_SND_SOC_WM8523=m
> > > CONFIG_SND_SOC_WM8524=m
> > > CONFIG_SND_SOC_WM8580=m
> > > CONFIG_SND_SOC_WM8711=m
> > > CONFIG_SND_SOC_WM8728=m
> > > CONFIG_SND_SOC_WM8731=m
> > > CONFIG_SND_SOC_WM8737=m
> > > CONFIG_SND_SOC_WM8741=m
> > > CONFIG_SND_SOC_WM8750=m
> > > CONFIG_SND_SOC_WM8753=m
> > > CONFIG_SND_SOC_WM8770=m
> > > CONFIG_SND_SOC_WM8776=m
> > > CONFIG_SND_SOC_WM8782=m
> > > CONFIG_SND_SOC_WM8804=m
> > > CONFIG_SND_SOC_WM8804_I2C=m
> > > CONFIG_SND_SOC_WM8804_SPI=m
> > > CONFIG_SND_SOC_WM8903=m
> > > CONFIG_SND_SOC_WM8904=m
> > > CONFIG_SND_SOC_WM8960=m
> > > CONFIG_SND_SOC_WM8962=m
> > > CONFIG_SND_SOC_WM8974=m
> > > CONFIG_SND_SOC_WM8978=m
> > > CONFIG_SND_SOC_WM8985=m
> > > CONFIG_SND_SOC_ZX_AUD96P22=m
> > > CONFIG_SND_SOC_MAX9759=m
> > > CONFIG_SND_SOC_MT6351=m
> > > CONFIG_SND_SOC_MT6358=m
> > > CONFIG_SND_SOC_NAU8540=m
> > > CONFIG_SND_SOC_NAU8810=m
> > > CONFIG_SND_SOC_NAU8822=m
> > > CONFIG_SND_SOC_NAU8824=m
> > > CONFIG_SND_SOC_NAU8825=m
> > > CONFIG_SND_SOC_TPA6130A2=m
> > > # end of CODEC drivers
> > > 
> > > CONFIG_SND_SIMPLE_CARD_UTILS=m
> > > CONFIG_SND_SIMPLE_CARD=m
> > > CONFIG_SND_X86=y
> > > CONFIG_HDMI_LPE_AUDIO=m
> > > CONFIG_SND_SYNTH_EMUX=m
> > > CONFIG_SND_XEN_FRONTEND=m
> > > CONFIG_AC97_BUS=m
> > > 
> > > #
> > > # HID support
> > > #
> > > CONFIG_HID=m
> > > CONFIG_HID_BATTERY_STRENGTH=y
> > > CONFIG_HIDRAW=y
> > > CONFIG_UHID=m
> > > CONFIG_HID_GENERIC=m
> > > 
> > > #
> > > # Special HID drivers
> > > #
> > > CONFIG_HID_A4TECH=m
> > > CONFIG_HID_ACCUTOUCH=m
> > > CONFIG_HID_ACRUX=m
> > > CONFIG_HID_ACRUX_FF=y
> > > CONFIG_HID_APPLE=m
> > > CONFIG_HID_APPLEIR=m
> > > CONFIG_HID_ASUS=m
> > > CONFIG_HID_AUREAL=m
> > > CONFIG_HID_BELKIN=m
> > > CONFIG_HID_BETOP_FF=m
> > > CONFIG_HID_BIGBEN_FF=m
> > > CONFIG_HID_CHERRY=m
> > > CONFIG_HID_CHICONY=m
> > > CONFIG_HID_CORSAIR=m
> > > CONFIG_HID_COUGAR=m
> > > CONFIG_HID_MACALLY=m
> > > CONFIG_HID_PRODIKEYS=m
> > > CONFIG_HID_CMEDIA=m
> > > CONFIG_HID_CP2112=m
> > > CONFIG_HID_CYPRESS=m
> > > CONFIG_HID_DRAGONRISE=m
> > > CONFIG_DRAGONRISE_FF=y
> > > CONFIG_HID_EMS_FF=m
> > > CONFIG_HID_ELAN=m
> > > CONFIG_HID_ELECOM=m
> > > CONFIG_HID_ELO=m
> > > CONFIG_HID_EZKEY=m
> > > CONFIG_HID_GEMBIRD=m
> > > CONFIG_HID_GFRM=m
> > > CONFIG_HID_HOLTEK=m
> > > CONFIG_HOLTEK_FF=y
> > > CONFIG_HID_GOOGLE_HAMMER=m
> > > CONFIG_HID_GT683R=m
> > > CONFIG_HID_KEYTOUCH=m
> > > CONFIG_HID_KYE=m
> > > CONFIG_HID_UCLOGIC=m
> > > CONFIG_HID_WALTOP=m
> > > CONFIG_HID_VIEWSONIC=m
> > > CONFIG_HID_GYRATION=m
> > > CONFIG_HID_ICADE=m
> > > CONFIG_HID_ITE=m
> > > CONFIG_HID_JABRA=m
> > > CONFIG_HID_TWINHAN=m
> > > CONFIG_HID_KENSINGTON=m
> > > CONFIG_HID_LCPOWER=m
> > > CONFIG_HID_LED=m
> > > CONFIG_HID_LENOVO=m
> > > CONFIG_HID_LOGITECH=m
> > > CONFIG_HID_LOGITECH_DJ=m
> > > CONFIG_HID_LOGITECH_HIDPP=m
> > > CONFIG_LOGITECH_FF=y
> > > CONFIG_LOGIRUMBLEPAD2_FF=y
> > > CONFIG_LOGIG940_FF=y
> > > CONFIG_LOGIWHEELS_FF=y
> > > CONFIG_HID_MAGICMOUSE=m
> > > CONFIG_HID_MALTRON=m
> > > CONFIG_HID_MAYFLASH=m
> > > CONFIG_HID_REDRAGON=m
> > > CONFIG_HID_MICROSOFT=m
> > > CONFIG_HID_MONTEREY=m
> > > CONFIG_HID_MULTITOUCH=m
> > > CONFIG_HID_NTI=m
> > > CONFIG_HID_NTRIG=m
> > > CONFIG_HID_ORTEK=m
> > > CONFIG_HID_PANTHERLORD=m
> > > CONFIG_PANTHERLORD_FF=y
> > > CONFIG_HID_PENMOUNT=m
> > > CONFIG_HID_PETALYNX=m
> > > CONFIG_HID_PICOLCD=m
> > > CONFIG_HID_PICOLCD_FB=y
> > > CONFIG_HID_PICOLCD_BACKLIGHT=y
> > > CONFIG_HID_PICOLCD_LCD=y
> > > CONFIG_HID_PICOLCD_LEDS=y
> > > CONFIG_HID_PICOLCD_CIR=y
> > > CONFIG_HID_PLANTRONICS=m
> > > CONFIG_HID_PRIMAX=m
> > > CONFIG_HID_RETRODE=m
> > > CONFIG_HID_ROCCAT=m
> > > CONFIG_HID_SAITEK=m
> > > CONFIG_HID_SAMSUNG=m
> > > CONFIG_HID_SONY=m
> > > CONFIG_SONY_FF=y
> > > CONFIG_HID_SPEEDLINK=m
> > > CONFIG_HID_STEAM=m
> > > CONFIG_HID_STEELSERIES=m
> > > CONFIG_HID_SUNPLUS=m
> > > CONFIG_HID_RMI=m
> > > CONFIG_HID_GREENASIA=m
> > > CONFIG_GREENASIA_FF=y
> > > CONFIG_HID_HYPERV_MOUSE=m
> > > CONFIG_HID_SMARTJOYPLUS=m
> > > CONFIG_SMARTJOYPLUS_FF=y
> > > CONFIG_HID_TIVO=m
> > > CONFIG_HID_TOPSEED=m
> > > CONFIG_HID_THINGM=m
> > > CONFIG_HID_THRUSTMASTER=m
> > > CONFIG_THRUSTMASTER_FF=y
> > > CONFIG_HID_UDRAW_PS3=m
> > > CONFIG_HID_U2FZERO=m
> > > CONFIG_HID_WACOM=m
> > > CONFIG_HID_WIIMOTE=m
> > > CONFIG_HID_XINMO=m
> > > CONFIG_HID_ZEROPLUS=m
> > > CONFIG_ZEROPLUS_FF=y
> > > CONFIG_HID_ZYDACRON=m
> > > CONFIG_HID_SENSOR_HUB=m
> > > CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
> > > CONFIG_HID_ALPS=m
> > > # end of Special HID drivers
> > > 
> > > #
> > > # USB HID support
> > > #
> > > CONFIG_USB_HID=m
> > > CONFIG_HID_PID=y
> > > CONFIG_USB_HIDDEV=y
> > > 
> > > #
> > > # USB HID Boot Protocol drivers
> > > #
> > > CONFIG_USB_KBD=m
> > > CONFIG_USB_MOUSE=m
> > > # end of USB HID Boot Protocol drivers
> > > # end of USB HID support
> > > 
> > > #
> > > # I2C HID support
> > > #
> > > CONFIG_I2C_HID=m
> > > # end of I2C HID support
> > > 
> > > #
> > > # Intel ISH HID support
> > > #
> > > CONFIG_INTEL_ISH_HID=m
> > > CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER=m
> > > # end of Intel ISH HID support
> > > # end of HID support
> > > 
> > > CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> > > CONFIG_USB_SUPPORT=y
> > > CONFIG_USB_COMMON=y
> > > CONFIG_USB_ARCH_HAS_HCD=y
> > > CONFIG_USB=y
> > > CONFIG_USB_PCI=y
> > > CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> > > 
> > > #
> > > # Miscellaneous USB options
> > > #
> > > CONFIG_USB_DEFAULT_PERSIST=y
> > > CONFIG_USB_DYNAMIC_MINORS=y
> > > # CONFIG_USB_OTG is not set
> > > # CONFIG_USB_OTG_WHITELIST is not set
> > > # CONFIG_USB_OTG_BLACKLIST_HUB is not set
> > > CONFIG_USB_LEDS_TRIGGER_USBPORT=m
> > > CONFIG_USB_AUTOSUSPEND_DELAY=2
> > > CONFIG_USB_MON=m
> > > CONFIG_USB_WUSB=m
> > > CONFIG_USB_WUSB_CBAF=m
> > > # CONFIG_USB_WUSB_CBAF_DEBUG is not set
> > > 
> > > #
> > > # USB Host Controller Drivers
> > > #
> > > CONFIG_USB_C67X00_HCD=m
> > > CONFIG_USB_XHCI_HCD=y
> > > CONFIG_USB_XHCI_DBGCAP=y
> > > CONFIG_USB_XHCI_PCI=y
> > > CONFIG_USB_XHCI_PLATFORM=m
> > > CONFIG_USB_EHCI_HCD=y
> > > CONFIG_USB_EHCI_ROOT_HUB_TT=y
> > > CONFIG_USB_EHCI_TT_NEWSCHED=y
> > > CONFIG_USB_EHCI_PCI=y
> > > CONFIG_USB_EHCI_FSL=m
> > > CONFIG_USB_EHCI_HCD_PLATFORM=y
> > > CONFIG_USB_OXU210HP_HCD=m
> > > CONFIG_USB_ISP116X_HCD=m
> > > CONFIG_USB_FOTG210_HCD=m
> > > CONFIG_USB_MAX3421_HCD=m
> > > CONFIG_USB_OHCI_HCD=y
> > > CONFIG_USB_OHCI_HCD_PCI=y
> > > CONFIG_USB_OHCI_HCD_PLATFORM=y
> > > CONFIG_USB_UHCI_HCD=y
> > > CONFIG_USB_U132_HCD=m
> > > CONFIG_USB_SL811_HCD=m
> > > CONFIG_USB_SL811_HCD_ISO=y
> > > CONFIG_USB_SL811_CS=m
> > > CONFIG_USB_R8A66597_HCD=m
> > > CONFIG_USB_WHCI_HCD=m
> > > CONFIG_USB_HWA_HCD=m
> > > CONFIG_USB_HCD_BCMA=m
> > > CONFIG_USB_HCD_SSB=m
> > > # CONFIG_USB_HCD_TEST_MODE is not set
> > > 
> > > #
> > > # USB Device Class drivers
> > > #
> > > CONFIG_USB_ACM=m
> > > CONFIG_USB_PRINTER=m
> > > CONFIG_USB_WDM=m
> > > CONFIG_USB_TMC=m
> > > 
> > > #
> > > # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> > > #
> > > 
> > > #
> > > # also be needed; see USB_STORAGE Help for more info
> > > #
> > > CONFIG_USB_STORAGE=m
> > > # CONFIG_USB_STORAGE_DEBUG is not set
> > > CONFIG_USB_STORAGE_REALTEK=m
> > > CONFIG_REALTEK_AUTOPM=y
> > > CONFIG_USB_STORAGE_DATAFAB=m
> > > CONFIG_USB_STORAGE_FREECOM=m
> > > CONFIG_USB_STORAGE_ISD200=m
> > > CONFIG_USB_STORAGE_USBAT=m
> > > CONFIG_USB_STORAGE_SDDR09=m
> > > CONFIG_USB_STORAGE_SDDR55=m
> > > CONFIG_USB_STORAGE_JUMPSHOT=m
> > > CONFIG_USB_STORAGE_ALAUDA=m
> > > CONFIG_USB_STORAGE_ONETOUCH=m
> > > CONFIG_USB_STORAGE_KARMA=m
> > > CONFIG_USB_STORAGE_CYPRESS_ATACB=m
> > > CONFIG_USB_STORAGE_ENE_UB6250=m
> > > CONFIG_USB_UAS=m
> > > 
> > > #
> > > # USB Imaging devices
> > > #
> > > CONFIG_USB_MDC800=m
> > > CONFIG_USB_MICROTEK=m
> > > CONFIG_USBIP_CORE=m
> > > CONFIG_USBIP_VHCI_HCD=m
> > > CONFIG_USBIP_VHCI_HC_PORTS=8
> > > CONFIG_USBIP_VHCI_NR_HCS=1
> > > CONFIG_USBIP_HOST=m
> > > CONFIG_USBIP_VUDC=m
> > > # CONFIG_USBIP_DEBUG is not set
> > > CONFIG_USB_MUSB_HDRC=m
> > > # CONFIG_USB_MUSB_HOST is not set
> > > # CONFIG_USB_MUSB_GADGET is not set
> > > CONFIG_USB_MUSB_DUAL_ROLE=y
> > > 
> > > #
> > > # Platform Glue Layer
> > > #
> > > 
> > > #
> > > # MUSB DMA mode
> > > #
> > > CONFIG_MUSB_PIO_ONLY=y
> > > CONFIG_USB_DWC3=m
> > > CONFIG_USB_DWC3_ULPI=y
> > > # CONFIG_USB_DWC3_HOST is not set
> > > # CONFIG_USB_DWC3_GADGET is not set
> > > CONFIG_USB_DWC3_DUAL_ROLE=y
> > > 
> > > #
> > > # Platform Glue Driver Support
> > > #
> > > CONFIG_USB_DWC3_PCI=m
> > > CONFIG_USB_DWC3_HAPS=m
> > > CONFIG_USB_DWC2=y
> > > CONFIG_USB_DWC2_HOST=y
> > > 
> > > #
> > > # Gadget/Dual-role mode requires USB Gadget support to be enabled
> > > #
> > > CONFIG_USB_DWC2_PCI=m
> > > # CONFIG_USB_DWC2_DEBUG is not set
> > > # CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
> > > CONFIG_USB_CHIPIDEA=m
> > > CONFIG_USB_CHIPIDEA_PCI=m
> > > CONFIG_USB_CHIPIDEA_UDC=y
> > > CONFIG_USB_CHIPIDEA_HOST=y
> > > CONFIG_USB_ISP1760=m
> > > CONFIG_USB_ISP1760_HCD=y
> > > CONFIG_USB_ISP1761_UDC=y
> > > # CONFIG_USB_ISP1760_HOST_ROLE is not set
> > > # CONFIG_USB_ISP1760_GADGET_ROLE is not set
> > > CONFIG_USB_ISP1760_DUAL_ROLE=y
> > > 
> > > #
> > > # USB port drivers
> > > #
> > > CONFIG_USB_USS720=m
> > > CONFIG_USB_SERIAL=m
> > > CONFIG_USB_SERIAL_GENERIC=y
> > > CONFIG_USB_SERIAL_SIMPLE=m
> > > CONFIG_USB_SERIAL_AIRCABLE=m
> > > CONFIG_USB_SERIAL_ARK3116=m
> > > CONFIG_USB_SERIAL_BELKIN=m
> > > CONFIG_USB_SERIAL_CH341=m
> > > CONFIG_USB_SERIAL_WHITEHEAT=m
> > > CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
> > > CONFIG_USB_SERIAL_CP210X=m
> > > CONFIG_USB_SERIAL_CYPRESS_M8=m
> > > CONFIG_USB_SERIAL_EMPEG=m
> > > CONFIG_USB_SERIAL_FTDI_SIO=m
> > > CONFIG_USB_SERIAL_VISOR=m
> > > CONFIG_USB_SERIAL_IPAQ=m
> > > CONFIG_USB_SERIAL_IR=m
> > > CONFIG_USB_SERIAL_EDGEPORT=m
> > > CONFIG_USB_SERIAL_EDGEPORT_TI=m
> > > CONFIG_USB_SERIAL_F81232=m
> > > CONFIG_USB_SERIAL_F8153X=m
> > > CONFIG_USB_SERIAL_GARMIN=m
> > > CONFIG_USB_SERIAL_IPW=m
> > > CONFIG_USB_SERIAL_IUU=m
> > > CONFIG_USB_SERIAL_KEYSPAN_PDA=m
> > > CONFIG_USB_SERIAL_KEYSPAN=m
> > > CONFIG_USB_SERIAL_KLSI=m
> > > CONFIG_USB_SERIAL_KOBIL_SCT=m
> > > CONFIG_USB_SERIAL_MCT_U232=m
> > > CONFIG_USB_SERIAL_METRO=m
> > > CONFIG_USB_SERIAL_MOS7720=m
> > > CONFIG_USB_SERIAL_MOS7715_PARPORT=y
> > > CONFIG_USB_SERIAL_MOS7840=m
> > > CONFIG_USB_SERIAL_MXUPORT=m
> > > CONFIG_USB_SERIAL_NAVMAN=m
> > > CONFIG_USB_SERIAL_PL2303=m
> > > CONFIG_USB_SERIAL_OTI6858=m
> > > CONFIG_USB_SERIAL_QCAUX=m
> > > CONFIG_USB_SERIAL_QUALCOMM=m
> > > CONFIG_USB_SERIAL_SPCP8X5=m
> > > CONFIG_USB_SERIAL_SAFE=m
> > > # CONFIG_USB_SERIAL_SAFE_PADDED is not set
> > > CONFIG_USB_SERIAL_SIERRAWIRELESS=m
> > > CONFIG_USB_SERIAL_SYMBOL=m
> > > CONFIG_USB_SERIAL_TI=m
> > > CONFIG_USB_SERIAL_CYBERJACK=m
> > > CONFIG_USB_SERIAL_XIRCOM=m
> > > CONFIG_USB_SERIAL_WWAN=m
> > > CONFIG_USB_SERIAL_OPTION=m
> > > CONFIG_USB_SERIAL_OMNINET=m
> > > CONFIG_USB_SERIAL_OPTICON=m
> > > CONFIG_USB_SERIAL_XSENS_MT=m
> > > CONFIG_USB_SERIAL_WISHBONE=m
> > > CONFIG_USB_SERIAL_SSU100=m
> > > CONFIG_USB_SERIAL_QT2=m
> > > CONFIG_USB_SERIAL_UPD78F0730=m
> > > CONFIG_USB_SERIAL_DEBUG=m
> > > 
> > > #
> > > # USB Miscellaneous drivers
> > > #
> > > CONFIG_USB_EMI62=m
> > > CONFIG_USB_EMI26=m
> > > CONFIG_USB_ADUTUX=m
> > > CONFIG_USB_SEVSEG=m
> > > CONFIG_USB_LEGOTOWER=m
> > > CONFIG_USB_LCD=m
> > > CONFIG_USB_CYPRESS_CY7C63=m
> > > CONFIG_USB_CYTHERM=m
> > > CONFIG_USB_IDMOUSE=m
> > > CONFIG_USB_FTDI_ELAN=m
> > > CONFIG_USB_APPLEDISPLAY=m
> > > CONFIG_USB_SISUSBVGA=m
> > > # CONFIG_USB_SISUSBVGA_CON is not set
> > > CONFIG_USB_LD=m
> > > CONFIG_USB_TRANCEVIBRATOR=m
> > > CONFIG_USB_IOWARRIOR=m
> > > CONFIG_USB_TEST=m
> > > CONFIG_USB_EHSET_TEST_FIXTURE=m
> > > CONFIG_USB_ISIGHTFW=m
> > > CONFIG_USB_YUREX=m
> > > CONFIG_USB_EZUSB_FX2=m
> > > CONFIG_USB_HUB_USB251XB=m
> > > CONFIG_USB_HSIC_USB3503=m
> > > CONFIG_USB_HSIC_USB4604=m
> > > CONFIG_USB_LINK_LAYER_TEST=m
> > > CONFIG_USB_CHAOSKEY=m
> > > CONFIG_USB_ATM=m
> > > CONFIG_USB_SPEEDTOUCH=m
> > > CONFIG_USB_CXACRU=m
> > > CONFIG_USB_UEAGLEATM=m
> > > CONFIG_USB_XUSBATM=m
> > > 
> > > #
> > > # USB Physical Layer drivers
> > > #
> > > CONFIG_USB_PHY=y
> > > CONFIG_NOP_USB_XCEIV=m
> > > CONFIG_USB_GPIO_VBUS=m
> > > CONFIG_TAHVO_USB=m
> > > CONFIG_TAHVO_USB_HOST_BY_DEFAULT=y
> > > CONFIG_USB_ISP1301=m
> > > # end of USB Physical Layer drivers
> > > 
> > > CONFIG_USB_GADGET=m
> > > # CONFIG_USB_GADGET_DEBUG is not set
> > > # CONFIG_USB_GADGET_DEBUG_FILES is not set
> > > # CONFIG_USB_GADGET_DEBUG_FS is not set
> > > CONFIG_USB_GADGET_VBUS_DRAW=2
> > > CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
> > > CONFIG_U_SERIAL_CONSOLE=y
> > > 
> > > #
> > > # USB Peripheral Controller
> > > #
> > > CONFIG_USB_FOTG210_UDC=m
> > > CONFIG_USB_GR_UDC=m
> > > CONFIG_USB_R8A66597=m
> > > CONFIG_USB_PXA27X=m
> > > CONFIG_USB_MV_UDC=m
> > > CONFIG_USB_MV_U3D=m
> > > CONFIG_USB_SNP_CORE=m
> > > # CONFIG_USB_M66592 is not set
> > > CONFIG_USB_BDC_UDC=m
> > > 
> > > #
> > > # Platform Support
> > > #
> > > CONFIG_USB_BDC_PCI=m
> > > CONFIG_USB_AMD5536UDC=m
> > > CONFIG_USB_NET2272=m
> > > CONFIG_USB_NET2272_DMA=y
> > > CONFIG_USB_NET2280=m
> > > CONFIG_USB_GOKU=m
> > > CONFIG_USB_EG20T=m
> > > # CONFIG_USB_DUMMY_HCD is not set
> > > # end of USB Peripheral Controller
> > > 
> > > CONFIG_USB_LIBCOMPOSITE=m
> > > CONFIG_USB_F_ACM=m
> > > CONFIG_USB_F_SS_LB=m
> > > CONFIG_USB_U_SERIAL=m
> > > CONFIG_USB_U_ETHER=m
> > > CONFIG_USB_U_AUDIO=m
> > > CONFIG_USB_F_SERIAL=m
> > > CONFIG_USB_F_OBEX=m
> > > CONFIG_USB_F_NCM=m
> > > CONFIG_USB_F_ECM=m
> > > CONFIG_USB_F_PHONET=m
> > > CONFIG_USB_F_EEM=m
> > > CONFIG_USB_F_SUBSET=m
> > > CONFIG_USB_F_RNDIS=m
> > > CONFIG_USB_F_MASS_STORAGE=m
> > > CONFIG_USB_F_FS=m
> > > CONFIG_USB_F_UAC1=m
> > > CONFIG_USB_F_UAC1_LEGACY=m
> > > CONFIG_USB_F_UAC2=m
> > > CONFIG_USB_F_UVC=m
> > > CONFIG_USB_F_MIDI=m
> > > CONFIG_USB_F_HID=m
> > > CONFIG_USB_F_PRINTER=m
> > > CONFIG_USB_F_TCM=m
> > > CONFIG_USB_CONFIGFS=m
> > > CONFIG_USB_CONFIGFS_SERIAL=y
> > > CONFIG_USB_CONFIGFS_ACM=y
> > > CONFIG_USB_CONFIGFS_OBEX=y
> > > CONFIG_USB_CONFIGFS_NCM=y
> > > CONFIG_USB_CONFIGFS_ECM=y
> > > CONFIG_USB_CONFIGFS_ECM_SUBSET=y
> > > CONFIG_USB_CONFIGFS_RNDIS=y
> > > CONFIG_USB_CONFIGFS_EEM=y
> > > CONFIG_USB_CONFIGFS_PHONET=y
> > > CONFIG_USB_CONFIGFS_MASS_STORAGE=y
> > > CONFIG_USB_CONFIGFS_F_LB_SS=y
> > > CONFIG_USB_CONFIGFS_F_FS=y
> > > CONFIG_USB_CONFIGFS_F_UAC1=y
> > > CONFIG_USB_CONFIGFS_F_UAC1_LEGACY=y
> > > CONFIG_USB_CONFIGFS_F_UAC2=y
> > > CONFIG_USB_CONFIGFS_F_MIDI=y
> > > CONFIG_USB_CONFIGFS_F_HID=y
> > > CONFIG_USB_CONFIGFS_F_UVC=y
> > > CONFIG_USB_CONFIGFS_F_PRINTER=y
> > > CONFIG_USB_CONFIGFS_F_TCM=y
> > > CONFIG_USB_ZERO=m
> > > CONFIG_USB_AUDIO=m
> > > CONFIG_GADGET_UAC1=y
> > > # CONFIG_GADGET_UAC1_LEGACY is not set
> > > CONFIG_USB_ETH=m
> > > CONFIG_USB_ETH_RNDIS=y
> > > CONFIG_USB_ETH_EEM=y
> > > CONFIG_USB_G_NCM=m
> > > CONFIG_USB_GADGETFS=m
> > > CONFIG_USB_FUNCTIONFS=m
> > > CONFIG_USB_FUNCTIONFS_ETH=y
> > > CONFIG_USB_FUNCTIONFS_RNDIS=y
> > > CONFIG_USB_FUNCTIONFS_GENERIC=y
> > > CONFIG_USB_MASS_STORAGE=m
> > > CONFIG_USB_GADGET_TARGET=m
> > > CONFIG_USB_G_SERIAL=m
> > > CONFIG_USB_MIDI_GADGET=m
> > > CONFIG_USB_G_PRINTER=m
> > > CONFIG_USB_CDC_COMPOSITE=m
> > > CONFIG_USB_G_NOKIA=m
> > > CONFIG_USB_G_ACM_MS=m
> > > # CONFIG_USB_G_MULTI is not set
> > > CONFIG_USB_G_HID=m
> > > CONFIG_USB_G_DBGP=m
> > > # CONFIG_USB_G_DBGP_PRINTK is not set
> > > CONFIG_USB_G_DBGP_SERIAL=y
> > > CONFIG_USB_G_WEBCAM=m
> > > CONFIG_TYPEC=m
> > > CONFIG_TYPEC_TCPM=m
> > > CONFIG_TYPEC_TCPCI=m
> > > CONFIG_TYPEC_RT1711H=m
> > > CONFIG_TYPEC_FUSB302=m
> > > CONFIG_TYPEC_UCSI=m
> > > CONFIG_UCSI_CCG=m
> > > CONFIG_UCSI_ACPI=m
> > > CONFIG_TYPEC_TPS6598X=m
> > > 
> > > #
> > > # USB Type-C Multiplexer/DeMultiplexer Switch support
> > > #
> > > CONFIG_TYPEC_MUX_PI3USB30532=m
> > > # end of USB Type-C Multiplexer/DeMultiplexer Switch support
> > > 
> > > #
> > > # USB Type-C Alternate Mode drivers
> > > #
> > > CONFIG_TYPEC_DP_ALTMODE=m
> > > CONFIG_TYPEC_NVIDIA_ALTMODE=m
> > > # end of USB Type-C Alternate Mode drivers
> > > 
> > > CONFIG_USB_ROLE_SWITCH=m
> > > CONFIG_USB_ROLES_INTEL_XHCI=m
> > > CONFIG_USB_LED_TRIG=y
> > > CONFIG_USB_ULPI_BUS=m
> > > CONFIG_UWB=m
> > > CONFIG_UWB_HWA=m
> > > CONFIG_UWB_WHCI=m
> > > CONFIG_UWB_I1480U=m
> > > CONFIG_MMC=y
> > > CONFIG_MMC_BLOCK=m
> > > CONFIG_MMC_BLOCK_MINORS=8
> > > CONFIG_SDIO_UART=m
> > > # CONFIG_MMC_TEST is not set
> > > 
> > > #
> > > # MMC/SD/SDIO Host Controller Drivers
> > > #
> > > # CONFIG_MMC_DEBUG is not set
> > > CONFIG_MMC_SDHCI=m
> > > CONFIG_MMC_SDHCI_PCI=m
> > > CONFIG_MMC_RICOH_MMC=y
> > > CONFIG_MMC_SDHCI_ACPI=m
> > > CONFIG_MMC_SDHCI_PLTFM=m
> > > CONFIG_MMC_SDHCI_F_SDH30=m
> > > CONFIG_MMC_WBSD=m
> > > CONFIG_MMC_ALCOR=m
> > > CONFIG_MMC_TIFM_SD=m
> > > CONFIG_MMC_SPI=m
> > > CONFIG_MMC_SDRICOH_CS=m
> > > CONFIG_MMC_CB710=m
> > > CONFIG_MMC_VIA_SDMMC=m
> > > CONFIG_MMC_VUB300=m
> > > CONFIG_MMC_USHC=m
> > > CONFIG_MMC_USDHI6ROL0=m
> > > CONFIG_MMC_REALTEK_PCI=m
> > > CONFIG_MMC_REALTEK_USB=m
> > > CONFIG_MMC_CQHCI=m
> > > CONFIG_MMC_TOSHIBA_PCI=m
> > > CONFIG_MMC_MTK=m
> > > CONFIG_MMC_SDHCI_XENON=m
> > > CONFIG_MEMSTICK=m
> > > # CONFIG_MEMSTICK_DEBUG is not set
> > > 
> > > #
> > > # MemoryStick drivers
> > > #
> > > # CONFIG_MEMSTICK_UNSAFE_RESUME is not set
> > > CONFIG_MSPRO_BLOCK=m
> > > CONFIG_MS_BLOCK=m
> > > 
> > > #
> > > # MemoryStick Host Controller Drivers
> > > #
> > > CONFIG_MEMSTICK_TIFM_MS=m
> > > CONFIG_MEMSTICK_JMICRON_38X=m
> > > CONFIG_MEMSTICK_R592=m
> > > CONFIG_MEMSTICK_REALTEK_PCI=m
> > > CONFIG_MEMSTICK_REALTEK_USB=m
> > > CONFIG_NEW_LEDS=y
> > > CONFIG_LEDS_CLASS=y
> > > CONFIG_LEDS_CLASS_FLASH=m
> > > CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y
> > > 
> > > #
> > > # LED drivers
> > > #
> > > CONFIG_LEDS_88PM860X=m
> > > CONFIG_LEDS_APU=m
> > > CONFIG_LEDS_AS3645A=m
> > > CONFIG_LEDS_LM3530=m
> > > CONFIG_LEDS_LM3532=m
> > > CONFIG_LEDS_LM3533=m
> > > CONFIG_LEDS_LM3642=m
> > > CONFIG_LEDS_LM3601X=m
> > > CONFIG_LEDS_MT6323=m
> > > CONFIG_LEDS_PCA9532=m
> > > CONFIG_LEDS_PCA9532_GPIO=y
> > > CONFIG_LEDS_GPIO=m
> > > CONFIG_LEDS_LP3944=m
> > > CONFIG_LEDS_LP3952=m
> > > CONFIG_LEDS_LP55XX_COMMON=m
> > > CONFIG_LEDS_LP5521=m
> > > CONFIG_LEDS_LP5523=m
> > > CONFIG_LEDS_LP5562=m
> > > CONFIG_LEDS_LP8501=m
> > > CONFIG_LEDS_LP8788=m
> > > CONFIG_LEDS_CLEVO_MAIL=m
> > > CONFIG_LEDS_PCA955X=m
> > > CONFIG_LEDS_PCA955X_GPIO=y
> > > CONFIG_LEDS_PCA963X=m
> > > CONFIG_LEDS_WM831X_STATUS=m
> > > CONFIG_LEDS_WM8350=m
> > > CONFIG_LEDS_DA903X=m
> > > CONFIG_LEDS_DA9052=m
> > > CONFIG_LEDS_DAC124S085=m
> > > CONFIG_LEDS_PWM=m
> > > CONFIG_LEDS_REGULATOR=m
> > > CONFIG_LEDS_BD2802=m
> > > CONFIG_LEDS_INTEL_SS4200=m
> > > CONFIG_LEDS_ADP5520=m
> > > CONFIG_LEDS_MC13783=m
> > > CONFIG_LEDS_TCA6507=m
> > > CONFIG_LEDS_TLC591XX=m
> > > CONFIG_LEDS_MAX8997=m
> > > CONFIG_LEDS_LM355x=m
> > > CONFIG_LEDS_MENF21BMC=m
> > > 
> > > #
> > > # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> > > #
> > > CONFIG_LEDS_BLINKM=m
> > > CONFIG_LEDS_MLXCPLD=m
> > > CONFIG_LEDS_MLXREG=m
> > > CONFIG_LEDS_USER=m
> > > CONFIG_LEDS_NIC78BX=m
> > > CONFIG_LEDS_TI_LMU_COMMON=m
> > > CONFIG_LEDS_LM36274=m
> > > 
> > > #
> > > # LED Triggers
> > > #
> > > CONFIG_LEDS_TRIGGERS=y
> > > CONFIG_LEDS_TRIGGER_TIMER=m
> > > CONFIG_LEDS_TRIGGER_ONESHOT=m
> > > CONFIG_LEDS_TRIGGER_DISK=y
> > > CONFIG_LEDS_TRIGGER_MTD=y
> > > CONFIG_LEDS_TRIGGER_HEARTBEAT=m
> > > CONFIG_LEDS_TRIGGER_BACKLIGHT=m
> > > CONFIG_LEDS_TRIGGER_CPU=y
> > > CONFIG_LEDS_TRIGGER_ACTIVITY=m
> > > CONFIG_LEDS_TRIGGER_GPIO=m
> > > CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
> > > 
> > > #
> > > # iptables trigger is under Netfilter config (LED target)
> > > #
> > > CONFIG_LEDS_TRIGGER_TRANSIENT=m
> > > CONFIG_LEDS_TRIGGER_CAMERA=m
> > > CONFIG_LEDS_TRIGGER_PANIC=y
> > > CONFIG_LEDS_TRIGGER_NETDEV=m
> > > CONFIG_LEDS_TRIGGER_PATTERN=m
> > > CONFIG_LEDS_TRIGGER_AUDIO=m
> > > # CONFIG_ACCESSIBILITY is not set
> > > CONFIG_INFINIBAND=m
> > > CONFIG_INFINIBAND_USER_MAD=m
> > > CONFIG_INFINIBAND_USER_ACCESS=m
> > > # CONFIG_INFINIBAND_EXP_LEGACY_VERBS_NEW_UAPI is not set
> > > CONFIG_INFINIBAND_USER_MEM=y
> > > CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
> > > CONFIG_INFINIBAND_ADDR_TRANS=y
> > > CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
> > > CONFIG_INFINIBAND_MTHCA=m
> > > # CONFIG_INFINIBAND_MTHCA_DEBUG is not set
> > > CONFIG_INFINIBAND_QIB=m
> > > CONFIG_INFINIBAND_QIB_DCA=y
> > > CONFIG_INFINIBAND_CXGB3=m
> > > CONFIG_INFINIBAND_CXGB4=m
> > > CONFIG_INFINIBAND_EFA=m
> > > CONFIG_INFINIBAND_I40IW=m
> > > CONFIG_MLX4_INFINIBAND=m
> > > CONFIG_MLX5_INFINIBAND=m
> > > CONFIG_INFINIBAND_OCRDMA=m
> > > CONFIG_INFINIBAND_VMWARE_PVRDMA=m
> > > CONFIG_INFINIBAND_USNIC=m
> > > CONFIG_INFINIBAND_BNXT_RE=m
> > > CONFIG_INFINIBAND_HFI1=m
> > > # CONFIG_HFI1_DEBUG_SDMA_ORDER is not set
> > > # CONFIG_SDMA_VERBOSITY is not set
> > > CONFIG_INFINIBAND_QEDR=m
> > > CONFIG_INFINIBAND_RDMAVT=m
> > > CONFIG_RDMA_RXE=m
> > > CONFIG_RDMA_SIW=m
> > > CONFIG_INFINIBAND_IPOIB=m
> > > CONFIG_INFINIBAND_IPOIB_CM=y
> > > # CONFIG_INFINIBAND_IPOIB_DEBUG is not set
> > > CONFIG_INFINIBAND_SRP=m
> > > CONFIG_INFINIBAND_SRPT=m
> > > CONFIG_INFINIBAND_ISER=m
> > > CONFIG_INFINIBAND_ISERT=m
> > > CONFIG_INFINIBAND_OPA_VNIC=m
> > > CONFIG_EDAC_ATOMIC_SCRUB=y
> > > CONFIG_EDAC_SUPPORT=y
> > > CONFIG_EDAC=y
> > > # CONFIG_EDAC_LEGACY_SYSFS is not set
> > > # CONFIG_EDAC_DEBUG is not set
> > > CONFIG_EDAC_DECODE_MCE=m
> > > CONFIG_EDAC_GHES=y
> > > CONFIG_EDAC_AMD64=m
> > > # CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
> > > CONFIG_EDAC_E752X=m
> > > CONFIG_EDAC_I82975X=m
> > > CONFIG_EDAC_I3000=m
> > > CONFIG_EDAC_I3200=m
> > > CONFIG_EDAC_IE31200=m
> > > CONFIG_EDAC_X38=m
> > > CONFIG_EDAC_I5400=m
> > > CONFIG_EDAC_I7CORE=m
> > > CONFIG_EDAC_I5000=m
> > > CONFIG_EDAC_I5100=m
> > > CONFIG_EDAC_I7300=m
> > > CONFIG_EDAC_SBRIDGE=m
> > > CONFIG_EDAC_SKX=m
> > > CONFIG_EDAC_I10NM=m
> > > CONFIG_EDAC_PND2=m
> > > CONFIG_RTC_LIB=y
> > > CONFIG_RTC_MC146818_LIB=y
> > > CONFIG_RTC_CLASS=y
> > > CONFIG_RTC_HCTOSYS=y
> > > CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> > > CONFIG_RTC_SYSTOHC=y
> > > CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
> > > # CONFIG_RTC_DEBUG is not set
> > > CONFIG_RTC_NVMEM=y
> > > 
> > > #
> > > # RTC interfaces
> > > #
> > > CONFIG_RTC_INTF_SYSFS=y
> > > CONFIG_RTC_INTF_PROC=y
> > > CONFIG_RTC_INTF_DEV=y
> > > # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> > > # CONFIG_RTC_DRV_TEST is not set
> > > 
> > > #
> > > # I2C RTC drivers
> > > #
> > > CONFIG_RTC_DRV_88PM860X=m
> > > CONFIG_RTC_DRV_88PM80X=m
> > > CONFIG_RTC_DRV_ABB5ZES3=m
> > > CONFIG_RTC_DRV_ABEOZ9=m
> > > CONFIG_RTC_DRV_ABX80X=m
> > > CONFIG_RTC_DRV_DS1307=m
> > > CONFIG_RTC_DRV_DS1307_CENTURY=y
> > > CONFIG_RTC_DRV_DS1374=m
> > > CONFIG_RTC_DRV_DS1374_WDT=y
> > > CONFIG_RTC_DRV_DS1672=m
> > > CONFIG_RTC_DRV_LP8788=m
> > > CONFIG_RTC_DRV_MAX6900=m
> > > CONFIG_RTC_DRV_MAX8907=m
> > > CONFIG_RTC_DRV_MAX8925=m
> > > CONFIG_RTC_DRV_MAX8998=m
> > > CONFIG_RTC_DRV_MAX8997=m
> > > CONFIG_RTC_DRV_RS5C372=m
> > > CONFIG_RTC_DRV_ISL1208=m
> > > CONFIG_RTC_DRV_ISL12022=m
> > > CONFIG_RTC_DRV_X1205=m
> > > CONFIG_RTC_DRV_PCF8523=m
> > > CONFIG_RTC_DRV_PCF85063=m
> > > CONFIG_RTC_DRV_PCF85363=m
> > > CONFIG_RTC_DRV_PCF8563=m
> > > CONFIG_RTC_DRV_PCF8583=m
> > > CONFIG_RTC_DRV_M41T80=m
> > > CONFIG_RTC_DRV_M41T80_WDT=y
> > > CONFIG_RTC_DRV_BQ32K=m
> > > CONFIG_RTC_DRV_PALMAS=m
> > > CONFIG_RTC_DRV_TPS6586X=m
> > > CONFIG_RTC_DRV_TPS65910=m
> > > CONFIG_RTC_DRV_TPS80031=m
> > > CONFIG_RTC_DRV_RC5T583=m
> > > CONFIG_RTC_DRV_S35390A=m
> > > CONFIG_RTC_DRV_FM3130=m
> > > CONFIG_RTC_DRV_RX8010=m
> > > CONFIG_RTC_DRV_RX8581=m
> > > CONFIG_RTC_DRV_RX8025=m
> > > CONFIG_RTC_DRV_EM3027=m
> > > CONFIG_RTC_DRV_RV3028=m
> > > CONFIG_RTC_DRV_RV8803=m
> > > CONFIG_RTC_DRV_S5M=m
> > > CONFIG_RTC_DRV_SD3078=m
> > > 
> > > #
> > > # SPI RTC drivers
> > > #
> > > CONFIG_RTC_DRV_M41T93=m
> > > CONFIG_RTC_DRV_M41T94=m
> > > CONFIG_RTC_DRV_DS1302=m
> > > CONFIG_RTC_DRV_DS1305=m
> > > CONFIG_RTC_DRV_DS1343=m
> > > CONFIG_RTC_DRV_DS1347=m
> > > CONFIG_RTC_DRV_DS1390=m
> > > CONFIG_RTC_DRV_MAX6916=m
> > > CONFIG_RTC_DRV_R9701=m
> > > CONFIG_RTC_DRV_RX4581=m
> > > CONFIG_RTC_DRV_RX6110=m
> > > CONFIG_RTC_DRV_RS5C348=m
> > > CONFIG_RTC_DRV_MAX6902=m
> > > CONFIG_RTC_DRV_PCF2123=m
> > > CONFIG_RTC_DRV_MCP795=m
> > > CONFIG_RTC_I2C_AND_SPI=y
> > > 
> > > #
> > > # SPI and I2C RTC drivers
> > > #
> > > CONFIG_RTC_DRV_DS3232=m
> > > CONFIG_RTC_DRV_DS3232_HWMON=y
> > > CONFIG_RTC_DRV_PCF2127=m
> > > CONFIG_RTC_DRV_RV3029C2=m
> > > CONFIG_RTC_DRV_RV3029_HWMON=y
> > > 
> > > #
> > > # Platform RTC drivers
> > > #
> > > CONFIG_RTC_DRV_CMOS=y
> > > CONFIG_RTC_DRV_DS1286=m
> > > CONFIG_RTC_DRV_DS1511=m
> > > CONFIG_RTC_DRV_DS1553=m
> > > CONFIG_RTC_DRV_DS1685_FAMILY=m
> > > CONFIG_RTC_DRV_DS1685=y
> > > # CONFIG_RTC_DRV_DS1689 is not set
> > > # CONFIG_RTC_DRV_DS17285 is not set
> > > # CONFIG_RTC_DRV_DS17485 is not set
> > > # CONFIG_RTC_DRV_DS17885 is not set
> > > CONFIG_RTC_DRV_DS1742=m
> > > CONFIG_RTC_DRV_DS2404=m
> > > CONFIG_RTC_DRV_DA9052=m
> > > CONFIG_RTC_DRV_DA9055=m
> > > CONFIG_RTC_DRV_DA9063=m
> > > CONFIG_RTC_DRV_STK17TA8=m
> > > CONFIG_RTC_DRV_M48T86=m
> > > CONFIG_RTC_DRV_M48T35=m
> > > CONFIG_RTC_DRV_M48T59=m
> > > CONFIG_RTC_DRV_MSM6242=m
> > > CONFIG_RTC_DRV_BQ4802=m
> > > CONFIG_RTC_DRV_RP5C01=m
> > > CONFIG_RTC_DRV_V3020=m
> > > CONFIG_RTC_DRV_WM831X=m
> > > CONFIG_RTC_DRV_WM8350=m
> > > CONFIG_RTC_DRV_PCF50633=m
> > > CONFIG_RTC_DRV_AB3100=m
> > > CONFIG_RTC_DRV_CROS_EC=m
> > > 
> > > #
> > > # on-CPU RTC drivers
> > > #
> > > CONFIG_RTC_DRV_FTRTC010=m
> > > CONFIG_RTC_DRV_PCAP=m
> > > CONFIG_RTC_DRV_MC13XXX=m
> > > CONFIG_RTC_DRV_MT6397=m
> > > 
> > > #
> > > # HID Sensor RTC drivers
> > > #
> > > CONFIG_RTC_DRV_HID_SENSOR_TIME=m
> > > CONFIG_RTC_DRV_WILCO_EC=m
> > > CONFIG_DMADEVICES=y
> > > # CONFIG_DMADEVICES_DEBUG is not set
> > > 
> > > #
> > > # DMA Devices
> > > #
> > > CONFIG_DMA_ENGINE=y
> > > CONFIG_DMA_VIRTUAL_CHANNELS=m
> > > CONFIG_DMA_ACPI=y
> > > CONFIG_ALTERA_MSGDMA=m
> > > CONFIG_INTEL_IDMA64=m
> > > CONFIG_INTEL_IOATDMA=m
> > > CONFIG_INTEL_MIC_X100_DMA=m
> > > CONFIG_QCOM_HIDMA_MGMT=m
> > > CONFIG_QCOM_HIDMA=m
> > > CONFIG_DW_DMAC_CORE=m
> > > CONFIG_DW_DMAC=m
> > > CONFIG_DW_DMAC_PCI=m
> > > CONFIG_DW_EDMA=m
> > > CONFIG_DW_EDMA_PCIE=m
> > > CONFIG_HSU_DMA=m
> > > 
> > > #
> > > # DMA Clients
> > > #
> > > CONFIG_ASYNC_TX_DMA=y
> > > # CONFIG_DMATEST is not set
> > > CONFIG_DMA_ENGINE_RAID=y
> > > 
> > > #
> > > # DMABUF options
> > > #
> > > CONFIG_SYNC_FILE=y
> > > CONFIG_SW_SYNC=y
> > > CONFIG_UDMABUF=y
> > > # end of DMABUF options
> > > 
> > > CONFIG_DCA=m
> > > CONFIG_AUXDISPLAY=y
> > > CONFIG_HD44780=m
> > > CONFIG_KS0108=m
> > > CONFIG_KS0108_PORT=0x378
> > > CONFIG_KS0108_DELAY=2
> > > CONFIG_CFAG12864B=m
> > > CONFIG_CFAG12864B_RATE=20
> > > CONFIG_IMG_ASCII_LCD=m
> > > CONFIG_PARPORT_PANEL=m
> > > CONFIG_PANEL_PARPORT=0
> > > CONFIG_PANEL_PROFILE=5
> > > # CONFIG_PANEL_CHANGE_MESSAGE is not set
> > > # CONFIG_CHARLCD_BL_OFF is not set
> > > # CONFIG_CHARLCD_BL_ON is not set
> > > CONFIG_CHARLCD_BL_FLASH=y
> > > CONFIG_PANEL=m
> > > CONFIG_CHARLCD=m
> > > CONFIG_UIO=m
> > > CONFIG_UIO_CIF=m
> > > CONFIG_UIO_PDRV_GENIRQ=m
> > > CONFIG_UIO_DMEM_GENIRQ=m
> > > CONFIG_UIO_AEC=m
> > > CONFIG_UIO_SERCOS3=m
> > > CONFIG_UIO_PCI_GENERIC=m
> > > CONFIG_UIO_NETX=m
> > > CONFIG_UIO_PRUSS=m
> > > CONFIG_UIO_MF624=m
> > > CONFIG_UIO_HV_GENERIC=m
> > > CONFIG_VFIO_IOMMU_TYPE1=m
> > > CONFIG_VFIO_VIRQFD=m
> > > CONFIG_VFIO=m
> > > CONFIG_VFIO_NOIOMMU=y
> > > CONFIG_VFIO_PCI=m
> > > CONFIG_VFIO_PCI_VGA=y
> > > CONFIG_VFIO_PCI_MMAP=y
> > > CONFIG_VFIO_PCI_INTX=y
> > > CONFIG_VFIO_PCI_IGD=y
> > > CONFIG_VFIO_MDEV=m
> > > CONFIG_VFIO_MDEV_DEVICE=m
> > > CONFIG_IRQ_BYPASS_MANAGER=m
> > > CONFIG_VIRT_DRIVERS=y
> > > # CONFIG_VBOXGUEST is not set
> > > CONFIG_VIRTIO=y
> > > CONFIG_VIRTIO_MENU=y
> > > CONFIG_VIRTIO_PCI=y
> > > CONFIG_VIRTIO_PCI_LEGACY=y
> > > CONFIG_VIRTIO_PMEM=m
> > > CONFIG_VIRTIO_BALLOON=y
> > > CONFIG_VIRTIO_INPUT=m
> > > CONFIG_VIRTIO_MMIO=y
> > > CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
> > > 
> > > #
> > > # Microsoft Hyper-V guest support
> > > #
> > > CONFIG_HYPERV=m
> > > CONFIG_HYPERV_TIMER=y
> > > CONFIG_HYPERV_TSCPAGE=y
> > > CONFIG_HYPERV_UTILS=m
> > > CONFIG_HYPERV_BALLOON=m
> > > # end of Microsoft Hyper-V guest support
> > > 
> > > #
> > > # Xen driver support
> > > #
> > > CONFIG_XEN_BALLOON=y
> > > CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=y
> > > CONFIG_XEN_BALLOON_MEMORY_HOTPLUG_LIMIT=512
> > > CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
> > > CONFIG_XEN_DEV_EVTCHN=m
> > > CONFIG_XEN_BACKEND=y
> > > CONFIG_XENFS=m
> > > CONFIG_XEN_COMPAT_XENFS=y
> > > CONFIG_XEN_SYS_HYPERVISOR=y
> > > CONFIG_XEN_XENBUS_FRONTEND=y
> > > CONFIG_XEN_GNTDEV=m
> > > CONFIG_XEN_GNTDEV_DMABUF=y
> > > CONFIG_XEN_GRANT_DEV_ALLOC=m
> > > CONFIG_XEN_GRANT_DMA_ALLOC=y
> > > CONFIG_SWIOTLB_XEN=y
> > > CONFIG_XEN_PCIDEV_BACKEND=m
> > > CONFIG_XEN_PVCALLS_FRONTEND=m
> > > # CONFIG_XEN_PVCALLS_BACKEND is not set
> > > CONFIG_XEN_SCSI_BACKEND=m
> > > CONFIG_XEN_PRIVCMD=m
> > > CONFIG_XEN_ACPI_PROCESSOR=y
> > > CONFIG_XEN_MCE_LOG=y
> > > CONFIG_XEN_HAVE_PVMMU=y
> > > CONFIG_XEN_EFI=y
> > > CONFIG_XEN_AUTO_XLATE=y
> > > CONFIG_XEN_ACPI=y
> > > CONFIG_XEN_SYMS=y
> > > CONFIG_XEN_HAVE_VPMU=y
> > > CONFIG_XEN_FRONT_PGDIR_SHBUF=m
> > > # end of Xen driver support
> > > 
> > > CONFIG_STAGING=y
> > > CONFIG_PRISM2_USB=m
> > > CONFIG_COMEDI=m
> > > # CONFIG_COMEDI_DEBUG is not set
> > > CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
> > > CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
> > > CONFIG_COMEDI_MISC_DRIVERS=y
> > > CONFIG_COMEDI_BOND=m
> > > CONFIG_COMEDI_TEST=m
> > > CONFIG_COMEDI_PARPORT=m
> > > CONFIG_COMEDI_ISA_DRIVERS=y
> > > CONFIG_COMEDI_PCL711=m
> > > CONFIG_COMEDI_PCL724=m
> > > CONFIG_COMEDI_PCL726=m
> > > CONFIG_COMEDI_PCL730=m
> > > CONFIG_COMEDI_PCL812=m
> > > CONFIG_COMEDI_PCL816=m
> > > CONFIG_COMEDI_PCL818=m
> > > CONFIG_COMEDI_PCM3724=m
> > > CONFIG_COMEDI_AMPLC_DIO200_ISA=m
> > > CONFIG_COMEDI_AMPLC_PC236_ISA=m
> > > CONFIG_COMEDI_AMPLC_PC263_ISA=m
> > > CONFIG_COMEDI_RTI800=m
> > > CONFIG_COMEDI_RTI802=m
> > > CONFIG_COMEDI_DAC02=m
> > > CONFIG_COMEDI_DAS16M1=m
> > > CONFIG_COMEDI_DAS08_ISA=m
> > > CONFIG_COMEDI_DAS16=m
> > > CONFIG_COMEDI_DAS800=m
> > > CONFIG_COMEDI_DAS1800=m
> > > CONFIG_COMEDI_DAS6402=m
> > > CONFIG_COMEDI_DT2801=m
> > > CONFIG_COMEDI_DT2811=m
> > > CONFIG_COMEDI_DT2814=m
> > > CONFIG_COMEDI_DT2815=m
> > > CONFIG_COMEDI_DT2817=m
> > > CONFIG_COMEDI_DT282X=m
> > > CONFIG_COMEDI_DMM32AT=m
> > > CONFIG_COMEDI_FL512=m
> > > CONFIG_COMEDI_AIO_AIO12_8=m
> > > CONFIG_COMEDI_AIO_IIRO_16=m
> > > CONFIG_COMEDI_II_PCI20KC=m
> > > CONFIG_COMEDI_C6XDIGIO=m
> > > CONFIG_COMEDI_MPC624=m
> > > CONFIG_COMEDI_ADQ12B=m
> > > CONFIG_COMEDI_NI_AT_A2150=m
> > > CONFIG_COMEDI_NI_AT_AO=m
> > > CONFIG_COMEDI_NI_ATMIO=m
> > > CONFIG_COMEDI_NI_ATMIO16D=m
> > > CONFIG_COMEDI_NI_LABPC_ISA=m
> > > CONFIG_COMEDI_PCMAD=m
> > > CONFIG_COMEDI_PCMDA12=m
> > > CONFIG_COMEDI_PCMMIO=m
> > > CONFIG_COMEDI_PCMUIO=m
> > > CONFIG_COMEDI_MULTIQ3=m
> > > CONFIG_COMEDI_S526=m
> > > CONFIG_COMEDI_PCI_DRIVERS=m
> > > CONFIG_COMEDI_8255_PCI=m
> > > CONFIG_COMEDI_ADDI_WATCHDOG=m
> > > CONFIG_COMEDI_ADDI_APCI_1032=m
> > > CONFIG_COMEDI_ADDI_APCI_1500=m
> > > CONFIG_COMEDI_ADDI_APCI_1516=m
> > > CONFIG_COMEDI_ADDI_APCI_1564=m
> > > CONFIG_COMEDI_ADDI_APCI_16XX=m
> > > CONFIG_COMEDI_ADDI_APCI_2032=m
> > > CONFIG_COMEDI_ADDI_APCI_2200=m
> > > CONFIG_COMEDI_ADDI_APCI_3120=m
> > > CONFIG_COMEDI_ADDI_APCI_3501=m
> > > CONFIG_COMEDI_ADDI_APCI_3XXX=m
> > > CONFIG_COMEDI_ADL_PCI6208=m
> > > CONFIG_COMEDI_ADL_PCI7X3X=m
> > > CONFIG_COMEDI_ADL_PCI8164=m
> > > CONFIG_COMEDI_ADL_PCI9111=m
> > > CONFIG_COMEDI_ADL_PCI9118=m
> > > CONFIG_COMEDI_ADV_PCI1710=m
> > > CONFIG_COMEDI_ADV_PCI1720=m
> > > CONFIG_COMEDI_ADV_PCI1723=m
> > > CONFIG_COMEDI_ADV_PCI1724=m
> > > CONFIG_COMEDI_ADV_PCI1760=m
> > > CONFIG_COMEDI_ADV_PCI_DIO=m
> > > CONFIG_COMEDI_AMPLC_DIO200_PCI=m
> > > CONFIG_COMEDI_AMPLC_PC236_PCI=m
> > > CONFIG_COMEDI_AMPLC_PC263_PCI=m
> > > CONFIG_COMEDI_AMPLC_PCI224=m
> > > CONFIG_COMEDI_AMPLC_PCI230=m
> > > CONFIG_COMEDI_CONTEC_PCI_DIO=m
> > > CONFIG_COMEDI_DAS08_PCI=m
> > > CONFIG_COMEDI_DT3000=m
> > > CONFIG_COMEDI_DYNA_PCI10XX=m
> > > CONFIG_COMEDI_GSC_HPDI=m
> > > CONFIG_COMEDI_MF6X4=m
> > > CONFIG_COMEDI_ICP_MULTI=m
> > > CONFIG_COMEDI_DAQBOARD2000=m
> > > CONFIG_COMEDI_JR3_PCI=m
> > > CONFIG_COMEDI_KE_COUNTER=m
> > > CONFIG_COMEDI_CB_PCIDAS64=m
> > > CONFIG_COMEDI_CB_PCIDAS=m
> > > CONFIG_COMEDI_CB_PCIDDA=m
> > > CONFIG_COMEDI_CB_PCIMDAS=m
> > > CONFIG_COMEDI_CB_PCIMDDA=m
> > > CONFIG_COMEDI_ME4000=m
> > > CONFIG_COMEDI_ME_DAQ=m
> > > CONFIG_COMEDI_NI_6527=m
> > > CONFIG_COMEDI_NI_65XX=m
> > > CONFIG_COMEDI_NI_660X=m
> > > CONFIG_COMEDI_NI_670X=m
> > > CONFIG_COMEDI_NI_LABPC_PCI=m
> > > CONFIG_COMEDI_NI_PCIDIO=m
> > > CONFIG_COMEDI_NI_PCIMIO=m
> > > CONFIG_COMEDI_RTD520=m
> > > CONFIG_COMEDI_S626=m
> > > CONFIG_COMEDI_MITE=m
> > > CONFIG_COMEDI_NI_TIOCMD=m
> > > CONFIG_COMEDI_PCMCIA_DRIVERS=m
> > > CONFIG_COMEDI_CB_DAS16_CS=m
> > > CONFIG_COMEDI_DAS08_CS=m
> > > CONFIG_COMEDI_NI_DAQ_700_CS=m
> > > CONFIG_COMEDI_NI_DAQ_DIO24_CS=m
> > > CONFIG_COMEDI_NI_LABPC_CS=m
> > > CONFIG_COMEDI_NI_MIO_CS=m
> > > CONFIG_COMEDI_QUATECH_DAQP_CS=m
> > > CONFIG_COMEDI_USB_DRIVERS=m
> > > CONFIG_COMEDI_DT9812=m
> > > CONFIG_COMEDI_NI_USB6501=m
> > > CONFIG_COMEDI_USBDUX=m
> > > CONFIG_COMEDI_USBDUXFAST=m
> > > CONFIG_COMEDI_USBDUXSIGMA=m
> > > CONFIG_COMEDI_VMK80XX=m
> > > CONFIG_COMEDI_8254=m
> > > CONFIG_COMEDI_8255=m
> > > CONFIG_COMEDI_8255_SA=m
> > > CONFIG_COMEDI_KCOMEDILIB=m
> > > CONFIG_COMEDI_AMPLC_DIO200=m
> > > CONFIG_COMEDI_AMPLC_PC236=m
> > > CONFIG_COMEDI_DAS08=m
> > > CONFIG_COMEDI_ISADMA=m
> > > CONFIG_COMEDI_NI_LABPC=m
> > > CONFIG_COMEDI_NI_LABPC_ISADMA=m
> > > CONFIG_COMEDI_NI_TIO=m
> > > CONFIG_COMEDI_NI_ROUTING=m
> > > CONFIG_RTL8192U=m
> > > CONFIG_RTLLIB=m
> > > CONFIG_RTLLIB_CRYPTO_CCMP=m
> > > CONFIG_RTLLIB_CRYPTO_TKIP=m
> > > CONFIG_RTLLIB_CRYPTO_WEP=m
> > > CONFIG_RTL8192E=m
> > > CONFIG_RTL8723BS=m
> > > CONFIG_R8712U=m
> > > CONFIG_R8188EU=m
> > > CONFIG_88EU_AP_MODE=y
> > > CONFIG_RTS5208=m
> > > CONFIG_VT6655=m
> > > CONFIG_VT6656=m
> > > 
> > > #
> > > # IIO staging drivers
> > > #
> > > 
> > > #
> > > # Accelerometers
> > > #
> > > CONFIG_ADIS16203=m
> > > CONFIG_ADIS16240=m
> > > # end of Accelerometers
> > > 
> > > #
> > > # Analog to digital converters
> > > #
> > > CONFIG_AD7816=m
> > > CONFIG_AD7192=m
> > > CONFIG_AD7280=m
> > > # end of Analog to digital converters
> > > 
> > > #
> > > # Analog digital bi-direction converters
> > > #
> > > CONFIG_ADT7316=m
> > > CONFIG_ADT7316_SPI=m
> > > CONFIG_ADT7316_I2C=m
> > > # end of Analog digital bi-direction converters
> > > 
> > > #
> > > # Capacitance to digital converters
> > > #
> > > CONFIG_AD7150=m
> > > CONFIG_AD7746=m
> > > # end of Capacitance to digital converters
> > > 
> > > #
> > > # Direct Digital Synthesis
> > > #
> > > CONFIG_AD9832=m
> > > CONFIG_AD9834=m
> > > # end of Direct Digital Synthesis
> > > 
> > > #
> > > # Network Analyzer, Impedance Converters
> > > #
> > > CONFIG_AD5933=m
> > > # end of Network Analyzer, Impedance Converters
> > > 
> > > #
> > > # Active energy metering IC
> > > #
> > > CONFIG_ADE7854=m
> > > CONFIG_ADE7854_I2C=m
> > > CONFIG_ADE7854_SPI=m
> > > # end of Active energy metering IC
> > > 
> > > #
> > > # Resolver to digital converters
> > > #
> > > CONFIG_AD2S1210=m
> > > # end of Resolver to digital converters
> > > # end of IIO staging drivers
> > > 
> > > CONFIG_FB_SM750=m
> > > 
> > > #
> > > # Speakup console speech
> > > #
> > > CONFIG_SPEAKUP=m
> > > CONFIG_SPEAKUP_SYNTH_ACNTSA=m
> > > CONFIG_SPEAKUP_SYNTH_APOLLO=m
> > > CONFIG_SPEAKUP_SYNTH_AUDPTR=m
> > > CONFIG_SPEAKUP_SYNTH_BNS=m
> > > CONFIG_SPEAKUP_SYNTH_DECTLK=m
> > > CONFIG_SPEAKUP_SYNTH_DECEXT=m
> > > CONFIG_SPEAKUP_SYNTH_LTLK=m
> > > CONFIG_SPEAKUP_SYNTH_SOFT=m
> > > CONFIG_SPEAKUP_SYNTH_SPKOUT=m
> > > CONFIG_SPEAKUP_SYNTH_TXPRT=m
> > > CONFIG_SPEAKUP_SYNTH_DUMMY=m
> > > # end of Speakup console speech
> > > 
> > > CONFIG_STAGING_MEDIA=y
> > > CONFIG_I2C_BCM2048=m
> > > CONFIG_VIDEO_IPU3_IMGU=m
> > > 
> > > #
> > > # soc_camera sensor drivers
> > > #
> > > 
> > > #
> > > # Android
> > > #
> > > CONFIG_ASHMEM=m
> > > # CONFIG_ANDROID_VSOC is not set
> > > # CONFIG_ION is not set
> > > # end of Android
> > > 
> > > CONFIG_LTE_GDM724X=m
> > > CONFIG_FIREWIRE_SERIAL=m
> > > CONFIG_FWTTY_MAX_TOTAL_PORTS=64
> > > CONFIG_FWTTY_MAX_CARD_PORTS=32
> > > CONFIG_GS_FPGABOOT=m
> > > CONFIG_UNISYSSPAR=y
> > > CONFIG_UNISYS_VISORNIC=m
> > > CONFIG_UNISYS_VISORINPUT=m
> > > CONFIG_UNISYS_VISORHBA=m
> > > CONFIG_WILC1000=m
> > > CONFIG_WILC1000_SDIO=m
> > > CONFIG_WILC1000_SPI=m
> > > CONFIG_WILC1000_HW_OOB_INTR=y
> > > CONFIG_MOST=m
> > > CONFIG_MOST_CDEV=m
> > > CONFIG_MOST_NET=m
> > > CONFIG_MOST_SOUND=m
> > > CONFIG_MOST_VIDEO=m
> > > CONFIG_MOST_I2C=m
> > > CONFIG_MOST_USB=m
> > > CONFIG_KS7010=m
> > > CONFIG_GREYBUS=m
> > > CONFIG_GREYBUS_ES2=m
> > > CONFIG_GREYBUS_AUDIO=m
> > > CONFIG_GREYBUS_BOOTROM=m
> > > CONFIG_GREYBUS_FIRMWARE=m
> > > CONFIG_GREYBUS_HID=m
> > > CONFIG_GREYBUS_LIGHT=m
> > > CONFIG_GREYBUS_LOG=m
> > > CONFIG_GREYBUS_LOOPBACK=m
> > > CONFIG_GREYBUS_POWER=m
> > > CONFIG_GREYBUS_RAW=m
> > > CONFIG_GREYBUS_VIBRATOR=m
> > > CONFIG_GREYBUS_BRIDGED_PHY=m
> > > CONFIG_GREYBUS_GPIO=m
> > > CONFIG_GREYBUS_I2C=m
> > > CONFIG_GREYBUS_PWM=m
> > > CONFIG_GREYBUS_SDIO=m
> > > CONFIG_GREYBUS_SPI=m
> > > CONFIG_GREYBUS_UART=m
> > > CONFIG_GREYBUS_USB=m
> > > CONFIG_PI433=m
> > > 
> > > #
> > > # Gasket devices
> > > #
> > > CONFIG_STAGING_GASKET_FRAMEWORK=m
> > > CONFIG_STAGING_APEX_DRIVER=m
> > > # end of Gasket devices
> > > 
> > > CONFIG_EROFS_FS=m
> > > # CONFIG_EROFS_FS_DEBUG is not set
> > > CONFIG_EROFS_FS_XATTR=y
> > > CONFIG_EROFS_FS_POSIX_ACL=y
> > > CONFIG_EROFS_FS_SECURITY=y
> > > # CONFIG_EROFS_FS_USE_VM_MAP_RAM is not set
> > > # CONFIG_EROFS_FAULT_INJECTION is not set
> > > CONFIG_EROFS_FS_IO_MAX_RETRIES=5
> > > # CONFIG_EROFS_FS_ZIP is not set
> > > CONFIG_FIELDBUS_DEV=m
> > > CONFIG_KPC2000=y
> > > CONFIG_KPC2000_CORE=m
> > > CONFIG_KPC2000_SPI=m
> > > CONFIG_KPC2000_I2C=m
> > > CONFIG_KPC2000_DMA=m
> > > 
> > > #
> > > # ISDN CAPI drivers
> > > #
> > > CONFIG_CAPI_AVM=y
> > > CONFIG_ISDN_DRV_AVMB1_B1PCI=m
> > > CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
> > > CONFIG_ISDN_DRV_AVMB1_B1PCMCIA=m
> > > CONFIG_ISDN_DRV_AVMB1_AVM_CS=m
> > > CONFIG_ISDN_DRV_AVMB1_T1PCI=m
> > > CONFIG_ISDN_DRV_AVMB1_C4=m
> > > CONFIG_ISDN_DRV_GIGASET=m
> > > # CONFIG_GIGASET_CAPI is not set
> > > CONFIG_GIGASET_BASE=m
> > > CONFIG_GIGASET_M105=m
> > > CONFIG_GIGASET_M101=m
> > > # CONFIG_GIGASET_DEBUG is not set
> > > CONFIG_HYSDN=m
> > > CONFIG_HYSDN_CAPI=y
> > > # end of ISDN CAPI drivers
> > > 
> > > CONFIG_X86_PLATFORM_DEVICES=y
> > > CONFIG_ACER_WMI=m
> > > CONFIG_ACER_WIRELESS=m
> > > CONFIG_ACERHDF=m
> > > CONFIG_ALIENWARE_WMI=m
> > > CONFIG_ASUS_LAPTOP=m
> > > CONFIG_DCDBAS=m
> > > CONFIG_DELL_SMBIOS=m
> > > CONFIG_DELL_SMBIOS_WMI=y
> > > CONFIG_DELL_SMBIOS_SMM=y
> > > CONFIG_DELL_LAPTOP=m
> > > CONFIG_DELL_WMI=m
> > > CONFIG_DELL_WMI_DESCRIPTOR=m
> > > CONFIG_DELL_WMI_AIO=m
> > > CONFIG_DELL_WMI_LED=m
> > > CONFIG_DELL_SMO8800=m
> > > CONFIG_DELL_RBTN=m
> > > CONFIG_DELL_RBU=m
> > > CONFIG_DELL_UART_BACKLIGHT=m
> > > CONFIG_FUJITSU_LAPTOP=m
> > > CONFIG_FUJITSU_TABLET=m
> > > CONFIG_AMILO_RFKILL=m
> > > CONFIG_GPD_POCKET_FAN=m
> > > CONFIG_HP_ACCEL=m
> > > CONFIG_HP_WIRELESS=m
> > > CONFIG_HP_WMI=m
> > > CONFIG_LG_LAPTOP=m
> > > CONFIG_MSI_LAPTOP=m
> > > CONFIG_PANASONIC_LAPTOP=m
> > > CONFIG_COMPAL_LAPTOP=m
> > > CONFIG_SONY_LAPTOP=m
> > > CONFIG_SONYPI_COMPAT=y
> > > CONFIG_IDEAPAD_LAPTOP=m
> > > CONFIG_SURFACE3_WMI=m
> > > CONFIG_THINKPAD_ACPI=m
> > > CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
> > > CONFIG_THINKPAD_ACPI_DEBUGFACILITIES=y
> > > # CONFIG_THINKPAD_ACPI_DEBUG is not set
> > > # CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
> > > CONFIG_THINKPAD_ACPI_VIDEO=y
> > > CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
> > > CONFIG_SENSORS_HDAPS=m
> > > CONFIG_INTEL_MENLOW=m
> > > CONFIG_EEEPC_LAPTOP=m
> > > CONFIG_ASUS_WMI=m
> > > CONFIG_ASUS_NB_WMI=m
> > > CONFIG_EEEPC_WMI=m
> > > CONFIG_ASUS_WIRELESS=m
> > > CONFIG_ACPI_WMI=m
> > > CONFIG_WMI_BMOF=m
> > > CONFIG_INTEL_WMI_THUNDERBOLT=m
> > > CONFIG_XIAOMI_WMI=m
> > > CONFIG_MSI_WMI=m
> > > CONFIG_PEAQ_WMI=m
> > > CONFIG_TOPSTAR_LAPTOP=m
> > > CONFIG_ACPI_TOSHIBA=m
> > > CONFIG_TOSHIBA_BT_RFKILL=m
> > > CONFIG_TOSHIBA_HAPS=m
> > > # CONFIG_TOSHIBA_WMI is not set
> > > CONFIG_ACPI_CMPC=m
> > > CONFIG_INTEL_CHT_INT33FE=m
> > > CONFIG_INTEL_INT0002_VGPIO=m
> > > CONFIG_INTEL_HID_EVENT=m
> > > CONFIG_INTEL_VBTN=m
> > > CONFIG_INTEL_IPS=m
> > > CONFIG_INTEL_PMC_CORE=y
> > > CONFIG_IBM_RTL=m
> > > CONFIG_SAMSUNG_LAPTOP=m
> > > CONFIG_MXM_WMI=m
> > > CONFIG_INTEL_OAKTRAIL=m
> > > CONFIG_SAMSUNG_Q10=m
> > > CONFIG_APPLE_GMUX=m
> > > CONFIG_INTEL_RST=m
> > > CONFIG_INTEL_SMARTCONNECT=m
> > > CONFIG_INTEL_PMC_IPC=m
> > > CONFIG_INTEL_BXTWC_PMIC_TMU=m
> > > CONFIG_SURFACE_PRO3_BUTTON=m
> > > CONFIG_SURFACE_3_BUTTON=m
> > > CONFIG_INTEL_PUNIT_IPC=m
> > > CONFIG_INTEL_TELEMETRY=m
> > > CONFIG_MLX_PLATFORM=m
> > > CONFIG_INTEL_TURBO_MAX_3=y
> > > CONFIG_TOUCHSCREEN_DMI=y
> > > CONFIG_INTEL_CHTDC_TI_PWRBTN=m
> > > CONFIG_I2C_MULTI_INSTANTIATE=m
> > > CONFIG_INTEL_ATOMISP2_PM=m
> > > CONFIG_HUAWEI_WMI=m
> > > CONFIG_PCENGINES_APU2=m
> > > 
> > > #
> > > # Intel Speed Select Technology interface support
> > > #
> > > CONFIG_INTEL_SPEED_SELECT_INTERFACE=m
> > > # end of Intel Speed Select Technology interface support
> > > 
> > > CONFIG_PMC_ATOM=y
> > > CONFIG_CHROME_PLATFORMS=y
> > > CONFIG_CHROMEOS_LAPTOP=m
> > > CONFIG_CHROMEOS_PSTORE=m
> > > CONFIG_CHROMEOS_TBMC=m
> > > CONFIG_CROS_EC_I2C=m
> > > CONFIG_CROS_EC_ISHTP=m
> > > CONFIG_CROS_EC_SPI=m
> > > CONFIG_CROS_EC_LPC=m
> > > CONFIG_CROS_EC_PROTO=y
> > > CONFIG_CROS_KBD_LED_BACKLIGHT=m
> > > CONFIG_CROS_EC_LIGHTBAR=m
> > > CONFIG_CROS_EC_DEBUGFS=m
> > > CONFIG_CROS_EC_SYSFS=m
> > > CONFIG_CROS_USBPD_LOGGER=m
> > > CONFIG_WILCO_EC=m
> > > CONFIG_WILCO_EC_DEBUGFS=m
> > > CONFIG_WILCO_EC_EVENTS=m
> > > CONFIG_WILCO_EC_TELEMETRY=m
> > > CONFIG_MELLANOX_PLATFORM=y
> > > CONFIG_MLXREG_HOTPLUG=m
> > > CONFIG_MLXREG_IO=m
> > > CONFIG_CLKDEV_LOOKUP=y
> > > CONFIG_HAVE_CLK_PREPARE=y
> > > CONFIG_COMMON_CLK=y
> > > 
> > > #
> > > # Common Clock Framework
> > > #
> > > CONFIG_COMMON_CLK_WM831X=m
> > > CONFIG_COMMON_CLK_MAX9485=m
> > > CONFIG_COMMON_CLK_SI5341=m
> > > CONFIG_COMMON_CLK_SI5351=m
> > > CONFIG_COMMON_CLK_SI544=m
> > > CONFIG_COMMON_CLK_CDCE706=m
> > > CONFIG_COMMON_CLK_CS2000_CP=m
> > > CONFIG_COMMON_CLK_S2MPS11=m
> > > CONFIG_CLK_TWL6040=m
> > > CONFIG_COMMON_CLK_PALMAS=m
> > > CONFIG_COMMON_CLK_PWM=m
> > > # end of Common Clock Framework
> > > 
> > > CONFIG_HWSPINLOCK=y
> > > 
> > > #
> > > # Clock Source drivers
> > > #
> > > CONFIG_CLKEVT_I8253=y
> > > CONFIG_I8253_LOCK=y
> > > CONFIG_CLKBLD_I8253=y
> > > # end of Clock Source drivers
> > > 
> > > CONFIG_MAILBOX=y
> > > CONFIG_PCC=y
> > > CONFIG_ALTERA_MBOX=m
> > > CONFIG_IOMMU_IOVA=y
> > > CONFIG_IOMMU_API=y
> > > CONFIG_IOMMU_SUPPORT=y
> > > 
> > > #
> > > # Generic IOMMU Pagetable Support
> > > #
> > > # end of Generic IOMMU Pagetable Support
> > > 
> > > # CONFIG_IOMMU_DEBUGFS is not set
> > > # CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
> > > CONFIG_AMD_IOMMU=y
> > > CONFIG_AMD_IOMMU_V2=m
> > > CONFIG_DMAR_TABLE=y
> > > CONFIG_INTEL_IOMMU=y
> > > CONFIG_INTEL_IOMMU_SVM=y
> > > # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
> > > CONFIG_INTEL_IOMMU_FLOPPY_WA=y
> > > CONFIG_IRQ_REMAP=y
> > > CONFIG_HYPERV_IOMMU=y
> > > 
> > > #
> > > # Remoteproc drivers
> > > #
> > > CONFIG_REMOTEPROC=m
> > > # end of Remoteproc drivers
> > > 
> > > #
> > > # Rpmsg drivers
> > > #
> > > CONFIG_RPMSG=m
> > > CONFIG_RPMSG_CHAR=m
> > > CONFIG_RPMSG_QCOM_GLINK_NATIVE=m
> > > CONFIG_RPMSG_QCOM_GLINK_RPM=m
> > > CONFIG_RPMSG_VIRTIO=m
> > > # end of Rpmsg drivers
> > > 
> > > CONFIG_SOUNDWIRE=y
> > > 
> > > #
> > > # SoundWire Devices
> > > #
> > > CONFIG_SOUNDWIRE_CADENCE=m
> > > CONFIG_SOUNDWIRE_INTEL=m
> > > 
> > > #
> > > # SOC (System On Chip) specific Drivers
> > > #
> > > 
> > > #
> > > # Amlogic SoC drivers
> > > #
> > > # end of Amlogic SoC drivers
> > > 
> > > #
> > > # Aspeed SoC drivers
> > > #
> > > # end of Aspeed SoC drivers
> > > 
> > > #
> > > # Broadcom SoC drivers
> > > #
> > > # end of Broadcom SoC drivers
> > > 
> > > #
> > > # NXP/Freescale QorIQ SoC drivers
> > > #
> > > # end of NXP/Freescale QorIQ SoC drivers
> > > 
> > > #
> > > # i.MX SoC drivers
> > > #
> > > # end of i.MX SoC drivers
> > > 
> > > #
> > > # Qualcomm SoC drivers
> > > #
> > > # end of Qualcomm SoC drivers
> > > 
> > > CONFIG_SOC_TI=y
> > > 
> > > #
> > > # Xilinx SoC drivers
> > > #
> > > CONFIG_XILINX_VCU=m
> > > # end of Xilinx SoC drivers
> > > # end of SOC (System On Chip) specific Drivers
> > > 
> > > CONFIG_PM_DEVFREQ=y
> > > 
> > > #
> > > # DEVFREQ Governors
> > > #
> > > CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
> > > CONFIG_DEVFREQ_GOV_PERFORMANCE=y
> > > CONFIG_DEVFREQ_GOV_POWERSAVE=y
> > > CONFIG_DEVFREQ_GOV_USERSPACE=y
> > > CONFIG_DEVFREQ_GOV_PASSIVE=y
> > > 
> > > #
> > > # DEVFREQ Drivers
> > > #
> > > CONFIG_PM_DEVFREQ_EVENT=y
> > > CONFIG_EXTCON=y
> > > 
> > > #
> > > # Extcon Device Drivers
> > > #
> > > CONFIG_EXTCON_ADC_JACK=m
> > > CONFIG_EXTCON_ARIZONA=m
> > > CONFIG_EXTCON_AXP288=m
> > > CONFIG_EXTCON_FSA9480=m
> > > CONFIG_EXTCON_GPIO=m
> > > CONFIG_EXTCON_INTEL_INT3496=m
> > > CONFIG_EXTCON_INTEL_CHT_WC=m
> > > CONFIG_EXTCON_MAX14577=m
> > > CONFIG_EXTCON_MAX3355=m
> > > CONFIG_EXTCON_MAX77693=m
> > > CONFIG_EXTCON_MAX77843=m
> > > CONFIG_EXTCON_MAX8997=m
> > > CONFIG_EXTCON_PALMAS=m
> > > CONFIG_EXTCON_PTN5150=m
> > > CONFIG_EXTCON_RT8973A=m
> > > CONFIG_EXTCON_SM5502=m
> > > CONFIG_EXTCON_USB_GPIO=m
> > > CONFIG_EXTCON_USBC_CROS_EC=m
> > > CONFIG_MEMORY=y
> > > CONFIG_IIO=m
> > > CONFIG_IIO_BUFFER=y
> > > CONFIG_IIO_BUFFER_CB=m
> > > CONFIG_IIO_BUFFER_HW_CONSUMER=m
> > > CONFIG_IIO_KFIFO_BUF=m
> > > CONFIG_IIO_TRIGGERED_BUFFER=m
> > > CONFIG_IIO_CONFIGFS=m
> > > CONFIG_IIO_TRIGGER=y
> > > CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> > > CONFIG_IIO_SW_DEVICE=m
> > > CONFIG_IIO_SW_TRIGGER=m
> > > CONFIG_IIO_TRIGGERED_EVENT=m
> > > 
> > > #
> > > # Accelerometers
> > > #
> > > CONFIG_ADIS16201=m
> > > CONFIG_ADIS16209=m
> > > CONFIG_ADXL372=m
> > > CONFIG_ADXL372_SPI=m
> > > CONFIG_ADXL372_I2C=m
> > > CONFIG_BMA180=m
> > > CONFIG_BMA220=m
> > > CONFIG_BMC150_ACCEL=m
> > > CONFIG_BMC150_ACCEL_I2C=m
> > > CONFIG_BMC150_ACCEL_SPI=m
> > > CONFIG_DA280=m
> > > CONFIG_DA311=m
> > > CONFIG_DMARD09=m
> > > CONFIG_DMARD10=m
> > > CONFIG_HID_SENSOR_ACCEL_3D=m
> > > CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
> > > CONFIG_IIO_ST_ACCEL_3AXIS=m
> > > CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
> > > CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
> > > CONFIG_KXSD9=m
> > > CONFIG_KXSD9_SPI=m
> > > CONFIG_KXSD9_I2C=m
> > > CONFIG_KXCJK1013=m
> > > CONFIG_MC3230=m
> > > CONFIG_MMA7455=m
> > > CONFIG_MMA7455_I2C=m
> > > CONFIG_MMA7455_SPI=m
> > > CONFIG_MMA7660=m
> > > CONFIG_MMA8452=m
> > > CONFIG_MMA9551_CORE=m
> > > CONFIG_MMA9551=m
> > > CONFIG_MMA9553=m
> > > CONFIG_MXC4005=m
> > > CONFIG_MXC6255=m
> > > CONFIG_SCA3000=m
> > > CONFIG_STK8312=m
> > > CONFIG_STK8BA50=m
> > > # end of Accelerometers
> > > 
> > > #
> > > # Analog to digital converters
> > > #
> > > CONFIG_AD_SIGMA_DELTA=m
> > > CONFIG_AD7124=m
> > > CONFIG_AD7266=m
> > > CONFIG_AD7291=m
> > > CONFIG_AD7298=m
> > > CONFIG_AD7476=m
> > > CONFIG_AD7606=m
> > > CONFIG_AD7606_IFACE_PARALLEL=m
> > > CONFIG_AD7606_IFACE_SPI=m
> > > CONFIG_AD7766=m
> > > CONFIG_AD7768_1=m
> > > CONFIG_AD7780=m
> > > CONFIG_AD7791=m
> > > CONFIG_AD7793=m
> > > CONFIG_AD7887=m
> > > CONFIG_AD7923=m
> > > CONFIG_AD7949=m
> > > CONFIG_AD799X=m
> > > CONFIG_AXP20X_ADC=m
> > > CONFIG_AXP288_ADC=m
> > > CONFIG_CC10001_ADC=m
> > > CONFIG_DA9150_GPADC=m
> > > CONFIG_DLN2_ADC=m
> > > CONFIG_HI8435=m
> > > CONFIG_HX711=m
> > > CONFIG_INA2XX_ADC=m
> > > CONFIG_LP8788_ADC=m
> > > CONFIG_LTC2471=m
> > > CONFIG_LTC2485=m
> > > CONFIG_LTC2497=m
> > > CONFIG_MAX1027=m
> > > CONFIG_MAX11100=m
> > > CONFIG_MAX1118=m
> > > CONFIG_MAX1363=m
> > > CONFIG_MAX9611=m
> > > CONFIG_MCP320X=m
> > > CONFIG_MCP3422=m
> > > CONFIG_MCP3911=m
> > > CONFIG_MEN_Z188_ADC=m
> > > CONFIG_NAU7802=m
> > > CONFIG_PALMAS_GPADC=m
> > > CONFIG_QCOM_VADC_COMMON=m
> > > CONFIG_QCOM_SPMI_IADC=m
> > > CONFIG_QCOM_SPMI_VADC=m
> > > CONFIG_QCOM_SPMI_ADC5=m
> > > CONFIG_STX104=m
> > > CONFIG_TI_ADC081C=m
> > > CONFIG_TI_ADC0832=m
> > > CONFIG_TI_ADC084S021=m
> > > CONFIG_TI_ADC12138=m
> > > CONFIG_TI_ADC108S102=m
> > > CONFIG_TI_ADC128S052=m
> > > CONFIG_TI_ADC161S626=m
> > > CONFIG_TI_ADS1015=m
> > > CONFIG_TI_ADS7950=m
> > > CONFIG_TI_AM335X_ADC=m
> > > CONFIG_TI_TLC4541=m
> > > CONFIG_TWL4030_MADC=m
> > > CONFIG_TWL6030_GPADC=m
> > > CONFIG_VIPERBOARD_ADC=m
> > > CONFIG_XILINX_XADC=m
> > > # end of Analog to digital converters
> > > 
> > > #
> > > # Analog Front Ends
> > > #
> > > # end of Analog Front Ends
> > > 
> > > #
> > > # Amplifiers
> > > #
> > > CONFIG_AD8366=m
> > > # end of Amplifiers
> > > 
> > > #
> > > # Chemical Sensors
> > > #
> > > CONFIG_ATLAS_PH_SENSOR=m
> > > CONFIG_BME680=m
> > > CONFIG_BME680_I2C=m
> > > CONFIG_BME680_SPI=m
> > > CONFIG_CCS811=m
> > > CONFIG_IAQCORE=m
> > > CONFIG_PMS7003=m
> > > CONFIG_SENSIRION_SGP30=m
> > > CONFIG_SPS30=m
> > > CONFIG_VZ89X=m
> > > # end of Chemical Sensors
> > > 
> > > CONFIG_IIO_CROS_EC_SENSORS_CORE=m
> > > CONFIG_IIO_CROS_EC_SENSORS=m
> > > CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE=m
> > > 
> > > #
> > > # Hid Sensor IIO Common
> > > #
> > > CONFIG_HID_SENSOR_IIO_COMMON=m
> > > CONFIG_HID_SENSOR_IIO_TRIGGER=m
> > > # end of Hid Sensor IIO Common
> > > 
> > > CONFIG_IIO_MS_SENSORS_I2C=m
> > > 
> > > #
> > > # SSP Sensor Common
> > > #
> > > CONFIG_IIO_SSP_SENSORS_COMMONS=m
> > > CONFIG_IIO_SSP_SENSORHUB=m
> > > # end of SSP Sensor Common
> > > 
> > > CONFIG_IIO_ST_SENSORS_I2C=m
> > > CONFIG_IIO_ST_SENSORS_SPI=m
> > > CONFIG_IIO_ST_SENSORS_CORE=m
> > > 
> > > #
> > > # Digital to analog converters
> > > #
> > > CONFIG_AD5064=m
> > > CONFIG_AD5360=m
> > > CONFIG_AD5380=m
> > > CONFIG_AD5421=m
> > > CONFIG_AD5446=m
> > > CONFIG_AD5449=m
> > > CONFIG_AD5592R_BASE=m
> > > CONFIG_AD5592R=m
> > > CONFIG_AD5593R=m
> > > CONFIG_AD5504=m
> > > CONFIG_AD5624R_SPI=m
> > > CONFIG_LTC1660=m
> > > CONFIG_LTC2632=m
> > > CONFIG_AD5686=m
> > > CONFIG_AD5686_SPI=m
> > > CONFIG_AD5696_I2C=m
> > > CONFIG_AD5755=m
> > > CONFIG_AD5758=m
> > > CONFIG_AD5761=m
> > > CONFIG_AD5764=m
> > > CONFIG_AD5791=m
> > > CONFIG_AD7303=m
> > > CONFIG_CIO_DAC=m
> > > CONFIG_AD8801=m
> > > CONFIG_DS4424=m
> > > CONFIG_M62332=m
> > > CONFIG_MAX517=m
> > > CONFIG_MCP4725=m
> > > CONFIG_MCP4922=m
> > > CONFIG_TI_DAC082S085=m
> > > CONFIG_TI_DAC5571=m
> > > CONFIG_TI_DAC7311=m
> > > CONFIG_TI_DAC7612=m
> > > # end of Digital to analog converters
> > > 
> > > #
> > > # IIO dummy driver
> > > #
> > > CONFIG_IIO_SIMPLE_DUMMY=m
> > > # CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
> > > # CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
> > > # end of IIO dummy driver
> > > 
> > > #
> > > # Frequency Synthesizers DDS/PLL
> > > #
> > > 
> > > #
> > > # Clock Generator/Distribution
> > > #
> > > CONFIG_AD9523=m
> > > # end of Clock Generator/Distribution
> > > 
> > > #
> > > # Phase-Locked Loop (PLL) frequency synthesizers
> > > #
> > > CONFIG_ADF4350=m
> > > CONFIG_ADF4371=m
> > > # end of Phase-Locked Loop (PLL) frequency synthesizers
> > > # end of Frequency Synthesizers DDS/PLL
> > > 
> > > #
> > > # Digital gyroscope sensors
> > > #
> > > CONFIG_ADIS16080=m
> > > CONFIG_ADIS16130=m
> > > CONFIG_ADIS16136=m
> > > CONFIG_ADIS16260=m
> > > CONFIG_ADXRS450=m
> > > CONFIG_BMG160=m
> > > CONFIG_BMG160_I2C=m
> > > CONFIG_BMG160_SPI=m
> > > CONFIG_FXAS21002C=m
> > > CONFIG_FXAS21002C_I2C=m
> > > CONFIG_FXAS21002C_SPI=m
> > > CONFIG_HID_SENSOR_GYRO_3D=m
> > > CONFIG_MPU3050=m
> > > CONFIG_MPU3050_I2C=m
> > > CONFIG_IIO_ST_GYRO_3AXIS=m
> > > CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
> > > CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
> > > CONFIG_ITG3200=m
> > > # end of Digital gyroscope sensors
> > > 
> > > #
> > > # Health Sensors
> > > #
> > > 
> > > #
> > > # Heart Rate Monitors
> > > #
> > > CONFIG_AFE4403=m
> > > CONFIG_AFE4404=m
> > > CONFIG_MAX30100=m
> > > CONFIG_MAX30102=m
> > > # end of Heart Rate Monitors
> > > # end of Health Sensors
> > > 
> > > #
> > > # Humidity sensors
> > > #
> > > CONFIG_AM2315=m
> > > CONFIG_DHT11=m
> > > CONFIG_HDC100X=m
> > > CONFIG_HID_SENSOR_HUMIDITY=m
> > > CONFIG_HTS221=m
> > > CONFIG_HTS221_I2C=m
> > > CONFIG_HTS221_SPI=m
> > > CONFIG_HTU21=m
> > > CONFIG_SI7005=m
> > > CONFIG_SI7020=m
> > > # end of Humidity sensors
> > > 
> > > #
> > > # Inertial measurement units
> > > #
> > > CONFIG_ADIS16400=m
> > > CONFIG_ADIS16480=m
> > > CONFIG_BMI160=m
> > > CONFIG_BMI160_I2C=m
> > > CONFIG_BMI160_SPI=m
> > > CONFIG_KMX61=m
> > > CONFIG_INV_MPU6050_IIO=m
> > > CONFIG_INV_MPU6050_I2C=m
> > > CONFIG_INV_MPU6050_SPI=m
> > > CONFIG_IIO_ST_LSM6DSX=m
> > > CONFIG_IIO_ST_LSM6DSX_I2C=m
> > > CONFIG_IIO_ST_LSM6DSX_SPI=m
> > > # end of Inertial measurement units
> > > 
> > > CONFIG_IIO_ADIS_LIB=m
> > > CONFIG_IIO_ADIS_LIB_BUFFER=y
> > > 
> > > #
> > > # Light sensors
> > > #
> > > CONFIG_ACPI_ALS=m
> > > CONFIG_ADJD_S311=m
> > > CONFIG_AL3320A=m
> > > CONFIG_APDS9300=m
> > > CONFIG_APDS9960=m
> > > CONFIG_BH1750=m
> > > CONFIG_BH1780=m
> > > CONFIG_CM32181=m
> > > CONFIG_CM3232=m
> > > CONFIG_CM3323=m
> > > CONFIG_CM36651=m
> > > CONFIG_IIO_CROS_EC_LIGHT_PROX=m
> > > CONFIG_GP2AP020A00F=m
> > > CONFIG_SENSORS_ISL29018=m
> > > CONFIG_SENSORS_ISL29028=m
> > > CONFIG_ISL29125=m
> > > CONFIG_HID_SENSOR_ALS=m
> > > CONFIG_HID_SENSOR_PROX=m
> > > CONFIG_JSA1212=m
> > > CONFIG_RPR0521=m
> > > CONFIG_SENSORS_LM3533=m
> > > CONFIG_LTR501=m
> > > CONFIG_LV0104CS=m
> > > CONFIG_MAX44000=m
> > > CONFIG_MAX44009=m
> > > CONFIG_OPT3001=m
> > > CONFIG_PA12203001=m
> > > CONFIG_SI1133=m
> > > CONFIG_SI1145=m
> > > CONFIG_STK3310=m
> > > CONFIG_ST_UVIS25=m
> > > CONFIG_ST_UVIS25_I2C=m
> > > CONFIG_ST_UVIS25_SPI=m
> > > CONFIG_TCS3414=m
> > > CONFIG_TCS3472=m
> > > CONFIG_SENSORS_TSL2563=m
> > > CONFIG_TSL2583=m
> > > CONFIG_TSL2772=m
> > > CONFIG_TSL4531=m
> > > CONFIG_US5182D=m
> > > CONFIG_VCNL4000=m
> > > CONFIG_VCNL4035=m
> > > CONFIG_VEML6070=m
> > > CONFIG_VL6180=m
> > > CONFIG_ZOPT2201=m
> > > # end of Light sensors
> > > 
> > > #
> > > # Magnetometer sensors
> > > #
> > > CONFIG_AK8975=m
> > > CONFIG_AK09911=m
> > > CONFIG_BMC150_MAGN=m
> > > CONFIG_BMC150_MAGN_I2C=m
> > > CONFIG_BMC150_MAGN_SPI=m
> > > CONFIG_MAG3110=m
> > > CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
> > > CONFIG_MMC35240=m
> > > CONFIG_IIO_ST_MAGN_3AXIS=m
> > > CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
> > > CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
> > > CONFIG_SENSORS_HMC5843=m
> > > CONFIG_SENSORS_HMC5843_I2C=m
> > > CONFIG_SENSORS_HMC5843_SPI=m
> > > CONFIG_SENSORS_RM3100=m
> > > CONFIG_SENSORS_RM3100_I2C=m
> > > CONFIG_SENSORS_RM3100_SPI=m
> > > # end of Magnetometer sensors
> > > 
> > > #
> > > # Multiplexers
> > > #
> > > # end of Multiplexers
> > > 
> > > #
> > > # Inclinometer sensors
> > > #
> > > CONFIG_HID_SENSOR_INCLINOMETER_3D=m
> > > CONFIG_HID_SENSOR_DEVICE_ROTATION=m
> > > # end of Inclinometer sensors
> > > 
> > > #
> > > # Triggers - standalone
> > > #
> > > CONFIG_IIO_HRTIMER_TRIGGER=m
> > > CONFIG_IIO_INTERRUPT_TRIGGER=m
> > > CONFIG_IIO_TIGHTLOOP_TRIGGER=m
> > > CONFIG_IIO_SYSFS_TRIGGER=m
> > > # end of Triggers - standalone
> > > 
> > > #
> > > # Digital potentiometers
> > > #
> > > CONFIG_AD5272=m
> > > CONFIG_DS1803=m
> > > CONFIG_MAX5481=m
> > > CONFIG_MAX5487=m
> > > CONFIG_MCP4018=m
> > > CONFIG_MCP4131=m
> > > CONFIG_MCP4531=m
> > > CONFIG_MCP41010=m
> > > CONFIG_TPL0102=m
> > > # end of Digital potentiometers
> > > 
> > > #
> > > # Digital potentiostats
> > > #
> > > CONFIG_LMP91000=m
> > > # end of Digital potentiostats
> > > 
> > > #
> > > # Pressure sensors
> > > #
> > > CONFIG_ABP060MG=m
> > > CONFIG_BMP280=m
> > > CONFIG_BMP280_I2C=m
> > > CONFIG_BMP280_SPI=m
> > > CONFIG_IIO_CROS_EC_BARO=m
> > > CONFIG_DPS310=m
> > > CONFIG_HID_SENSOR_PRESS=m
> > > CONFIG_HP03=m
> > > CONFIG_MPL115=m
> > > CONFIG_MPL115_I2C=m
> > > CONFIG_MPL115_SPI=m
> > > CONFIG_MPL3115=m
> > > CONFIG_MS5611=m
> > > CONFIG_MS5611_I2C=m
> > > CONFIG_MS5611_SPI=m
> > > CONFIG_MS5637=m
> > > CONFIG_IIO_ST_PRESS=m
> > > CONFIG_IIO_ST_PRESS_I2C=m
> > > CONFIG_IIO_ST_PRESS_SPI=m
> > > CONFIG_T5403=m
> > > CONFIG_HP206C=m
> > > CONFIG_ZPA2326=m
> > > CONFIG_ZPA2326_I2C=m
> > > CONFIG_ZPA2326_SPI=m
> > > # end of Pressure sensors
> > > 
> > > #
> > > # Lightning sensors
> > > #
> > > CONFIG_AS3935=m
> > > # end of Lightning sensors
> > > 
> > > #
> > > # Proximity and distance sensors
> > > #
> > > CONFIG_ISL29501=m
> > > CONFIG_LIDAR_LITE_V2=m
> > > CONFIG_MB1232=m
> > > CONFIG_RFD77402=m
> > > CONFIG_SRF04=m
> > > CONFIG_SX9500=m
> > > CONFIG_SRF08=m
> > > CONFIG_VL53L0X_I2C=m
> > > # end of Proximity and distance sensors
> > > 
> > > #
> > > # Resolver to digital converters
> > > #
> > > CONFIG_AD2S90=m
> > > CONFIG_AD2S1200=m
> > > # end of Resolver to digital converters
> > > 
> > > #
> > > # Temperature sensors
> > > #
> > > CONFIG_MAXIM_THERMOCOUPLE=m
> > > CONFIG_HID_SENSOR_TEMP=m
> > > CONFIG_MLX90614=m
> > > CONFIG_MLX90632=m
> > > CONFIG_TMP006=m
> > > CONFIG_TMP007=m
> > > CONFIG_TSYS01=m
> > > CONFIG_TSYS02D=m
> > > CONFIG_MAX31856=m
> > > # end of Temperature sensors
> > > 
> > > CONFIG_NTB=m
> > > CONFIG_NTB_MSI=y
> > > # CONFIG_NTB_AMD is not set
> > > CONFIG_NTB_IDT=m
> > > CONFIG_NTB_INTEL=m
> > > CONFIG_NTB_SWITCHTEC=m
> > > CONFIG_NTB_PINGPONG=m
> > > CONFIG_NTB_TOOL=m
> > > CONFIG_NTB_PERF=m
> > > # CONFIG_NTB_MSI_TEST is not set
> > > CONFIG_NTB_TRANSPORT=m
> > > CONFIG_VME_BUS=y
> > > 
> > > #
> > > # VME Bridge Drivers
> > > #
> > > CONFIG_VME_CA91CX42=m
> > > CONFIG_VME_TSI148=m
> > > CONFIG_VME_FAKE=m
> > > 
> > > #
> > > # VME Board Drivers
> > > #
> > > CONFIG_VMIVME_7805=m
> > > 
> > > #
> > > # VME Device Drivers
> > > #
> > > CONFIG_VME_USER=m
> > > CONFIG_PWM=y
> > > CONFIG_PWM_SYSFS=y
> > > CONFIG_PWM_CRC=y
> > > CONFIG_PWM_CROS_EC=m
> > > CONFIG_PWM_LP3943=m
> > > CONFIG_PWM_LPSS=y
> > > CONFIG_PWM_LPSS_PCI=y
> > > CONFIG_PWM_LPSS_PLATFORM=y
> > > CONFIG_PWM_PCA9685=m
> > > CONFIG_PWM_TWL=m
> > > CONFIG_PWM_TWL_LED=m
> > > 
> > > #
> > > # IRQ chip support
> > > #
> > > CONFIG_MADERA_IRQ=m
> > > # end of IRQ chip support
> > > 
> > > CONFIG_IPACK_BUS=m
> > > CONFIG_BOARD_TPCI200=m
> > > CONFIG_SERIAL_IPOCTAL=m
> > > CONFIG_RESET_CONTROLLER=y
> > > CONFIG_RESET_TI_SYSCON=m
> > > 
> > > #
> > > # PHY Subsystem
> > > #
> > > CONFIG_GENERIC_PHY=y
> > > CONFIG_BCM_KONA_USB2_PHY=m
> > > CONFIG_PHY_PXA_28NM_HSIC=m
> > > CONFIG_PHY_PXA_28NM_USB2=m
> > > CONFIG_PHY_CPCAP_USB=m
> > > CONFIG_PHY_QCOM_USB_HS=m
> > > CONFIG_PHY_QCOM_USB_HSIC=m
> > > CONFIG_PHY_SAMSUNG_USB2=m
> > > CONFIG_PHY_TUSB1210=m
> > > # end of PHY Subsystem
> > > 
> > > CONFIG_POWERCAP=y
> > > CONFIG_INTEL_RAPL_CORE=m
> > > CONFIG_INTEL_RAPL=m
> > > CONFIG_IDLE_INJECT=y
> > > CONFIG_MCB=m
> > > CONFIG_MCB_PCI=m
> > > CONFIG_MCB_LPC=m
> > > 
> > > #
> > > # Performance monitor support
> > > #
> > > # end of Performance monitor support
> > > 
> > > CONFIG_RAS=y
> > > CONFIG_RAS_CEC=y
> > > # CONFIG_RAS_CEC_DEBUG is not set
> > > CONFIG_THUNDERBOLT=m
> > > 
> > > #
> > > # Android
> > > #
> > > CONFIG_ANDROID=y
> > > CONFIG_ANDROID_BINDER_IPC=m
> > > CONFIG_ANDROID_BINDERFS=m
> > > CONFIG_ANDROID_BINDER_DEVICES=""
> > > # CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
> > > # end of Android
> > > 
> > > CONFIG_LIBNVDIMM=y
> > > CONFIG_BLK_DEV_PMEM=m
> > > CONFIG_ND_BLK=m
> > > CONFIG_ND_CLAIM=y
> > > CONFIG_ND_BTT=m
> > > CONFIG_BTT=y
> > > CONFIG_ND_PFN=m
> > > CONFIG_NVDIMM_PFN=y
> > > CONFIG_NVDIMM_DAX=y
> > > CONFIG_NVDIMM_KEYS=y
> > > CONFIG_DAX_DRIVER=y
> > > CONFIG_DAX=y
> > > CONFIG_DEV_DAX=m
> > > CONFIG_DEV_DAX_PMEM=m
> > > CONFIG_DEV_DAX_KMEM=m
> > > CONFIG_DEV_DAX_PMEM_COMPAT=m
> > > CONFIG_NVMEM=y
> > > CONFIG_NVMEM_SYSFS=y
> > > CONFIG_RAVE_SP_EEPROM=m
> > > 
> > > #
> > > # HW tracing support
> > > #
> > > CONFIG_STM=m
> > > CONFIG_STM_PROTO_BASIC=m
> > > CONFIG_STM_PROTO_SYS_T=m
> > > CONFIG_STM_DUMMY=m
> > > CONFIG_STM_SOURCE_CONSOLE=m
> > > CONFIG_STM_SOURCE_HEARTBEAT=m
> > > CONFIG_STM_SOURCE_FTRACE=m
> > > CONFIG_INTEL_TH=m
> > > CONFIG_INTEL_TH_PCI=m
> > > CONFIG_INTEL_TH_ACPI=m
> > > CONFIG_INTEL_TH_GTH=m
> > > CONFIG_INTEL_TH_STH=m
> > > CONFIG_INTEL_TH_MSU=m
> > > CONFIG_INTEL_TH_PTI=m
> > > # CONFIG_INTEL_TH_DEBUG is not set
> > > # end of HW tracing support
> > > 
> > > CONFIG_FPGA=m
> > > CONFIG_ALTERA_PR_IP_CORE=m
> > > CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
> > > CONFIG_FPGA_MGR_ALTERA_CVP=m
> > > CONFIG_FPGA_MGR_XILINX_SPI=m
> > > CONFIG_FPGA_MGR_MACHXO2_SPI=m
> > > CONFIG_FPGA_BRIDGE=m
> > > CONFIG_ALTERA_FREEZE_BRIDGE=m
> > > CONFIG_XILINX_PR_DECOUPLER=m
> > > CONFIG_FPGA_REGION=m
> > > CONFIG_FPGA_DFL=m
> > > CONFIG_FPGA_DFL_FME=m
> > > CONFIG_FPGA_DFL_FME_MGR=m
> > > CONFIG_FPGA_DFL_FME_BRIDGE=m
> > > CONFIG_FPGA_DFL_FME_REGION=m
> > > CONFIG_FPGA_DFL_AFU=m
> > > CONFIG_FPGA_DFL_PCI=m
> > > CONFIG_PM_OPP=y
> > > CONFIG_UNISYS_VISORBUS=m
> > > CONFIG_SIOX=m
> > > CONFIG_SIOX_BUS_GPIO=m
> > > CONFIG_SLIMBUS=m
> > > CONFIG_SLIM_QCOM_CTRL=m
> > > CONFIG_INTERCONNECT=m
> > > CONFIG_COUNTER=m
> > > CONFIG_104_QUAD_8=m
> > > # end of Device Drivers
> > > 
> > > #
> > > # Ubuntu Supplied Third-Party Device Drivers
> > > #
> > > CONFIG_HIO=m
> > > # end of Ubuntu Supplied Third-Party Device Drivers
> > > 
> > > #
> > > # File systems
> > > #
> > > CONFIG_DCACHE_WORD_ACCESS=y
> > > CONFIG_VALIDATE_FS_PARSER=y
> > > CONFIG_FS_IOMAP=y
> > > # CONFIG_EXT2_FS is not set
> > > # CONFIG_EXT3_FS is not set
> > > CONFIG_EXT4_FS=y
> > > CONFIG_EXT4_USE_FOR_EXT2=y
> > > CONFIG_EXT4_FS_POSIX_ACL=y
> > > CONFIG_EXT4_FS_SECURITY=y
> > > # CONFIG_EXT4_DEBUG is not set
> > > CONFIG_JBD2=y
> > > # CONFIG_JBD2_DEBUG is not set
> > > CONFIG_FS_MBCACHE=y
> > > CONFIG_REISERFS_FS=m
> > > # CONFIG_REISERFS_CHECK is not set
> > > # CONFIG_REISERFS_PROC_INFO is not set
> > > CONFIG_REISERFS_FS_XATTR=y
> > > CONFIG_REISERFS_FS_POSIX_ACL=y
> > > CONFIG_REISERFS_FS_SECURITY=y
> > > CONFIG_JFS_FS=m
> > > CONFIG_JFS_POSIX_ACL=y
> > > CONFIG_JFS_SECURITY=y
> > > # CONFIG_JFS_DEBUG is not set
> > > CONFIG_JFS_STATISTICS=y
> > > CONFIG_XFS_FS=m
> > > CONFIG_XFS_QUOTA=y
> > > CONFIG_XFS_POSIX_ACL=y
> > > CONFIG_XFS_RT=y
> > > # CONFIG_XFS_ONLINE_SCRUB is not set
> > > # CONFIG_XFS_WARN is not set
> > > # CONFIG_XFS_DEBUG is not set
> > > CONFIG_GFS2_FS=m
> > > CONFIG_GFS2_FS_LOCKING_DLM=y
> > > CONFIG_OCFS2_FS=m
> > > CONFIG_OCFS2_FS_O2CB=m
> > > CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
> > > CONFIG_OCFS2_FS_STATS=y
> > > CONFIG_OCFS2_DEBUG_MASKLOG=y
> > > # CONFIG_OCFS2_DEBUG_FS is not set
> > > CONFIG_BTRFS_FS=m
> > > CONFIG_BTRFS_FS_POSIX_ACL=y
> > > # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> > > # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> > > # CONFIG_BTRFS_DEBUG is not set
> > > # CONFIG_BTRFS_ASSERT is not set
> > > # CONFIG_BTRFS_FS_REF_VERIFY is not set
> > > CONFIG_NILFS2_FS=m
> > > CONFIG_F2FS_FS=m
> > > CONFIG_F2FS_STAT_FS=y
> > > CONFIG_F2FS_FS_XATTR=y
> > > CONFIG_F2FS_FS_POSIX_ACL=y
> > > CONFIG_F2FS_FS_SECURITY=y
> > > # CONFIG_F2FS_CHECK_FS is not set
> > > # CONFIG_F2FS_IO_TRACE is not set
> > > # CONFIG_F2FS_FAULT_INJECTION is not set
> > > CONFIG_FS_DAX=y
> > > CONFIG_FS_DAX_PMD=y
> > > CONFIG_FS_POSIX_ACL=y
> > > CONFIG_EXPORTFS=y
> > > CONFIG_EXPORTFS_BLOCK_OPS=y
> > > CONFIG_FILE_LOCKING=y
> > > CONFIG_MANDATORY_FILE_LOCKING=y
> > > CONFIG_FS_ENCRYPTION=y
> > > CONFIG_FSNOTIFY=y
> > > CONFIG_DNOTIFY=y
> > > CONFIG_INOTIFY_USER=y
> > > CONFIG_FANOTIFY=y
> > > CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
> > > CONFIG_QUOTA=y
> > > CONFIG_QUOTA_NETLINK_INTERFACE=y
> > > # CONFIG_PRINT_QUOTA_WARNING is not set
> > > # CONFIG_QUOTA_DEBUG is not set
> > > CONFIG_QUOTA_TREE=m
> > > CONFIG_QFMT_V1=m
> > > CONFIG_QFMT_V2=m
> > > CONFIG_QUOTACTL=y
> > > CONFIG_QUOTACTL_COMPAT=y
> > > CONFIG_AUTOFS4_FS=m
> > > CONFIG_AUTOFS_FS=m
> > > CONFIG_FUSE_FS=y
> > > CONFIG_CUSE=m
> > > CONFIG_OVERLAY_FS=m
> > > # CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
> > > CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
> > > # CONFIG_OVERLAY_FS_INDEX is not set
> > > CONFIG_OVERLAY_FS_XINO_AUTO=y
> > > # CONFIG_OVERLAY_FS_METACOPY is not set
> > > CONFIG_SHIFT_FS=m
> > > CONFIG_SHIFT_FS_POSIX_ACL=y
> > > 
> > > #
> > > # Caches
> > > #
> > > CONFIG_FSCACHE=m
> > > CONFIG_FSCACHE_STATS=y
> > > # CONFIG_FSCACHE_HISTOGRAM is not set
> > > # CONFIG_FSCACHE_DEBUG is not set
> > > # CONFIG_FSCACHE_OBJECT_LIST is not set
> > > CONFIG_CACHEFILES=m
> > > # CONFIG_CACHEFILES_DEBUG is not set
> > > # CONFIG_CACHEFILES_HISTOGRAM is not set
> > > # end of Caches
> > > 
> > > #
> > > # CD-ROM/DVD Filesystems
> > > #
> > > CONFIG_ISO9660_FS=m
> > > CONFIG_JOLIET=y
> > > CONFIG_ZISOFS=y
> > > CONFIG_UDF_FS=m
> > > # end of CD-ROM/DVD Filesystems
> > > 
> > > #
> > > # DOS/FAT/NT Filesystems
> > > #
> > > CONFIG_FAT_FS=y
> > > CONFIG_MSDOS_FS=m
> > > CONFIG_VFAT_FS=y
> > > CONFIG_FAT_DEFAULT_CODEPAGE=437
> > > CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> > > # CONFIG_FAT_DEFAULT_UTF8 is not set
> > > CONFIG_NTFS_FS=m
> > > # CONFIG_NTFS_DEBUG is not set
> > > # CONFIG_NTFS_RW is not set
> > > # end of DOS/FAT/NT Filesystems
> > > 
> > > #
> > > # Pseudo filesystems
> > > #
> > > CONFIG_PROC_FS=y
> > > CONFIG_PROC_KCORE=y
> > > CONFIG_PROC_VMCORE=y
> > > CONFIG_PROC_VMCORE_DEVICE_DUMP=y
> > > CONFIG_PROC_SYSCTL=y
> > > CONFIG_PROC_PAGE_MONITOR=y
> > > CONFIG_PROC_CHILDREN=y
> > > CONFIG_PROC_PID_ARCH_STATUS=y
> > > CONFIG_KERNFS=y
> > > CONFIG_SYSFS=y
> > > CONFIG_TMPFS=y
> > > CONFIG_TMPFS_POSIX_ACL=y
> > > CONFIG_TMPFS_XATTR=y
> > > CONFIG_HUGETLBFS=y
> > > CONFIG_HUGETLB_PAGE=y
> > > CONFIG_MEMFD_CREATE=y
> > > CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
> > > CONFIG_CONFIGFS_FS=y
> > > CONFIG_EFIVAR_FS=y
> > > # end of Pseudo filesystems
> > > 
> > > CONFIG_MISC_FILESYSTEMS=y
> > > CONFIG_ORANGEFS_FS=m
> > > CONFIG_ADFS_FS=m
> > > # CONFIG_ADFS_FS_RW is not set
> > > CONFIG_AFFS_FS=m
> > > CONFIG_ECRYPT_FS=y
> > > CONFIG_ECRYPT_FS_MESSAGING=y
> > > CONFIG_HFS_FS=m
> > > CONFIG_HFSPLUS_FS=m
> > > CONFIG_BEFS_FS=m
> > > # CONFIG_BEFS_DEBUG is not set
> > > CONFIG_BFS_FS=m
> > > CONFIG_EFS_FS=m
> > > CONFIG_JFFS2_FS=m
> > > CONFIG_JFFS2_FS_DEBUG=0
> > > CONFIG_JFFS2_FS_WRITEBUFFER=y
> > > # CONFIG_JFFS2_FS_WBUF_VERIFY is not set
> > > # CONFIG_JFFS2_SUMMARY is not set
> > > CONFIG_JFFS2_FS_XATTR=y
> > > CONFIG_JFFS2_FS_POSIX_ACL=y
> > > CONFIG_JFFS2_FS_SECURITY=y
> > > CONFIG_JFFS2_COMPRESSION_OPTIONS=y
> > > CONFIG_JFFS2_ZLIB=y
> > > CONFIG_JFFS2_LZO=y
> > > CONFIG_JFFS2_RTIME=y
> > > # CONFIG_JFFS2_RUBIN is not set
> > > # CONFIG_JFFS2_CMODE_NONE is not set
> > > # CONFIG_JFFS2_CMODE_PRIORITY is not set
> > > # CONFIG_JFFS2_CMODE_SIZE is not set
> > > CONFIG_JFFS2_CMODE_FAVOURLZO=y
> > > CONFIG_UBIFS_FS=m
> > > # CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
> > > CONFIG_UBIFS_FS_LZO=y
> > > CONFIG_UBIFS_FS_ZLIB=y
> > > CONFIG_UBIFS_FS_ZSTD=y
> > > # CONFIG_UBIFS_ATIME_SUPPORT is not set
> > > CONFIG_UBIFS_FS_XATTR=y
> > > CONFIG_UBIFS_FS_SECURITY=y
> > > CONFIG_UBIFS_FS_AUTHENTICATION=y
> > > CONFIG_CRAMFS=m
> > > CONFIG_CRAMFS_BLOCKDEV=y
> > > CONFIG_CRAMFS_MTD=y
> > > CONFIG_SQUASHFS=y
> > > # CONFIG_SQUASHFS_FILE_CACHE is not set
> > > CONFIG_SQUASHFS_FILE_DIRECT=y
> > > CONFIG_SQUASHFS_DECOMP_SINGLE=y
> > > # CONFIG_SQUASHFS_DECOMP_MULTI is not set
> > > # CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
> > > CONFIG_SQUASHFS_XATTR=y
> > > CONFIG_SQUASHFS_ZLIB=y
> > > CONFIG_SQUASHFS_LZ4=y
> > > CONFIG_SQUASHFS_LZO=y
> > > CONFIG_SQUASHFS_XZ=y
> > > CONFIG_SQUASHFS_ZSTD=y
> > > # CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
> > > # CONFIG_SQUASHFS_EMBEDDED is not set
> > > CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
> > > CONFIG_VXFS_FS=m
> > > CONFIG_MINIX_FS=m
> > > CONFIG_OMFS_FS=m
> > > CONFIG_HPFS_FS=m
> > > CONFIG_QNX4FS_FS=m
> > > CONFIG_QNX6FS_FS=m
> > > # CONFIG_QNX6FS_DEBUG is not set
> > > CONFIG_ROMFS_FS=m
> > > CONFIG_ROMFS_BACKED_BY_BLOCK=y
> > > # CONFIG_ROMFS_BACKED_BY_MTD is not set
> > > # CONFIG_ROMFS_BACKED_BY_BOTH is not set
> > > CONFIG_ROMFS_ON_BLOCK=y
> > > CONFIG_PSTORE=y
> > > CONFIG_PSTORE_DEFLATE_COMPRESS=y
> > > # CONFIG_PSTORE_LZO_COMPRESS is not set
> > > # CONFIG_PSTORE_LZ4_COMPRESS is not set
> > > # CONFIG_PSTORE_LZ4HC_COMPRESS is not set
> > > # CONFIG_PSTORE_842_COMPRESS is not set
> > > # CONFIG_PSTORE_ZSTD_COMPRESS is not set
> > > CONFIG_PSTORE_COMPRESS=y
> > > CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
> > > CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
> > > # CONFIG_PSTORE_CONSOLE is not set
> > > # CONFIG_PSTORE_PMSG is not set
> > > # CONFIG_PSTORE_FTRACE is not set
> > > CONFIG_PSTORE_RAM=m
> > > CONFIG_SYSV_FS=m
> > > CONFIG_UFS_FS=m
> > > # CONFIG_UFS_FS_WRITE is not set
> > > # CONFIG_UFS_DEBUG is not set
> > > CONFIG_AUFS_FS=m
> > > CONFIG_AUFS_BRANCH_MAX_127=y
> > > # CONFIG_AUFS_BRANCH_MAX_511 is not set
> > > # CONFIG_AUFS_BRANCH_MAX_1023 is not set
> > > # CONFIG_AUFS_BRANCH_MAX_32767 is not set
> > > CONFIG_AUFS_SBILIST=y
> > > # CONFIG_AUFS_HNOTIFY is not set
> > > CONFIG_AUFS_EXPORT=y
> > > CONFIG_AUFS_INO_T_64=y
> > > CONFIG_AUFS_XATTR=y
> > > # CONFIG_AUFS_FHSM is not set
> > > # CONFIG_AUFS_RDU is not set
> > > CONFIG_AUFS_DIRREN=y
> > > # CONFIG_AUFS_SHWH is not set
> > > # CONFIG_AUFS_BR_RAMFS is not set
> > > # CONFIG_AUFS_BR_FUSE is not set
> > > CONFIG_AUFS_BR_HFSPLUS=y
> > > CONFIG_AUFS_BDEV_LOOP=y
> > > # CONFIG_AUFS_DEBUG is not set
> > > CONFIG_NETWORK_FILESYSTEMS=y
> > > CONFIG_NFS_FS=m
> > > CONFIG_NFS_V2=m
> > > CONFIG_NFS_V3=m
> > > CONFIG_NFS_V3_ACL=y
> > > CONFIG_NFS_V4=m
> > > CONFIG_NFS_SWAP=y
> > > CONFIG_NFS_V4_1=y
> > > CONFIG_NFS_V4_2=y
> > > CONFIG_PNFS_FILE_LAYOUT=m
> > > CONFIG_PNFS_BLOCK=m
> > > CONFIG_PNFS_FLEXFILE_LAYOUT=m
> > > CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
> > > CONFIG_NFS_V4_1_MIGRATION=y
> > > CONFIG_NFS_V4_SECURITY_LABEL=y
> > > CONFIG_NFS_FSCACHE=y
> > > # CONFIG_NFS_USE_LEGACY_DNS is not set
> > > CONFIG_NFS_USE_KERNEL_DNS=y
> > > CONFIG_NFS_DEBUG=y
> > > CONFIG_NFSD=m
> > > CONFIG_NFSD_V2_ACL=y
> > > CONFIG_NFSD_V3=y
> > > CONFIG_NFSD_V3_ACL=y
> > > CONFIG_NFSD_V4=y
> > > CONFIG_NFSD_PNFS=y
> > > CONFIG_NFSD_BLOCKLAYOUT=y
> > > CONFIG_NFSD_SCSILAYOUT=y
> > > CONFIG_NFSD_FLEXFILELAYOUT=y
> > > CONFIG_NFSD_V4_SECURITY_LABEL=y
> > > # CONFIG_NFSD_FAULT_INJECTION is not set
> > > CONFIG_GRACE_PERIOD=m
> > > CONFIG_LOCKD=m
> > > CONFIG_LOCKD_V4=y
> > > CONFIG_NFS_ACL_SUPPORT=m
> > > CONFIG_NFS_COMMON=y
> > > CONFIG_SUNRPC=m
> > > CONFIG_SUNRPC_GSS=m
> > > CONFIG_SUNRPC_BACKCHANNEL=y
> > > CONFIG_SUNRPC_SWAP=y
> > > CONFIG_RPCSEC_GSS_KRB5=m
> > > # CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
> > > CONFIG_SUNRPC_DEBUG=y
> > > CONFIG_SUNRPC_XPRT_RDMA=m
> > > CONFIG_CEPH_FS=m
> > > CONFIG_CEPH_FSCACHE=y
> > > CONFIG_CEPH_FS_POSIX_ACL=y
> > > CONFIG_CEPH_FS_SECURITY_LABEL=y
> > > CONFIG_CIFS=m
> > > # CONFIG_CIFS_STATS2 is not set
> > > CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
> > > CONFIG_CIFS_WEAK_PW_HASH=y
> > > CONFIG_CIFS_UPCALL=y
> > > CONFIG_CIFS_XATTR=y
> > > CONFIG_CIFS_POSIX=y
> > > CONFIG_CIFS_DEBUG=y
> > > # CONFIG_CIFS_DEBUG2 is not set
> > > # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> > > CONFIG_CIFS_DFS_UPCALL=y
> > > # CONFIG_CIFS_SMB_DIRECT is not set
> > > CONFIG_CIFS_FSCACHE=y
> > > CONFIG_CODA_FS=m
> > > CONFIG_AFS_FS=m
> > > # CONFIG_AFS_DEBUG is not set
> > > CONFIG_AFS_FSCACHE=y
> > > # CONFIG_AFS_DEBUG_CURSOR is not set
> > > CONFIG_9P_FS=m
> > > CONFIG_9P_FSCACHE=y
> > > CONFIG_9P_FS_POSIX_ACL=y
> > > CONFIG_9P_FS_SECURITY=y
> > > CONFIG_NLS=y
> > > CONFIG_NLS_DEFAULT="utf8"
> > > CONFIG_NLS_CODEPAGE_437=y
> > > CONFIG_NLS_CODEPAGE_737=m
> > > CONFIG_NLS_CODEPAGE_775=m
> > > CONFIG_NLS_CODEPAGE_850=m
> > > CONFIG_NLS_CODEPAGE_852=m
> > > CONFIG_NLS_CODEPAGE_855=m
> > > CONFIG_NLS_CODEPAGE_857=m
> > > CONFIG_NLS_CODEPAGE_860=m
> > > CONFIG_NLS_CODEPAGE_861=m
> > > CONFIG_NLS_CODEPAGE_862=m
> > > CONFIG_NLS_CODEPAGE_863=m
> > > CONFIG_NLS_CODEPAGE_864=m
> > > CONFIG_NLS_CODEPAGE_865=m
> > > CONFIG_NLS_CODEPAGE_866=m
> > > CONFIG_NLS_CODEPAGE_869=m
> > > CONFIG_NLS_CODEPAGE_936=m
> > > CONFIG_NLS_CODEPAGE_950=m
> > > CONFIG_NLS_CODEPAGE_932=m
> > > CONFIG_NLS_CODEPAGE_949=m
> > > CONFIG_NLS_CODEPAGE_874=m
> > > CONFIG_NLS_ISO8859_8=m
> > > CONFIG_NLS_CODEPAGE_1250=m
> > > CONFIG_NLS_CODEPAGE_1251=m
> > > CONFIG_NLS_ASCII=m
> > > CONFIG_NLS_ISO8859_1=m
> > > CONFIG_NLS_ISO8859_2=m
> > > CONFIG_NLS_ISO8859_3=m
> > > CONFIG_NLS_ISO8859_4=m
> > > CONFIG_NLS_ISO8859_5=m
> > > CONFIG_NLS_ISO8859_6=m
> > > CONFIG_NLS_ISO8859_7=m
> > > CONFIG_NLS_ISO8859_9=m
> > > CONFIG_NLS_ISO8859_13=m
> > > CONFIG_NLS_ISO8859_14=m
> > > CONFIG_NLS_ISO8859_15=m
> > > CONFIG_NLS_KOI8_R=m
> > > CONFIG_NLS_KOI8_U=m
> > > CONFIG_NLS_MAC_ROMAN=m
> > > CONFIG_NLS_MAC_CELTIC=m
> > > CONFIG_NLS_MAC_CENTEURO=m
> > > CONFIG_NLS_MAC_CROATIAN=m
> > > CONFIG_NLS_MAC_CYRILLIC=m
> > > CONFIG_NLS_MAC_GAELIC=m
> > > CONFIG_NLS_MAC_GREEK=m
> > > CONFIG_NLS_MAC_ICELAND=m
> > > CONFIG_NLS_MAC_INUIT=m
> > > CONFIG_NLS_MAC_ROMANIAN=m
> > > CONFIG_NLS_MAC_TURKISH=m
> > > CONFIG_NLS_UTF8=m
> > > CONFIG_DLM=m
> > > # CONFIG_DLM_DEBUG is not set
> > > CONFIG_UNICODE=y
> > > # CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
> > > # end of File systems
> > > 
> > > #
> > > # Security options
> > > #
> > > CONFIG_KEYS=y
> > > CONFIG_KEYS_COMPAT=y
> > > CONFIG_KEYS_REQUEST_CACHE=y
> > > CONFIG_PERSISTENT_KEYRINGS=y
> > > CONFIG_BIG_KEYS=y
> > > CONFIG_TRUSTED_KEYS=y
> > > CONFIG_ENCRYPTED_KEYS=y
> > > CONFIG_KEY_DH_OPERATIONS=y
> > > # CONFIG_SECURITY_DMESG_RESTRICT is not set
> > > CONFIG_SECURITY_PERF_EVENTS_RESTRICT=y
> > > CONFIG_SECURITY=y
> > > CONFIG_SECURITYFS=y
> > > CONFIG_SECURITY_NETWORK=y
> > > CONFIG_PAGE_TABLE_ISOLATION=y
> > > CONFIG_SECURITY_INFINIBAND=y
> > > CONFIG_SECURITY_NETWORK_XFRM=y
> > > CONFIG_SECURITY_PATH=y
> > > CONFIG_INTEL_TXT=y
> > > CONFIG_LSM_MMAP_MIN_ADDR=0
> > > CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> > > CONFIG_HARDENED_USERCOPY=y
> > > CONFIG_HARDENED_USERCOPY_FALLBACK=y
> > > # CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
> > > CONFIG_FORTIFY_SOURCE=y
> > > # CONFIG_STATIC_USERMODEHELPER is not set
> > > CONFIG_LOCK_DOWN_KERNEL=y
> > > # CONFIG_LOCK_DOWN_KERNEL_FORCE is not set
> > > CONFIG_ALLOW_LOCKDOWN_LIFT_BY_SYSRQ=y
> > > CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT=y
> > > CONFIG_SECURITY_SELINUX=y
> > > CONFIG_SECURITY_SELINUX_BOOTPARAM=y
> > > # CONFIG_SECURITY_SELINUX_DISABLE is not set
> > > CONFIG_SECURITY_SELINUX_DEVELOP=y
> > > CONFIG_SECURITY_SELINUX_AVC_STATS=y
> > > CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
> > > CONFIG_SECURITY_SMACK=y
> > > # CONFIG_SECURITY_SMACK_BRINGUP is not set
> > > CONFIG_SECURITY_SMACK_NETFILTER=y
> > > CONFIG_SECURITY_SMACK_APPEND_SIGNALS=y
> > > CONFIG_SECURITY_TOMOYO=y
> > > CONFIG_SECURITY_TOMOYO_MAX_ACCEPT_ENTRY=2048
> > > CONFIG_SECURITY_TOMOYO_MAX_AUDIT_LOG=1024
> > > # CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER is not set
> > > CONFIG_SECURITY_TOMOYO_POLICY_LOADER="/sbin/tomoyo-init"
> > > CONFIG_SECURITY_TOMOYO_ACTIVATION_TRIGGER="/sbin/init"
> > > # CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING is not set
> > > CONFIG_SECURITY_APPARMOR=y
> > > CONFIG_SECURITY_APPARMOR_HASH=y
> > > CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
> > > # CONFIG_SECURITY_APPARMOR_DEBUG is not set
> > > # CONFIG_SECURITY_LOADPIN is not set
> > > CONFIG_SECURITY_YAMA=y
> > > CONFIG_SECURITY_SAFESETID=y
> > > CONFIG_INTEGRITY=y
> > > CONFIG_INTEGRITY_SIGNATURE=y
> > > CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
> > > CONFIG_INTEGRITY_TRUSTED_KEYRING=y
> > > CONFIG_INTEGRITY_PLATFORM_KEYRING=y
> > > CONFIG_LOAD_UEFI_KEYS=y
> > > CONFIG_INTEGRITY_AUDIT=y
> > > CONFIG_IMA=y
> > > CONFIG_IMA_MEASURE_PCR_IDX=10
> > > CONFIG_IMA_LSM_RULES=y
> > > # CONFIG_IMA_TEMPLATE is not set
> > > CONFIG_IMA_NG_TEMPLATE=y
> > > # CONFIG_IMA_SIG_TEMPLATE is not set
> > > CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
> > > CONFIG_IMA_DEFAULT_HASH_SHA1=y
> > > # CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
> > > # CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
> > > CONFIG_IMA_DEFAULT_HASH="sha1"
> > > # CONFIG_IMA_WRITE_POLICY is not set
> > > # CONFIG_IMA_READ_POLICY is not set
> > > CONFIG_IMA_APPRAISE=y
> > > # CONFIG_IMA_ARCH_POLICY is not set
> > > # CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
> > > CONFIG_IMA_APPRAISE_BOOTPARAM=y
> > > CONFIG_IMA_TRUSTED_KEYRING=y
> > > # CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not set
> > > # CONFIG_IMA_BLACKLIST_KEYRING is not set
> > > # CONFIG_IMA_LOAD_X509 is not set
> > > CONFIG_EVM=y
> > > CONFIG_EVM_ATTR_FSUUID=y
> > > CONFIG_EVM_EXTRA_SMACK_XATTRS=y
> > > CONFIG_EVM_ADD_XATTRS=y
> > > # CONFIG_EVM_LOAD_X509 is not set
> > > # CONFIG_DEFAULT_SECURITY_SELINUX is not set
> > > # CONFIG_DEFAULT_SECURITY_SMACK is not set
> > > # CONFIG_DEFAULT_SECURITY_TOMOYO is not set
> > > CONFIG_DEFAULT_SECURITY_APPARMOR=y
> > > # CONFIG_DEFAULT_SECURITY_DAC is not set
> > > CONFIG_LSM="yama,integrity,apparmor"
> > > 
> > > #
> > > # Kernel hardening options
> > > #
> > > 
> > > #
> > > # Memory initialization
> > > #
> > > CONFIG_INIT_STACK_NONE=y
> > > CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
> > > # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> > > # end of Memory initialization
> > > # end of Kernel hardening options
> > > # end of Security options
> > > 
> > > CONFIG_XOR_BLOCKS=m
> > > CONFIG_ASYNC_CORE=m
> > > CONFIG_ASYNC_MEMCPY=m
> > > CONFIG_ASYNC_XOR=m
> > > CONFIG_ASYNC_PQ=m
> > > CONFIG_ASYNC_RAID6_RECOV=m
> > > CONFIG_CRYPTO=y
> > > 
> > > #
> > > # Crypto core or helper
> > > #
> > > CONFIG_CRYPTO_ALGAPI=y
> > > CONFIG_CRYPTO_ALGAPI2=y
> > > CONFIG_CRYPTO_AEAD=y
> > > CONFIG_CRYPTO_AEAD2=y
> > > CONFIG_CRYPTO_BLKCIPHER=y
> > > CONFIG_CRYPTO_BLKCIPHER2=y
> > > CONFIG_CRYPTO_HASH=y
> > > CONFIG_CRYPTO_HASH2=y
> > > CONFIG_CRYPTO_RNG=y
> > > CONFIG_CRYPTO_RNG2=y
> > > CONFIG_CRYPTO_RNG_DEFAULT=y
> > > CONFIG_CRYPTO_AKCIPHER2=y
> > > CONFIG_CRYPTO_AKCIPHER=y
> > > CONFIG_CRYPTO_KPP2=y
> > > CONFIG_CRYPTO_KPP=y
> > > CONFIG_CRYPTO_ACOMP2=y
> > > CONFIG_CRYPTO_MANAGER=y
> > > CONFIG_CRYPTO_MANAGER2=y
> > > CONFIG_CRYPTO_USER=m
> > > CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> > > CONFIG_CRYPTO_GF128MUL=y
> > > CONFIG_CRYPTO_NULL=y
> > > CONFIG_CRYPTO_NULL2=y
> > > CONFIG_CRYPTO_PCRYPT=m
> > > CONFIG_CRYPTO_CRYPTD=m
> > > CONFIG_CRYPTO_AUTHENC=m
> > > CONFIG_CRYPTO_TEST=m
> > > CONFIG_CRYPTO_SIMD=m
> > > CONFIG_CRYPTO_GLUE_HELPER_X86=m
> > > CONFIG_CRYPTO_ENGINE=m
> > > 
> > > #
> > > # Public-key cryptography
> > > #
> > > CONFIG_CRYPTO_RSA=y
> > > CONFIG_CRYPTO_DH=y
> > > CONFIG_CRYPTO_ECC=m
> > > CONFIG_CRYPTO_ECDH=m
> > > CONFIG_CRYPTO_ECRDSA=m
> > > 
> > > #
> > > # Authenticated Encryption with Associated Data
> > > #
> > > CONFIG_CRYPTO_CCM=m
> > > CONFIG_CRYPTO_GCM=y
> > > CONFIG_CRYPTO_CHACHA20POLY1305=m
> > > CONFIG_CRYPTO_AEGIS128=m
> > > CONFIG_CRYPTO_AEGIS128L=m
> > > CONFIG_CRYPTO_AEGIS256=m
> > > CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=m
> > > CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2=m
> > > CONFIG_CRYPTO_AEGIS256_AESNI_SSE2=m
> > > CONFIG_CRYPTO_MORUS640=m
> > > CONFIG_CRYPTO_MORUS640_GLUE=m
> > > CONFIG_CRYPTO_MORUS640_SSE2=m
> > > CONFIG_CRYPTO_MORUS1280=m
> > > CONFIG_CRYPTO_MORUS1280_GLUE=m
> > > CONFIG_CRYPTO_MORUS1280_SSE2=m
> > > CONFIG_CRYPTO_MORUS1280_AVX2=m
> > > CONFIG_CRYPTO_SEQIV=y
> > > CONFIG_CRYPTO_ECHAINIV=m
> > > 
> > > #
> > > # Block modes
> > > #
> > > CONFIG_CRYPTO_CBC=y
> > > CONFIG_CRYPTO_CFB=m
> > > CONFIG_CRYPTO_CTR=y
> > > CONFIG_CRYPTO_CTS=y
> > > CONFIG_CRYPTO_ECB=y
> > > CONFIG_CRYPTO_LRW=m
> > > CONFIG_CRYPTO_OFB=m
> > > CONFIG_CRYPTO_PCBC=m
> > > CONFIG_CRYPTO_XTS=y
> > > CONFIG_CRYPTO_KEYWRAP=m
> > > CONFIG_CRYPTO_NHPOLY1305=m
> > > CONFIG_CRYPTO_NHPOLY1305_SSE2=m
> > > CONFIG_CRYPTO_NHPOLY1305_AVX2=m
> > > CONFIG_CRYPTO_ADIANTUM=m
> > > 
> > > #
> > > # Hash modes
> > > #
> > > CONFIG_CRYPTO_CMAC=m
> > > CONFIG_CRYPTO_HMAC=y
> > > CONFIG_CRYPTO_XCBC=m
> > > CONFIG_CRYPTO_VMAC=m
> > > 
> > > #
> > > # Digest
> > > #
> > > CONFIG_CRYPTO_CRC32C=y
> > > CONFIG_CRYPTO_CRC32C_INTEL=y
> > > CONFIG_CRYPTO_CRC32=m
> > > CONFIG_CRYPTO_CRC32_PCLMUL=m
> > > CONFIG_CRYPTO_XXHASH=m
> > > CONFIG_CRYPTO_CRCT10DIF=y
> > > CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
> > > CONFIG_CRYPTO_GHASH=y
> > > CONFIG_CRYPTO_POLY1305=m
> > > CONFIG_CRYPTO_POLY1305_X86_64=m
> > > CONFIG_CRYPTO_MD4=m
> > > CONFIG_CRYPTO_MD5=y
> > > CONFIG_CRYPTO_MICHAEL_MIC=m
> > > CONFIG_CRYPTO_RMD128=m
> > > CONFIG_CRYPTO_RMD160=m
> > > CONFIG_CRYPTO_RMD256=m
> > > CONFIG_CRYPTO_RMD320=m
> > > CONFIG_CRYPTO_SHA1=y
> > > CONFIG_CRYPTO_SHA1_SSSE3=m
> > > CONFIG_CRYPTO_SHA256_SSSE3=m
> > > CONFIG_CRYPTO_SHA512_SSSE3=m
> > > CONFIG_CRYPTO_SHA256=y
> > > CONFIG_CRYPTO_SHA512=y
> > > CONFIG_CRYPTO_SHA3=m
> > > CONFIG_CRYPTO_SM3=m
> > > CONFIG_CRYPTO_STREEBOG=m
> > > CONFIG_CRYPTO_TGR192=m
> > > CONFIG_CRYPTO_WP512=m
> > > CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
> > > 
> > > #
> > > # Ciphers
> > > #
> > > CONFIG_CRYPTO_AES=y
> > > CONFIG_CRYPTO_AES_TI=m
> > > CONFIG_CRYPTO_AES_X86_64=m
> > > CONFIG_CRYPTO_AES_NI_INTEL=m
> > > CONFIG_CRYPTO_ANUBIS=m
> > > CONFIG_CRYPTO_LIB_ARC4=m
> > > CONFIG_CRYPTO_ARC4=m
> > > CONFIG_CRYPTO_BLOWFISH=m
> > > CONFIG_CRYPTO_BLOWFISH_COMMON=m
> > > CONFIG_CRYPTO_BLOWFISH_X86_64=m
> > > CONFIG_CRYPTO_CAMELLIA=m
> > > CONFIG_CRYPTO_CAMELLIA_X86_64=m
> > > CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
> > > CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
> > > CONFIG_CRYPTO_CAST_COMMON=m
> > > CONFIG_CRYPTO_CAST5=m
> > > CONFIG_CRYPTO_CAST5_AVX_X86_64=m
> > > CONFIG_CRYPTO_CAST6=m
> > > CONFIG_CRYPTO_CAST6_AVX_X86_64=m
> > > CONFIG_CRYPTO_DES=m
> > > CONFIG_CRYPTO_DES3_EDE_X86_64=m
> > > CONFIG_CRYPTO_FCRYPT=m
> > > CONFIG_CRYPTO_KHAZAD=m
> > > CONFIG_CRYPTO_SALSA20=m
> > > CONFIG_CRYPTO_CHACHA20=m
> > > CONFIG_CRYPTO_CHACHA20_X86_64=m
> > > CONFIG_CRYPTO_SEED=m
> > > CONFIG_CRYPTO_SERPENT=m
> > > CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
> > > CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
> > > CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
> > > CONFIG_CRYPTO_SM4=m
> > > CONFIG_CRYPTO_TEA=m
> > > CONFIG_CRYPTO_TWOFISH=m
> > > CONFIG_CRYPTO_TWOFISH_COMMON=m
> > > CONFIG_CRYPTO_TWOFISH_X86_64=m
> > > CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
> > > CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
> > > 
> > > #
> > > # Compression
> > > #
> > > CONFIG_CRYPTO_DEFLATE=y
> > > CONFIG_CRYPTO_LZO=y
> > > CONFIG_CRYPTO_842=m
> > > CONFIG_CRYPTO_LZ4=m
> > > CONFIG_CRYPTO_LZ4HC=m
> > > CONFIG_CRYPTO_ZSTD=m
> > > 
> > > #
> > > # Random Number Generation
> > > #
> > > CONFIG_CRYPTO_ANSI_CPRNG=m
> > > CONFIG_CRYPTO_DRBG_MENU=y
> > > CONFIG_CRYPTO_DRBG_HMAC=y
> > > CONFIG_CRYPTO_DRBG_HASH=y
> > > CONFIG_CRYPTO_DRBG_CTR=y
> > > CONFIG_CRYPTO_DRBG=y
> > > CONFIG_CRYPTO_JITTERENTROPY=y
> > > CONFIG_CRYPTO_USER_API=m
> > > CONFIG_CRYPTO_USER_API_HASH=m
> > > CONFIG_CRYPTO_USER_API_SKCIPHER=m
> > > CONFIG_CRYPTO_USER_API_RNG=m
> > > CONFIG_CRYPTO_USER_API_AEAD=m
> > > CONFIG_CRYPTO_STATS=y
> > > CONFIG_CRYPTO_HASH_INFO=y
> > > CONFIG_CRYPTO_HW=y
> > > CONFIG_CRYPTO_DEV_PADLOCK=y
> > > CONFIG_CRYPTO_DEV_PADLOCK_AES=m
> > > CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
> > > CONFIG_CRYPTO_DEV_ATMEL_I2C=m
> > > CONFIG_CRYPTO_DEV_ATMEL_ECC=m
> > > CONFIG_CRYPTO_DEV_ATMEL_SHA204A=m
> > > CONFIG_CRYPTO_DEV_CCP=y
> > > CONFIG_CRYPTO_DEV_CCP_DD=m
> > > CONFIG_CRYPTO_DEV_SP_CCP=y
> > > CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
> > > CONFIG_CRYPTO_DEV_SP_PSP=y
> > > CONFIG_CRYPTO_DEV_QAT=m
> > > CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
> > > # CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
> > > # CONFIG_CRYPTO_DEV_QAT_C62X is not set
> > > CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
> > > # CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
> > > # CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
> > > CONFIG_CRYPTO_DEV_NITROX=m
> > > CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
> > > CONFIG_CRYPTO_DEV_CHELSIO=m
> > > CONFIG_CHELSIO_IPSEC_INLINE=y
> > > CONFIG_CRYPTO_DEV_CHELSIO_TLS=m
> > > CONFIG_CRYPTO_DEV_VIRTIO=m
> > > CONFIG_ASYMMETRIC_KEY_TYPE=y
> > > CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> > > CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE=m
> > > CONFIG_X509_CERTIFICATE_PARSER=y
> > > CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
> > > CONFIG_TPM_KEY_PARSER=m
> > > CONFIG_PKCS7_MESSAGE_PARSER=y
> > > CONFIG_PKCS7_TEST_KEY=m
> > > CONFIG_SIGNED_PE_FILE_VERIFICATION=y
> > > 
> > > #
> > > # Certificates for signature checking
> > > #
> > > CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
> > > CONFIG_SYSTEM_TRUSTED_KEYRING=y
> > > CONFIG_SYSTEM_TRUSTED_KEYS=""
> > > CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
> > > CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
> > > CONFIG_SECONDARY_TRUSTED_KEYRING=y
> > > CONFIG_SYSTEM_BLACKLIST_KEYRING=y
> > > CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
> > > # end of Certificates for signature checking
> > > 
> > > CONFIG_BINARY_PRINTF=y
> > > 
> > > #
> > > # Library routines
> > > #
> > > CONFIG_RAID6_PQ=m
> > > CONFIG_RAID6_PQ_BENCHMARK=y
> > > CONFIG_PACKING=y
> > > CONFIG_BITREVERSE=y
> > > CONFIG_GENERIC_STRNCPY_FROM_USER=y
> > > CONFIG_GENERIC_STRNLEN_USER=y
> > > CONFIG_GENERIC_NET_UTILS=y
> > > CONFIG_GENERIC_FIND_FIRST_BIT=y
> > > CONFIG_CORDIC=m
> > > CONFIG_RATIONAL=y
> > > CONFIG_GENERIC_PCI_IOMAP=y
> > > CONFIG_GENERIC_IOMAP=y
> > > CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
> > > CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> > > CONFIG_CRC_CCITT=y
> > > CONFIG_CRC16=y
> > > CONFIG_CRC_T10DIF=y
> > > CONFIG_CRC_ITU_T=m
> > > CONFIG_CRC32=y
> > > # CONFIG_CRC32_SELFTEST is not set
> > > CONFIG_CRC32_SLICEBY8=y
> > > # CONFIG_CRC32_SLICEBY4 is not set
> > > # CONFIG_CRC32_SARWATE is not set
> > > # CONFIG_CRC32_BIT is not set
> > > CONFIG_CRC64=m
> > > CONFIG_CRC4=m
> > > CONFIG_CRC7=m
> > > CONFIG_LIBCRC32C=m
> > > CONFIG_CRC8=m
> > > CONFIG_XXHASH=y
> > > # CONFIG_RANDOM32_SELFTEST is not set
> > > CONFIG_842_COMPRESS=m
> > > CONFIG_842_DECOMPRESS=m
> > > CONFIG_ZLIB_INFLATE=y
> > > CONFIG_ZLIB_DEFLATE=y
> > > CONFIG_LZO_COMPRESS=y
> > > CONFIG_LZO_DECOMPRESS=y
> > > CONFIG_LZ4_COMPRESS=m
> > > CONFIG_LZ4HC_COMPRESS=m
> > > CONFIG_LZ4_DECOMPRESS=y
> > > CONFIG_ZSTD_COMPRESS=m
> > > CONFIG_ZSTD_DECOMPRESS=y
> > > CONFIG_XZ_DEC=y
> > > CONFIG_XZ_DEC_X86=y
> > > CONFIG_XZ_DEC_POWERPC=y
> > > CONFIG_XZ_DEC_IA64=y
> > > CONFIG_XZ_DEC_ARM=y
> > > CONFIG_XZ_DEC_ARMTHUMB=y
> > > CONFIG_XZ_DEC_SPARC=y
> > > CONFIG_XZ_DEC_BCJ=y
> > > CONFIG_XZ_DEC_TEST=m
> > > CONFIG_DECOMPRESS_GZIP=y
> > > CONFIG_DECOMPRESS_BZIP2=y
> > > CONFIG_DECOMPRESS_LZMA=y
> > > CONFIG_DECOMPRESS_XZ=y
> > > CONFIG_DECOMPRESS_LZO=y
> > > CONFIG_DECOMPRESS_LZ4=y
> > > CONFIG_GENERIC_ALLOCATOR=y
> > > CONFIG_REED_SOLOMON=m
> > > CONFIG_REED_SOLOMON_ENC8=y
> > > CONFIG_REED_SOLOMON_DEC8=y
> > > CONFIG_REED_SOLOMON_DEC16=y
> > > CONFIG_BCH=m
> > > CONFIG_TEXTSEARCH=y
> > > CONFIG_TEXTSEARCH_KMP=m
> > > CONFIG_TEXTSEARCH_BM=m
> > > CONFIG_TEXTSEARCH_FSM=m
> > > CONFIG_BTREE=y
> > > CONFIG_INTERVAL_TREE=y
> > > CONFIG_XARRAY_MULTI=y
> > > CONFIG_ASSOCIATIVE_ARRAY=y
> > > CONFIG_HAS_IOMEM=y
> > > CONFIG_HAS_IOPORT_MAP=y
> > > CONFIG_HAS_DMA=y
> > > CONFIG_NEED_SG_DMA_LENGTH=y
> > > CONFIG_NEED_DMA_MAP_STATE=y
> > > CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> > > CONFIG_DMA_DECLARE_COHERENT=y
> > > CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
> > > CONFIG_DMA_VIRT_OPS=y
> > > CONFIG_SWIOTLB=y
> > > # CONFIG_DMA_CMA is not set
> > > # CONFIG_DMA_API_DEBUG is not set
> > > CONFIG_SGL_ALLOC=y
> > > CONFIG_IOMMU_HELPER=y
> > > CONFIG_CHECK_SIGNATURE=y
> > > CONFIG_CPUMASK_OFFSTACK=y
> > > CONFIG_CPU_RMAP=y
> > > CONFIG_DQL=y
> > > CONFIG_GLOB=y
> > > # CONFIG_GLOB_SELFTEST is not set
> > > CONFIG_NLATTR=y
> > > CONFIG_LRU_CACHE=m
> > > CONFIG_CLZ_TAB=y
> > > CONFIG_IRQ_POLL=y
> > > CONFIG_MPILIB=y
> > > CONFIG_SIGNATURE=y
> > > CONFIG_DIMLIB=y
> > > CONFIG_OID_REGISTRY=y
> > > CONFIG_UCS2_STRING=y
> > > CONFIG_HAVE_GENERIC_VDSO=y
> > > CONFIG_GENERIC_GETTIMEOFDAY=y
> > > CONFIG_FONT_SUPPORT=y
> > > CONFIG_FONTS=y
> > > CONFIG_FONT_8x8=y
> > > CONFIG_FONT_8x16=y
> > > # CONFIG_FONT_6x11 is not set
> > > # CONFIG_FONT_7x14 is not set
> > > # CONFIG_FONT_PEARL_8x8 is not set
> > > CONFIG_FONT_ACORN_8x8=y
> > > # CONFIG_FONT_MINI_4x6 is not set
> > > CONFIG_FONT_6x10=y
> > > # CONFIG_FONT_10x18 is not set
> > > # CONFIG_FONT_SUN8x16 is not set
> > > # CONFIG_FONT_SUN12x22 is not set
> > > CONFIG_FONT_TER16x32=y
> > > CONFIG_SG_POOL=y
> > > CONFIG_ARCH_HAS_PMEM_API=y
> > > CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
> > > CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
> > > CONFIG_ARCH_STACKWALK=y
> > > CONFIG_SBITMAP=y
> > > CONFIG_PARMAN=m
> > > CONFIG_OBJAGG=m
> > > # CONFIG_STRING_SELFTEST is not set
> > > # end of Library routines
> > > 
> > > #
> > > # Kernel hacking
> > > #
> > > 
> > > #
> > > # printk and dmesg options
> > > #
> > > CONFIG_PRINTK_TIME=y
> > > # CONFIG_PRINTK_CALLER is not set
> > > CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> > > CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> > > CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> > > CONFIG_BOOT_PRINTK_DELAY=y
> > > CONFIG_DYNAMIC_DEBUG=y
> > > # end of printk and dmesg options
> > > 
> > > #
> > > # Compile-time checks and compiler options
> > > #
> > > CONFIG_DEBUG_INFO=y
> > > # CONFIG_DEBUG_INFO_REDUCED is not set
> > > # CONFIG_DEBUG_INFO_SPLIT is not set
> > > CONFIG_DEBUG_INFO_DWARF4=y
> > > # CONFIG_DEBUG_INFO_BTF is not set
> > > CONFIG_GDB_SCRIPTS=y
> > > # CONFIG_ENABLE_MUST_CHECK is not set
> > > CONFIG_FRAME_WARN=1024
> > > # CONFIG_STRIP_ASM_SYMS is not set
> > > # CONFIG_READABLE_ASM is not set
> > > CONFIG_UNUSED_SYMBOLS=y
> > > CONFIG_DEBUG_FS=y
> > > # CONFIG_HEADERS_INSTALL is not set
> > > CONFIG_OPTIMIZE_INLINING=y
> > > # CONFIG_DEBUG_SECTION_MISMATCH is not set
> > > CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> > > CONFIG_FRAME_POINTER=y
> > > CONFIG_STACK_VALIDATION=y
> > > # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> > > # end of Compile-time checks and compiler options
> > > 
> > > CONFIG_MAGIC_SYSRQ=y
> > > CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x01b6
> > > CONFIG_MAGIC_SYSRQ_SERIAL=y
> > > CONFIG_DEBUG_KERNEL=y
> > > CONFIG_DEBUG_MISC=y
> > > 
> > > #
> > > # Memory Debugging
> > > #
> > > # CONFIG_PAGE_EXTENSION is not set
> > > # CONFIG_DEBUG_PAGEALLOC is not set
> > > # CONFIG_PAGE_OWNER is not set
> > > CONFIG_PAGE_POISONING=y
> > > CONFIG_PAGE_POISONING_NO_SANITY=y
> > > CONFIG_PAGE_POISONING_ZERO=y
> > > # CONFIG_DEBUG_PAGE_REF is not set
> > > # CONFIG_DEBUG_RODATA_TEST is not set
> > > # CONFIG_DEBUG_OBJECTS is not set
> > > # CONFIG_SLUB_DEBUG_ON is not set
> > > # CONFIG_SLUB_STATS is not set
> > > CONFIG_HAVE_DEBUG_KMEMLEAK=y
> > > # CONFIG_DEBUG_KMEMLEAK is not set
> > > # CONFIG_DEBUG_STACK_USAGE is not set
> > > # CONFIG_DEBUG_VM is not set
> > > CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> > > # CONFIG_DEBUG_VIRTUAL is not set
> > > # CONFIG_DEBUG_MEMORY_INIT is not set
> > > CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
> > > # CONFIG_DEBUG_PER_CPU_MAPS is not set
> > > CONFIG_HAVE_ARCH_KASAN=y
> > > CONFIG_CC_HAS_KASAN_GENERIC=y
> > > # CONFIG_KASAN is not set
> > > CONFIG_KASAN_STACK=1
> > > # end of Memory Debugging
> > > 
> > > CONFIG_ARCH_HAS_KCOV=y
> > > CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> > > # CONFIG_KCOV is not set
> > > # CONFIG_DEBUG_SHIRQ is not set
> > > 
> > > #
> > > # Debug Lockups and Hangs
> > > #
> > > CONFIG_LOCKUP_DETECTOR=y
> > > CONFIG_SOFTLOCKUP_DETECTOR=y
> > > # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> > > CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
> > > CONFIG_HARDLOCKUP_DETECTOR_PERF=y
> > > CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
> > > CONFIG_HARDLOCKUP_DETECTOR=y
> > > # CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
> > > CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
> > > CONFIG_DETECT_HUNG_TASK=y
> > > CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
> > > # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> > > CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
> > > # CONFIG_WQ_WATCHDOG is not set
> > > # end of Debug Lockups and Hangs
> > > 
> > > # CONFIG_PANIC_ON_OOPS is not set
> > > CONFIG_PANIC_ON_OOPS_VALUE=0
> > > CONFIG_PANIC_TIMEOUT=0
> > > CONFIG_SCHED_DEBUG=y
> > > CONFIG_SCHED_INFO=y
> > > CONFIG_SCHEDSTATS=y
> > > CONFIG_SCHED_STACK_END_CHECK=y
> > > # CONFIG_DEBUG_TIMEKEEPING is not set
> > > 
> > > #
> > > # Lock Debugging (spinlocks, mutexes, etc...)
> > > #
> > > CONFIG_LOCK_DEBUGGING_SUPPORT=y
> > > # CONFIG_PROVE_LOCKING is not set
> > > # CONFIG_LOCK_STAT is not set
> > > # CONFIG_DEBUG_RT_MUTEXES is not set
> > > # CONFIG_DEBUG_SPINLOCK is not set
> > > # CONFIG_DEBUG_MUTEXES is not set
> > > # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> > > # CONFIG_DEBUG_RWSEMS is not set
> > > # CONFIG_DEBUG_LOCK_ALLOC is not set
> > > # CONFIG_DEBUG_ATOMIC_SLEEP is not set
> > > # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> > > # CONFIG_LOCK_TORTURE_TEST is not set
> > > # CONFIG_WW_MUTEX_SELFTEST is not set
> > > # end of Lock Debugging (spinlocks, mutexes, etc...)
> > > 
> > > CONFIG_STACKTRACE=y
> > > # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> > > # CONFIG_DEBUG_KOBJECT is not set
> > > CONFIG_DEBUG_BUGVERBOSE=y
> > > # CONFIG_DEBUG_LIST is not set
> > > # CONFIG_DEBUG_PLIST is not set
> > > # CONFIG_DEBUG_SG is not set
> > > # CONFIG_DEBUG_NOTIFIERS is not set
> > > # CONFIG_DEBUG_CREDENTIALS is not set
> > > 
> > > #
> > > # RCU Debugging
> > > #
> > > CONFIG_TORTURE_TEST=m
> > > CONFIG_RCU_PERF_TEST=m
> > > # CONFIG_RCU_TORTURE_TEST is not set
> > > CONFIG_RCU_CPU_STALL_TIMEOUT=60
> > > # CONFIG_RCU_TRACE is not set
> > > # CONFIG_RCU_EQS_DEBUG is not set
> > > # end of RCU Debugging
> > > 
> > > # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> > > # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> > > # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> > > CONFIG_NOTIFIER_ERROR_INJECTION=m
> > > CONFIG_PM_NOTIFIER_ERROR_INJECT=m
> > > # CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
> > > CONFIG_FUNCTION_ERROR_INJECTION=y
> > > # CONFIG_FAULT_INJECTION is not set
> > > # CONFIG_LATENCYTOP is not set
> > > CONFIG_USER_STACKTRACE_SUPPORT=y
> > > CONFIG_NOP_TRACER=y
> > > CONFIG_HAVE_FUNCTION_TRACER=y
> > > CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> > > CONFIG_HAVE_DYNAMIC_FTRACE=y
> > > CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> > > CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> > > CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> > > CONFIG_HAVE_FENTRY=y
> > > CONFIG_HAVE_C_RECORDMCOUNT=y
> > > CONFIG_TRACER_MAX_TRACE=y
> > > CONFIG_TRACE_CLOCK=y
> > > CONFIG_RING_BUFFER=y
> > > CONFIG_EVENT_TRACING=y
> > > CONFIG_CONTEXT_SWITCH_TRACER=y
> > > CONFIG_RING_BUFFER_ALLOW_SWAP=y
> > > CONFIG_TRACING=y
> > > CONFIG_GENERIC_TRACER=y
> > > CONFIG_TRACING_SUPPORT=y
> > > CONFIG_FTRACE=y
> > > CONFIG_FUNCTION_TRACER=y
> > > CONFIG_FUNCTION_GRAPH_TRACER=y
> > > # CONFIG_PREEMPTIRQ_EVENTS is not set
> > > # CONFIG_IRQSOFF_TRACER is not set
> > > CONFIG_SCHED_TRACER=y
> > > CONFIG_HWLAT_TRACER=y
> > > CONFIG_FTRACE_SYSCALLS=y
> > > CONFIG_TRACER_SNAPSHOT=y
> > > # CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
> > > CONFIG_BRANCH_PROFILE_NONE=y
> > > # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> > > CONFIG_STACK_TRACER=y
> > > CONFIG_BLK_DEV_IO_TRACE=y
> > > CONFIG_KPROBE_EVENTS=y
> > > # CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
> > > CONFIG_UPROBE_EVENTS=y
> > > CONFIG_BPF_EVENTS=y
> > > CONFIG_DYNAMIC_EVENTS=y
> > > CONFIG_PROBE_EVENTS=y
> > > CONFIG_DYNAMIC_FTRACE=y
> > > CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
> > > CONFIG_FUNCTION_PROFILER=y
> > > CONFIG_BPF_KPROBE_OVERRIDE=y
> > > CONFIG_FTRACE_MCOUNT_RECORD=y
> > > # CONFIG_FTRACE_STARTUP_TEST is not set
> > > CONFIG_MMIOTRACE=y
> > > CONFIG_TRACING_MAP=y
> > > CONFIG_HIST_TRIGGERS=y
> > > # CONFIG_MMIOTRACE_TEST is not set
> > > # CONFIG_TRACEPOINT_BENCHMARK is not set
> > > # CONFIG_RING_BUFFER_BENCHMARK is not set
> > > # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> > > # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> > > # CONFIG_TRACE_EVAL_MAP_FILE is not set
> > > # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> > > CONFIG_RUNTIME_TESTING_MENU=y
> > > # CONFIG_LKDTM is not set
> > > # CONFIG_TEST_LIST_SORT is not set
> > > # CONFIG_TEST_SORT is not set
> > > # CONFIG_KPROBES_SANITY_TEST is not set
> > > # CONFIG_BACKTRACE_SELF_TEST is not set
> > > # CONFIG_RBTREE_TEST is not set
> > > # CONFIG_REED_SOLOMON_TEST is not set
> > > # CONFIG_INTERVAL_TREE_TEST is not set
> > > # CONFIG_PERCPU_TEST is not set
> > > # CONFIG_ATOMIC64_SELFTEST is not set
> > > # CONFIG_ASYNC_RAID6_TEST is not set
> > > # CONFIG_TEST_HEXDUMP is not set
> > > # CONFIG_TEST_STRING_HELPERS is not set
> > > # CONFIG_TEST_STRSCPY is not set
> > > # CONFIG_TEST_KSTRTOX is not set
> > > # CONFIG_TEST_PRINTF is not set
> > > # CONFIG_TEST_BITMAP is not set
> > > # CONFIG_TEST_BITFIELD is not set
> > > # CONFIG_TEST_UUID is not set
> > > # CONFIG_TEST_XARRAY is not set
> > > # CONFIG_TEST_OVERFLOW is not set
> > > # CONFIG_TEST_RHASHTABLE is not set
> > > # CONFIG_TEST_HASH is not set
> > > # CONFIG_TEST_IDA is not set
> > > # CONFIG_TEST_PARMAN is not set
> > > # CONFIG_TEST_LKM is not set
> > > # CONFIG_TEST_VMALLOC is not set
> > > # CONFIG_TEST_USER_COPY is not set
> > > CONFIG_TEST_BPF=m
> > > CONFIG_TEST_BLACKHOLE_DEV=m
> > > # CONFIG_FIND_BIT_BENCHMARK is not set
> > > # CONFIG_TEST_FIRMWARE is not set
> > > # CONFIG_TEST_SYSCTL is not set
> > > # CONFIG_TEST_UDELAY is not set
> > > # CONFIG_TEST_STATIC_KEYS is not set
> > > # CONFIG_TEST_KMOD is not set
> > > # CONFIG_TEST_MEMCAT_P is not set
> > > # CONFIG_TEST_LIVEPATCH is not set
> > > # CONFIG_TEST_OBJAGG is not set
> > > # CONFIG_TEST_STACKINIT is not set
> > > # CONFIG_TEST_MEMINIT is not set
> > > CONFIG_MEMTEST=y
> > > # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> > > CONFIG_SAMPLES=y
> > > # CONFIG_SAMPLE_TRACE_EVENTS is not set
> > > CONFIG_SAMPLE_TRACE_PRINTK=m
> > > # CONFIG_SAMPLE_KOBJECT is not set
> > > # CONFIG_SAMPLE_KPROBES is not set
> > > # CONFIG_SAMPLE_HW_BREAKPOINT is not set
> > > # CONFIG_SAMPLE_KFIFO is not set
> > > # CONFIG_SAMPLE_KDB is not set
> > > # CONFIG_SAMPLE_RPMSG_CLIENT is not set
> > > # CONFIG_SAMPLE_LIVEPATCH is not set
> > > # CONFIG_SAMPLE_CONFIGFS is not set
> > > # CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
> > > # CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
> > > # CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
> > > # CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
> > > CONFIG_HAVE_ARCH_KGDB=y
> > > CONFIG_KGDB=y
> > > CONFIG_KGDB_SERIAL_CONSOLE=y
> > > # CONFIG_KGDB_TESTS is not set
> > > CONFIG_KGDB_LOW_LEVEL_TRAP=y
> > > CONFIG_KGDB_KDB=y
> > > CONFIG_KDB_DEFAULT_ENABLE=0x1
> > > CONFIG_KDB_KEYBOARD=y
> > > CONFIG_KDB_CONTINUE_CATASTROPHIC=0
> > > CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> > > # CONFIG_UBSAN is not set
> > > CONFIG_UBSAN_ALIGNMENT=y
> > > CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> > > CONFIG_STRICT_DEVMEM=y
> > > # CONFIG_IO_STRICT_DEVMEM is not set
> > > CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> > > CONFIG_EARLY_PRINTK_USB=y
> > > # CONFIG_X86_VERBOSE_BOOTUP is not set
> > > CONFIG_EARLY_PRINTK=y
> > > CONFIG_EARLY_PRINTK_DBGP=y
> > > CONFIG_EARLY_PRINTK_USB_XDBC=y
> > > CONFIG_X86_PTDUMP_CORE=y
> > > # CONFIG_X86_PTDUMP is not set
> > > # CONFIG_EFI_PGT_DUMP is not set
> > > CONFIG_DEBUG_WX=y
> > > CONFIG_DOUBLEFAULT=y
> > > # CONFIG_DEBUG_TLBFLUSH is not set
> > > # CONFIG_IOMMU_DEBUG is not set
> > > CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> > > # CONFIG_X86_DECODER_SELFTEST is not set
> > > # CONFIG_IO_DELAY_0X80 is not set
> > > CONFIG_IO_DELAY_0XED=y
> > > # CONFIG_IO_DELAY_UDELAY is not set
> > > # CONFIG_IO_DELAY_NONE is not set
> > > # CONFIG_DEBUG_BOOT_PARAMS is not set
> > > # CONFIG_CPA_DEBUG is not set
> > > # CONFIG_DEBUG_ENTRY is not set
> > > # CONFIG_DEBUG_NMI_SELFTEST is not set
> > > CONFIG_X86_DEBUG_FPU=y
> > > CONFIG_PUNIT_ATOM_DEBUG=m
> > > # CONFIG_UNWINDER_ORC is not set
> > > CONFIG_UNWINDER_FRAME_POINTER=y
> > > # CONFIG_UNWINDER_GUESS is not set
> > > # end of Kernel hacking
> > > #
> > > # Automatically generated file; DO NOT EDIT.
> > > # Linux/x86 5.4.0 Kernel Configuration
> > > #
> > > 
> > > #
> > > # Compiler: gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
> > > #
> > > CONFIG_CC_IS_GCC=y
> > > CONFIG_GCC_VERSION=70400
> > > CONFIG_CLANG_VERSION=0
> > > CONFIG_CC_CAN_LINK=y
> > > CONFIG_CC_HAS_ASM_GOTO=y
> > > CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
> > > CONFIG_IRQ_WORK=y
> > > CONFIG_BUILDTIME_EXTABLE_SORT=y
> > > CONFIG_THREAD_INFO_IN_TASK=y
> > > 
> > > #
> > > # General setup
> > > #
> > > CONFIG_INIT_ENV_ARG_LIMIT=32
> > > # CONFIG_COMPILE_TEST is not set
> > > CONFIG_LOCALVERSION="-s76"
> > > # CONFIG_LOCALVERSION_AUTO is not set
> > > CONFIG_BUILD_SALT=""
> > > CONFIG_HAVE_KERNEL_GZIP=y
> > > CONFIG_HAVE_KERNEL_BZIP2=y
> > > CONFIG_HAVE_KERNEL_LZMA=y
> > > CONFIG_HAVE_KERNEL_XZ=y
> > > CONFIG_HAVE_KERNEL_LZO=y
> > > CONFIG_HAVE_KERNEL_LZ4=y
> > > CONFIG_KERNEL_GZIP=y
> > > # CONFIG_KERNEL_BZIP2 is not set
> > > # CONFIG_KERNEL_LZMA is not set
> > > # CONFIG_KERNEL_XZ is not set
> > > # CONFIG_KERNEL_LZO is not set
> > > # CONFIG_KERNEL_LZ4 is not set
> > > CONFIG_DEFAULT_HOSTNAME="(none)"
> > > CONFIG_SWAP=y
> > > CONFIG_SYSVIPC=y
> > > CONFIG_SYSVIPC_SYSCTL=y
> > > CONFIG_POSIX_MQUEUE=y
> > > CONFIG_POSIX_MQUEUE_SYSCTL=y
> > > CONFIG_CROSS_MEMORY_ATTACH=y
> > > CONFIG_USELIB=y
> > > CONFIG_AUDIT=y
> > > CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> > > CONFIG_AUDITSYSCALL=y
> > > 
> > > #
> > > # IRQ subsystem
> > > #
> > > CONFIG_GENERIC_IRQ_PROBE=y
> > > CONFIG_GENERIC_IRQ_SHOW=y
> > > CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
> > > CONFIG_GENERIC_PENDING_IRQ=y
> > > CONFIG_GENERIC_IRQ_MIGRATION=y
> > > CONFIG_GENERIC_IRQ_CHIP=y
> > > CONFIG_IRQ_DOMAIN=y
> > > CONFIG_IRQ_DOMAIN_HIERARCHY=y
> > > CONFIG_GENERIC_MSI_IRQ=y
> > > CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
> > > CONFIG_IRQ_MSI_IOMMU=y
> > > CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> > > CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> > > CONFIG_IRQ_FORCED_THREADING=y
> > > CONFIG_SPARSE_IRQ=y
> > > # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> > > # end of IRQ subsystem
> > > 
> > > CONFIG_CLOCKSOURCE_WATCHDOG=y
> > > CONFIG_ARCH_CLOCKSOURCE_DATA=y
> > > CONFIG_ARCH_CLOCKSOURCE_INIT=y
> > > CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> > > CONFIG_GENERIC_TIME_VSYSCALL=y
> > > CONFIG_GENERIC_CLOCKEVENTS=y
> > > CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> > > CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> > > CONFIG_GENERIC_CMOS_UPDATE=y
> > > 
> > > #
> > > # Timers subsystem
> > > #
> > > CONFIG_TICK_ONESHOT=y
> > > CONFIG_NO_HZ_COMMON=y
> > > # CONFIG_HZ_PERIODIC is not set
> > > CONFIG_NO_HZ_IDLE=y
> > > # CONFIG_NO_HZ_FULL is not set
> > > CONFIG_NO_HZ=y
> > > CONFIG_HIGH_RES_TIMERS=y
> > > # end of Timers subsystem
> > > 
> > > # CONFIG_PREEMPT_NONE is not set
> > > CONFIG_PREEMPT_VOLUNTARY=y
> > > # CONFIG_PREEMPT is not set
> > > 
> > > #
> > > # CPU/Task time and stats accounting
> > > #
> > > CONFIG_TICK_CPU_ACCOUNTING=y
> > > # CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
> > > # CONFIG_IRQ_TIME_ACCOUNTING is not set
> > > CONFIG_BSD_PROCESS_ACCT=y
> > > CONFIG_BSD_PROCESS_ACCT_V3=y
> > > CONFIG_TASKSTATS=y
> > > CONFIG_TASK_DELAY_ACCT=y
> > > CONFIG_TASK_XACCT=y
> > > CONFIG_TASK_IO_ACCOUNTING=y
> > > CONFIG_PSI=y
> > > # CONFIG_PSI_DEFAULT_DISABLED is not set
> > > # end of CPU/Task time and stats accounting
> > > 
> > > CONFIG_CPU_ISOLATION=y
> > > 
> > > #
> > > # RCU Subsystem
> > > #
> > > CONFIG_TREE_RCU=y
> > > # CONFIG_RCU_EXPERT is not set
> > > CONFIG_SRCU=y
> > > CONFIG_TREE_SRCU=y
> > > CONFIG_TASKS_RCU=y
> > > CONFIG_RCU_STALL_COMMON=y
> > > CONFIG_RCU_NEED_SEGCBLIST=y
> > > # end of RCU Subsystem
> > > 
> > > CONFIG_BUILD_BIN2C=y
> > > # CONFIG_IKCONFIG is not set
> > > CONFIG_IKHEADERS=m
> > > CONFIG_LOG_BUF_SHIFT=18
> > > CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> > > CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> > > CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> > > 
> > > #
> > > # Scheduler features
> > > #
> > > CONFIG_UCLAMP_TASK=y
> > > CONFIG_UCLAMP_BUCKETS_COUNT=5
> > > # end of Scheduler features
> > > 
> > > CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
> > > CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> > > CONFIG_CC_HAS_INT128=y
> > > CONFIG_ARCH_SUPPORTS_INT128=y
> > > CONFIG_NUMA_BALANCING=y
> > > CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
> > > CONFIG_CGROUPS=y
> > > CONFIG_PAGE_COUNTER=y
> > > CONFIG_MEMCG=y
> > > CONFIG_MEMCG_SWAP=y
> > > # CONFIG_MEMCG_SWAP_ENABLED is not set
> > > CONFIG_MEMCG_KMEM=y
> > > CONFIG_BLK_CGROUP=y
> > > CONFIG_CGROUP_WRITEBACK=y
> > > CONFIG_CGROUP_SCHED=y
> > > CONFIG_FAIR_GROUP_SCHED=y
> > > CONFIG_CFS_BANDWIDTH=y
> > > # CONFIG_RT_GROUP_SCHED is not set
> > > # CONFIG_UCLAMP_TASK_GROUP is not set
> > > CONFIG_CGROUP_PIDS=y
> > > CONFIG_CGROUP_RDMA=y
> > > CONFIG_CGROUP_FREEZER=y
> > > CONFIG_CGROUP_HUGETLB=y
> > > CONFIG_CPUSETS=y
> > > CONFIG_PROC_PID_CPUSET=y
> > > CONFIG_CGROUP_DEVICE=y
> > > CONFIG_CGROUP_CPUACCT=y
> > > CONFIG_CGROUP_PERF=y
> > > CONFIG_CGROUP_BPF=y
> > > # CONFIG_CGROUP_DEBUG is not set
> > > CONFIG_SOCK_CGROUP_DATA=y
> > > CONFIG_NAMESPACES=y
> > > CONFIG_UTS_NS=y
> > > CONFIG_IPC_NS=y
> > > CONFIG_USER_NS=y
> > > CONFIG_PID_NS=y
> > > CONFIG_NET_NS=y
> > > CONFIG_CHECKPOINT_RESTORE=y
> > > CONFIG_SCHED_AUTOGROUP=y
> > > # CONFIG_SYSFS_DEPRECATED is not set
> > > CONFIG_RELAY=y
> > > CONFIG_BLK_DEV_INITRD=y
> > > CONFIG_INITRAMFS_SOURCE=""
> > > CONFIG_RD_GZIP=y
> > > CONFIG_RD_BZIP2=y
> > > CONFIG_RD_LZMA=y
> > > CONFIG_RD_XZ=y
> > > CONFIG_RD_LZO=y
> > > CONFIG_RD_LZ4=y
> > > CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> > > # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> > > CONFIG_SYSCTL=y
> > > CONFIG_HAVE_UID16=y
> > > CONFIG_SYSCTL_EXCEPTION_TRACE=y
> > > CONFIG_HAVE_PCSPKR_PLATFORM=y
> > > CONFIG_BPF=y
> > > CONFIG_EXPERT=y
> > > CONFIG_UID16=y
> > > CONFIG_MULTIUSER=y
> > > CONFIG_SGETMASK_SYSCALL=y
> > > CONFIG_SYSFS_SYSCALL=y
> > > CONFIG_FHANDLE=y
> > > CONFIG_POSIX_TIMERS=y
> > > CONFIG_PRINTK=y
> > > CONFIG_PRINTK_NMI=y
> > > CONFIG_BUG=y
> > > CONFIG_ELF_CORE=y
> > > CONFIG_PCSPKR_PLATFORM=y
> > > CONFIG_BASE_FULL=y
> > > CONFIG_FUTEX=y
> > > CONFIG_FUTEX_PI=y
> > > CONFIG_EPOLL=y
> > > CONFIG_SIGNALFD=y
> > > CONFIG_TIMERFD=y
> > > CONFIG_EVENTFD=y
> > > CONFIG_SHMEM=y
> > > CONFIG_AIO=y
> > > CONFIG_IO_URING=y
> > > CONFIG_ADVISE_SYSCALLS=y
> > > CONFIG_MEMBARRIER=y
> > > CONFIG_KALLSYMS=y
> > > CONFIG_KALLSYMS_ALL=y
> > > CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
> > > CONFIG_KALLSYMS_BASE_RELATIVE=y
> > > CONFIG_BPF_SYSCALL=y
> > > CONFIG_BPF_JIT_ALWAYS_ON=y
> > > CONFIG_USERFAULTFD=y
> > > CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> > > CONFIG_RSEQ=y
> > > # CONFIG_DEBUG_RSEQ is not set
> > > # CONFIG_EMBEDDED is not set
> > > CONFIG_HAVE_PERF_EVENTS=y
> > > CONFIG_PC104=y
> > > 
> > > #
> > > # Kernel Performance Events And Counters
> > > #
> > > CONFIG_PERF_EVENTS=y
> > > # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> > > # end of Kernel Performance Events And Counters
> > > 
> > > CONFIG_VM_EVENT_COUNTERS=y
> > > CONFIG_SLUB_DEBUG=y
> > > CONFIG_SLUB_MEMCG_SYSFS_ON=y
> > > # CONFIG_COMPAT_BRK is not set
> > > # CONFIG_SLAB is not set
> > > CONFIG_SLUB=y
> > > # CONFIG_SLOB is not set
> > > CONFIG_SLAB_MERGE_DEFAULT=y
> > > CONFIG_SLAB_FREELIST_RANDOM=y
> > > CONFIG_SLAB_FREELIST_HARDENED=y
> > > CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
> > > CONFIG_SLUB_CPU_PARTIAL=y
> > > CONFIG_SYSTEM_DATA_VERIFICATION=y
> > > CONFIG_PROFILING=y
> > > CONFIG_TRACEPOINTS=y
> > > # end of General setup
> > > 
> > > CONFIG_64BIT=y
> > > CONFIG_X86_64=y
> > > CONFIG_X86=y
> > > CONFIG_INSTRUCTION_DECODER=y
> > > CONFIG_OUTPUT_FORMAT="elf64-x86-64"
> > > CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
> > > CONFIG_LOCKDEP_SUPPORT=y
> > > CONFIG_STACKTRACE_SUPPORT=y
> > > CONFIG_MMU=y
> > > CONFIG_ARCH_MMAP_RND_BITS_MIN=28
> > > CONFIG_ARCH_MMAP_RND_BITS_MAX=32
> > > CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> > > CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> > > CONFIG_GENERIC_ISA_DMA=y
> > > CONFIG_GENERIC_BUG=y
> > > CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
> > > CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> > > CONFIG_GENERIC_CALIBRATE_DELAY=y
> > > CONFIG_ARCH_HAS_CPU_RELAX=y
> > > CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> > > CONFIG_ARCH_HAS_FILTER_PGPROT=y
> > > CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> > > CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> > > CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> > > CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> > > CONFIG_ARCH_SUSPEND_POSSIBLE=y
> > > CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> > > CONFIG_ZONE_DMA32=y
> > > CONFIG_AUDIT_ARCH=y
> > > CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> > > CONFIG_HAVE_INTEL_TXT=y
> > > CONFIG_X86_64_SMP=y
> > > CONFIG_ARCH_SUPPORTS_UPROBES=y
> > > CONFIG_FIX_EARLYCON_MEM=y
> > > CONFIG_DYNAMIC_PHYSICAL_MASK=y
> > > CONFIG_PGTABLE_LEVELS=4
> > > CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> > > 
> > > #
> > > # Processor type and features
> > > #
> > > CONFIG_ZONE_DMA=y
> > > CONFIG_SMP=y
> > > CONFIG_X86_FEATURE_NAMES=y
> > > CONFIG_X86_X2APIC=y
> > > CONFIG_X86_MPPARSE=y
> > > # CONFIG_GOLDFISH is not set
> > > CONFIG_RETPOLINE=y
> > > CONFIG_X86_CPU_RESCTRL=y
> > > CONFIG_X86_EXTENDED_PLATFORM=y
> > > CONFIG_X86_NUMACHIP=y
> > > # CONFIG_X86_VSMP is not set
> > > # CONFIG_X86_UV is not set
> > > # CONFIG_X86_GOLDFISH is not set
> > > # CONFIG_X86_INTEL_MID is not set
> > > CONFIG_X86_INTEL_LPSS=y
> > > CONFIG_X86_AMD_PLATFORM_DEVICE=y
> > > CONFIG_IOSF_MBI=y
> > > CONFIG_IOSF_MBI_DEBUG=y
> > > CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
> > > CONFIG_SCHED_OMIT_FRAME_POINTER=y
> > > CONFIG_HYPERVISOR_GUEST=y
> > > CONFIG_PARAVIRT=y
> > > CONFIG_PARAVIRT_XXL=y
> > > # CONFIG_PARAVIRT_DEBUG is not set
> > > CONFIG_PARAVIRT_SPINLOCKS=y
> > > CONFIG_X86_HV_CALLBACK_VECTOR=y
> > > CONFIG_XEN=y
> > > CONFIG_XEN_PV=y
> > > CONFIG_XEN_PV_SMP=y
> > > CONFIG_XEN_DOM0=y
> > > CONFIG_XEN_PVHVM=y
> > > CONFIG_XEN_PVHVM_SMP=y
> > > CONFIG_XEN_512GB=y
> > > CONFIG_XEN_SAVE_RESTORE=y
> > > # CONFIG_XEN_DEBUG_FS is not set
> > > CONFIG_XEN_PVH=y
> > > CONFIG_KVM_GUEST=y
> > > CONFIG_ARCH_CPUIDLE_HALTPOLL=y
> > > CONFIG_PVH=y
> > > CONFIG_KVM_DEBUG_FS=y
> > > # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> > > CONFIG_PARAVIRT_CLOCK=y
> > > CONFIG_JAILHOUSE_GUEST=y
> > > CONFIG_ACRN_GUEST=y
> > > # CONFIG_MK8 is not set
> > > # CONFIG_MPSC is not set
> > > # CONFIG_MCORE2 is not set
> > > # CONFIG_MATOM is not set
> > > CONFIG_GENERIC_CPU=y
> > > CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> > > CONFIG_X86_L1_CACHE_SHIFT=6
> > > CONFIG_X86_TSC=y
> > > CONFIG_X86_CMPXCHG64=y
> > > CONFIG_X86_CMOV=y
> > > CONFIG_X86_MINIMUM_CPU_FAMILY=64
> > > CONFIG_X86_DEBUGCTLMSR=y
> > > CONFIG_PROCESSOR_SELECT=y
> > > CONFIG_CPU_SUP_INTEL=y
> > > CONFIG_CPU_SUP_AMD=y
> > > CONFIG_CPU_SUP_HYGON=y
> > > CONFIG_CPU_SUP_CENTAUR=y
> > > CONFIG_CPU_SUP_ZHAOXIN=y
> > > CONFIG_HPET_TIMER=y
> > > CONFIG_HPET_EMULATE_RTC=y
> > > CONFIG_DMI=y
> > > CONFIG_GART_IOMMU=y
> > > CONFIG_MAXSMP=y
> > > CONFIG_NR_CPUS_RANGE_BEGIN=8192
> > > CONFIG_NR_CPUS_RANGE_END=8192
> > > CONFIG_NR_CPUS_DEFAULT=8192
> > > CONFIG_NR_CPUS=8192
> > > CONFIG_SCHED_SMT=y
> > > CONFIG_SCHED_MC=y
> > > CONFIG_SCHED_MC_PRIO=y
> > > CONFIG_X86_LOCAL_APIC=y
> > > CONFIG_X86_IO_APIC=y
> > > CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
> > > CONFIG_X86_MCE=y
> > > CONFIG_X86_MCELOG_LEGACY=y
> > > CONFIG_X86_MCE_INTEL=y
> > > CONFIG_X86_MCE_AMD=y
> > > CONFIG_X86_MCE_THRESHOLD=y
> > > CONFIG_X86_MCE_INJECT=m
> > > CONFIG_X86_THERMAL_VECTOR=y
> > > 
> > > #
> > > # Performance monitoring
> > > #
> > > CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> > > CONFIG_PERF_EVENTS_INTEL_RAPL=m
> > > CONFIG_PERF_EVENTS_INTEL_CSTATE=m
> > > # CONFIG_PERF_EVENTS_AMD_POWER is not set
> > > # end of Performance monitoring
> > > 
> > > CONFIG_X86_16BIT=y
> > > CONFIG_X86_ESPFIX64=y
> > > CONFIG_X86_VSYSCALL_EMULATION=y
> > > CONFIG_X86_IOPL_IOPERM=y
> > > CONFIG_I8K=m
> > > CONFIG_MICROCODE=y
> > > CONFIG_MICROCODE_INTEL=y
> > > CONFIG_MICROCODE_AMD=y
> > > CONFIG_MICROCODE_OLD_INTERFACE=y
> > > CONFIG_X86_MSR=m
> > > CONFIG_X86_CPUID=m
> > > # CONFIG_X86_5LEVEL is not set
> > > CONFIG_X86_DIRECT_GBPAGES=y
> > > # CONFIG_X86_CPA_STATISTICS is not set
> > > CONFIG_AMD_MEM_ENCRYPT=y
> > > # CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
> > > CONFIG_NUMA=y
> > > CONFIG_AMD_NUMA=y
> > > CONFIG_X86_64_ACPI_NUMA=y
> > > CONFIG_NODES_SPAN_OTHER_NODES=y
> > > # CONFIG_NUMA_EMU is not set
> > > CONFIG_NODES_SHIFT=10
> > > CONFIG_ARCH_SPARSEMEM_ENABLE=y
> > > CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> > > CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> > > CONFIG_ARCH_MEMORY_PROBE=y
> > > CONFIG_ARCH_PROC_KCORE_TEXT=y
> > > CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
> > > CONFIG_X86_PMEM_LEGACY_DEVICE=y
> > > CONFIG_X86_PMEM_LEGACY=y
> > > CONFIG_X86_CHECK_BIOS_CORRUPTION=y
> > > CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
> > > CONFIG_X86_RESERVE_LOW=64
> > > CONFIG_MTRR=y
> > > CONFIG_MTRR_SANITIZER=y
> > > CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
> > > CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
> > > CONFIG_X86_PAT=y
> > > CONFIG_ARCH_USES_PG_UNCACHED=y
> > > CONFIG_ARCH_RANDOM=y
> > > CONFIG_X86_SMAP=y
> > > CONFIG_X86_UMIP=y
> > > CONFIG_X86_INTEL_MPX=y
> > > CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
> > > CONFIG_X86_INTEL_TSX_MODE_OFF=y
> > > # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> > > # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> > > CONFIG_EFI=y
> > > CONFIG_EFI_STUB=y
> > > CONFIG_EFI_MIXED=y
> > > CONFIG_SECCOMP=y
> > > # CONFIG_HZ_100 is not set
> > > CONFIG_HZ_250=y
> > > # CONFIG_HZ_300 is not set
> > > # CONFIG_HZ_1000 is not set
> > > CONFIG_HZ=250
> > > CONFIG_SCHED_HRTICK=y
> > > CONFIG_KEXEC=y
> > > CONFIG_KEXEC_FILE=y
> > > CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
> > > CONFIG_KEXEC_SIG=y
> > > # CONFIG_KEXEC_SIG_FORCE is not set
> > > CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y
> > > CONFIG_CRASH_DUMP=y
> > > CONFIG_KEXEC_JUMP=y
> > > CONFIG_PHYSICAL_START=0x1000000
> > > CONFIG_RELOCATABLE=y
> > > CONFIG_RANDOMIZE_BASE=y
> > > CONFIG_X86_NEED_RELOCS=y
> > > CONFIG_PHYSICAL_ALIGN=0x200000
> > > CONFIG_DYNAMIC_MEMORY_LAYOUT=y
> > > CONFIG_RANDOMIZE_MEMORY=y
> > > CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
> > > CONFIG_HOTPLUG_CPU=y
> > > # CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
> > > # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
> > > # CONFIG_COMPAT_VDSO is not set
> > > # CONFIG_LEGACY_VSYSCALL_EMULATE is not set
> > > CONFIG_LEGACY_VSYSCALL_XONLY=y
> > > # CONFIG_LEGACY_VSYSCALL_NONE is not set
> > > # CONFIG_CMDLINE_BOOL is not set
> > > CONFIG_MODIFY_LDT_SYSCALL=y
> > > CONFIG_HAVE_LIVEPATCH=y
> > > CONFIG_LIVEPATCH=y
> > > # end of Processor type and features
> > > 
> > > CONFIG_ARCH_HAS_ADD_PAGES=y
> > > CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> > > CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
> > > CONFIG_USE_PERCPU_NUMA_NODE_ID=y
> > > CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> > > CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
> > > CONFIG_ARCH_ENABLE_THP_MIGRATION=y
> > > 
> > > #
> > > # Power management and ACPI options
> > > #
> > > CONFIG_ARCH_HIBERNATION_HEADER=y
> > > CONFIG_SUSPEND=y
> > > CONFIG_SUSPEND_FREEZER=y
> > > # CONFIG_SUSPEND_SKIP_SYNC is not set
> > > CONFIG_HIBERNATE_CALLBACKS=y
> > > CONFIG_HIBERNATION=y
> > > CONFIG_PM_STD_PARTITION=""
> > > CONFIG_PM_SLEEP=y
> > > CONFIG_PM_SLEEP_SMP=y
> > > # CONFIG_PM_AUTOSLEEP is not set
> > > CONFIG_PM_WAKELOCKS=y
> > > CONFIG_PM_WAKELOCKS_LIMIT=100
> > > CONFIG_PM_WAKELOCKS_GC=y
> > > CONFIG_PM=y
> > > CONFIG_PM_DEBUG=y
> > > CONFIG_PM_ADVANCED_DEBUG=y
> > > # CONFIG_PM_TEST_SUSPEND is not set
> > > CONFIG_PM_SLEEP_DEBUG=y
> > > # CONFIG_DPM_WATCHDOG is not set
> > > CONFIG_PM_TRACE=y
> > > CONFIG_PM_TRACE_RTC=y
> > > CONFIG_PM_CLK=y
> > > CONFIG_PM_GENERIC_DOMAINS=y
> > > CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
> > > CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
> > > # CONFIG_ENERGY_MODEL is not set
> > > CONFIG_ARCH_SUPPORTS_ACPI=y
> > > CONFIG_ACPI=y
> > > CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> > > CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> > > CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> > > CONFIG_ACPI_DEBUGGER=y
> > > CONFIG_ACPI_DEBUGGER_USER=y
> > > CONFIG_ACPI_SPCR_TABLE=y
> > > CONFIG_ACPI_LPIT=y
> > > CONFIG_ACPI_SLEEP=y
> > > # CONFIG_ACPI_PROCFS_POWER is not set
> > > CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> > > CONFIG_ACPI_EC_DEBUGFS=m
> > > CONFIG_ACPI_AC=y
> > > CONFIG_ACPI_BATTERY=y
> > > CONFIG_ACPI_BUTTON=y
> > > CONFIG_ACPI_VIDEO=m
> > > CONFIG_ACPI_FAN=y
> > > CONFIG_ACPI_TAD=m
> > > CONFIG_ACPI_DOCK=y
> > > CONFIG_ACPI_CPU_FREQ_PSS=y
> > > CONFIG_ACPI_PROCESSOR_CSTATE=y
> > > CONFIG_ACPI_PROCESSOR_IDLE=y
> > > CONFIG_ACPI_CPPC_LIB=y
> > > CONFIG_ACPI_PROCESSOR=y
> > > CONFIG_ACPI_IPMI=m
> > > CONFIG_ACPI_HOTPLUG_CPU=y
> > > CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
> > > CONFIG_ACPI_THERMAL=y
> > > CONFIG_ACPI_CUSTOM_DSDT_FILE=""
> > > CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> > > CONFIG_ACPI_TABLE_UPGRADE=y
> > > CONFIG_ACPI_DEBUG=y
> > > CONFIG_ACPI_PCI_SLOT=y
> > > CONFIG_ACPI_CONTAINER=y
> > > CONFIG_ACPI_HOTPLUG_MEMORY=y
> > > CONFIG_ACPI_HOTPLUG_IOAPIC=y
> > > CONFIG_ACPI_SBS=m
> > > CONFIG_ACPI_HED=y
> > > # CONFIG_ACPI_CUSTOM_METHOD is not set
> > > CONFIG_ACPI_BGRT=y
> > > # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> > > CONFIG_ACPI_NFIT=m
> > > # CONFIG_NFIT_SECURITY_DEBUG is not set
> > > CONFIG_ACPI_NUMA=y
> > > CONFIG_ACPI_HMAT=y
> > > CONFIG_HAVE_ACPI_APEI=y
> > > CONFIG_HAVE_ACPI_APEI_NMI=y
> > > CONFIG_ACPI_APEI=y
> > > CONFIG_ACPI_APEI_GHES=y
> > > CONFIG_ACPI_APEI_PCIEAER=y
> > > CONFIG_ACPI_APEI_MEMORY_FAILURE=y
> > > CONFIG_ACPI_APEI_EINJ=m
> > > # CONFIG_ACPI_APEI_ERST_DEBUG is not set
> > > CONFIG_DPTF_POWER=m
> > > CONFIG_ACPI_WATCHDOG=y
> > > CONFIG_ACPI_EXTLOG=m
> > > CONFIG_ACPI_ADXL=y
> > > # CONFIG_PMIC_OPREGION is not set
> > > CONFIG_ACPI_CONFIGFS=m
> > > CONFIG_TPS68470_PMIC_OPREGION=y
> > > CONFIG_X86_PM_TIMER=y
> > > CONFIG_SFI=y
> > > 
> > > #
> > > # CPU Frequency scaling
> > > #
> > > CONFIG_CPU_FREQ=y
> > > CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> > > CONFIG_CPU_FREQ_GOV_COMMON=y
> > > CONFIG_CPU_FREQ_STAT=y
> > > CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> > > # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> > > # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> > > # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
> > > # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
> > > # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> > > CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> > > CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> > > CONFIG_CPU_FREQ_GOV_USERSPACE=y
> > > CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> > > CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> > > CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
> > > 
> > > #
> > > # CPU frequency scaling drivers
> > > #
> > > CONFIG_X86_INTEL_PSTATE=y
> > > CONFIG_X86_PCC_CPUFREQ=y
> > > CONFIG_X86_ACPI_CPUFREQ=y
> > > CONFIG_X86_ACPI_CPUFREQ_CPB=y
> > > CONFIG_X86_POWERNOW_K8=y
> > > CONFIG_X86_AMD_FREQ_SENSITIVITY=m
> > > CONFIG_X86_SPEEDSTEP_CENTRINO=y
> > > CONFIG_X86_P4_CLOCKMOD=m
> > > 
> > > #
> > > # shared options
> > > #
> > > CONFIG_X86_SPEEDSTEP_LIB=m
> > > # end of CPU Frequency scaling
> > > 
> > > #
> > > # CPU Idle
> > > #
> > > CONFIG_CPU_IDLE=y
> > > CONFIG_CPU_IDLE_GOV_LADDER=y
> > > CONFIG_CPU_IDLE_GOV_MENU=y
> > > CONFIG_CPU_IDLE_GOV_TEO=y
> > > # CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
> > > CONFIG_HALTPOLL_CPUIDLE=y
> > > # end of CPU Idle
> > > 
> > > CONFIG_INTEL_IDLE=y
> > > # end of Power management and ACPI options
> > > 
> > > #
> > > # Bus options (PCI etc.)
> > > #
> > > CONFIG_PCI_DIRECT=y
> > > CONFIG_PCI_MMCONFIG=y
> > > CONFIG_PCI_XEN=y
> > > CONFIG_MMCONF_FAM10H=y
> > > # CONFIG_PCI_CNB20LE_QUIRK is not set
> > > CONFIG_ISA_BUS=y
> > > CONFIG_ISA_DMA_API=y
> > > CONFIG_AMD_NB=y
> > > # CONFIG_X86_SYSFB is not set
> > > # end of Bus options (PCI etc.)
> > > 
> > > #
> > > # Binary Emulations
> > > #
> > > CONFIG_IA32_EMULATION=y
> > > CONFIG_X86_X32=y
> > > CONFIG_COMPAT_32=y
> > > CONFIG_COMPAT=y
> > > CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
> > > CONFIG_SYSVIPC_COMPAT=y
> > > # end of Binary Emulations
> > > 
> > > CONFIG_X86_DEV_DMA_OPS=y
> > > 
> > > #
> > > # Firmware Drivers
> > > #
> > > CONFIG_EDD=y
> > > CONFIG_EDD_OFF=y
> > > CONFIG_FIRMWARE_MEMMAP=y
> > > CONFIG_DMIID=y
> > > CONFIG_DMI_SYSFS=m
> > > CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> > > CONFIG_ISCSI_IBFT_FIND=y
> > > CONFIG_ISCSI_IBFT=m
> > > CONFIG_FW_CFG_SYSFS=m
> > > # CONFIG_FW_CFG_SYSFS_CMDLINE is not set
> > > # CONFIG_GOOGLE_FIRMWARE is not set
> > > 
> > > #
> > > # EFI (Extensible Firmware Interface) Support
> > > #
> > > CONFIG_EFI_VARS=y
> > > CONFIG_EFI_ESRT=y
> > > CONFIG_EFI_VARS_PSTORE=m
> > > # CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
> > > CONFIG_EFI_RUNTIME_MAP=y
> > > # CONFIG_EFI_FAKE_MEMMAP is not set
> > > CONFIG_EFI_SOFT_RESERVE=y
> > > CONFIG_EFI_RUNTIME_WRAPPERS=y
> > > CONFIG_EFI_BOOTLOADER_CONTROL=m
> > > CONFIG_EFI_CAPSULE_LOADER=m
> > > CONFIG_EFI_TEST=m
> > > CONFIG_APPLE_PROPERTIES=y
> > > CONFIG_RESET_ATTACK_MITIGATION=y
> > > # CONFIG_EFI_RCI2_TABLE is not set
> > > # end of EFI (Extensible Firmware Interface) Support
> > > 
> > > CONFIG_UEFI_CPER=y
> > > CONFIG_UEFI_CPER_X86=y
> > > CONFIG_EFI_DEV_PATH_PARSER=y
> > > CONFIG_EFI_EARLYCON=y
> > > 
> > > #
> > > # Tegra firmware driver
> > > #
> > > # end of Tegra firmware driver
> > > # end of Firmware Drivers
> > > 
> > > CONFIG_HAVE_KVM=y
> > > CONFIG_HAVE_KVM_IRQCHIP=y
> > > CONFIG_HAVE_KVM_IRQFD=y
> > > CONFIG_HAVE_KVM_IRQ_ROUTING=y
> > > CONFIG_HAVE_KVM_EVENTFD=y
> > > CONFIG_KVM_MMIO=y
> > > CONFIG_KVM_ASYNC_PF=y
> > > CONFIG_HAVE_KVM_MSI=y
> > > CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
> > > CONFIG_KVM_VFIO=y
> > > CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
> > > CONFIG_KVM_COMPAT=y
> > > CONFIG_HAVE_KVM_IRQ_BYPASS=y
> > > CONFIG_HAVE_KVM_NO_POLL=y
> > > CONFIG_VIRTUALIZATION=y
> > > CONFIG_KVM=m
> > > CONFIG_KVM_INTEL=m
> > > CONFIG_KVM_AMD=m
> > > CONFIG_KVM_AMD_SEV=y
> > > # CONFIG_KVM_MMU_AUDIT is not set
> > > CONFIG_VHOST_NET=m
> > > CONFIG_VHOST_SCSI=m
> > > CONFIG_VHOST_VSOCK=m
> > > CONFIG_VHOST=m
> > > # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
> > > 
> > > #
> > > # General architecture-dependent options
> > > #
> > > CONFIG_CRASH_CORE=y
> > > CONFIG_KEXEC_CORE=y
> > > CONFIG_HOTPLUG_SMT=y
> > > CONFIG_OPROFILE=m
> > > # CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
> > > CONFIG_HAVE_OPROFILE=y
> > > CONFIG_OPROFILE_NMI_TIMER=y
> > > CONFIG_KPROBES=y
> > > CONFIG_JUMP_LABEL=y
> > > # CONFIG_STATIC_KEYS_SELFTEST is not set
> > > CONFIG_OPTPROBES=y
> > > CONFIG_KPROBES_ON_FTRACE=y
> > > CONFIG_UPROBES=y
> > > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> > > CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> > > CONFIG_KRETPROBES=y
> > > CONFIG_USER_RETURN_NOTIFIER=y
> > > CONFIG_HAVE_IOREMAP_PROT=y
> > > CONFIG_HAVE_KPROBES=y
> > > CONFIG_HAVE_KRETPROBES=y
> > > CONFIG_HAVE_OPTPROBES=y
> > > CONFIG_HAVE_KPROBES_ON_FTRACE=y
> > > CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> > > CONFIG_HAVE_NMI=y
> > > CONFIG_HAVE_ARCH_TRACEHOOK=y
> > > CONFIG_HAVE_DMA_CONTIGUOUS=y
> > > CONFIG_GENERIC_SMP_IDLE_THREAD=y
> > > CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> > > CONFIG_ARCH_HAS_SET_MEMORY=y
> > > CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
> > > CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> > > CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> > > CONFIG_HAVE_ASM_MODVERSIONS=y
> > > CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> > > CONFIG_HAVE_RSEQ=y
> > > CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
> > > CONFIG_HAVE_CLK=y
> > > CONFIG_HAVE_HW_BREAKPOINT=y
> > > CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> > > CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> > > CONFIG_HAVE_PERF_EVENTS_NMI=y
> > > CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> > > CONFIG_HAVE_PERF_REGS=y
> > > CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> > > CONFIG_HAVE_ARCH_JUMP_LABEL=y
> > > CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
> > > CONFIG_HAVE_RCU_TABLE_FREE=y
> > > CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> > > CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
> > > CONFIG_HAVE_CMPXCHG_LOCAL=y
> > > CONFIG_HAVE_CMPXCHG_DOUBLE=y
> > > CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
> > > CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
> > > CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> > > CONFIG_SECCOMP_FILTER=y
> > > CONFIG_HAVE_ARCH_STACKLEAK=y
> > > CONFIG_HAVE_STACKPROTECTOR=y
> > > CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
> > > CONFIG_STACKPROTECTOR=y
> > > CONFIG_STACKPROTECTOR_STRONG=y
> > > CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> > > CONFIG_HAVE_CONTEXT_TRACKING=y
> > > CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> > > CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> > > CONFIG_HAVE_MOVE_PMD=y
> > > CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> > > CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
> > > CONFIG_HAVE_ARCH_HUGE_VMAP=y
> > > CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> > > CONFIG_HAVE_ARCH_SOFT_DIRTY=y
> > > CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> > > CONFIG_MODULES_USE_ELF_RELA=y
> > > CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
> > > CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> > > CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> > > CONFIG_HAVE_EXIT_THREAD=y
> > > CONFIG_ARCH_MMAP_RND_BITS=28
> > > CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
> > > CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
> > > CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
> > > CONFIG_HAVE_COPY_THREAD_TLS=y
> > > CONFIG_HAVE_STACK_VALIDATION=y
> > > CONFIG_HAVE_RELIABLE_STACKTRACE=y
> > > CONFIG_ISA_BUS_API=y
> > > CONFIG_OLD_SIGSUSPEND3=y
> > > CONFIG_COMPAT_OLD_SIGACTION=y
> > > CONFIG_COMPAT_32BIT_TIME=y
> > > CONFIG_HAVE_ARCH_VMAP_STACK=y
> > > CONFIG_VMAP_STACK=y
> > > CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> > > CONFIG_STRICT_KERNEL_RWX=y
> > > CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> > > CONFIG_STRICT_MODULE_RWX=y
> > > CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
> > > CONFIG_ARCH_USE_MEMREMAP_PROT=y
> > > # CONFIG_LOCK_EVENT_COUNTS is not set
> > > CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> > > 
> > > #
> > > # GCOV-based kernel profiling
> > > #
> > > # CONFIG_GCOV_KERNEL is not set
> > > CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> > > # end of GCOV-based kernel profiling
> > > 
> > > CONFIG_PLUGIN_HOSTCC=""
> > > CONFIG_HAVE_GCC_PLUGINS=y
> > > # end of General architecture-dependent options
> > > 
> > > CONFIG_RT_MUTEXES=y
> > > CONFIG_BASE_SMALL=0
> > > CONFIG_MODULE_SIG_FORMAT=y
> > > CONFIG_MODULES=y
> > > # CONFIG_MODULE_FORCE_LOAD is not set
> > > CONFIG_MODULE_UNLOAD=y
> > > # CONFIG_MODULE_FORCE_UNLOAD is not set
> > > # CONFIG_MODVERSIONS is not set
> > > CONFIG_MODULE_SRCVERSION_ALL=y
> > > CONFIG_MODULE_SIG=y
> > > # CONFIG_MODULE_SIG_FORCE is not set
> > > CONFIG_MODULE_SIG_ALL=y
> > > # CONFIG_MODULE_SIG_SHA1 is not set
> > > # CONFIG_MODULE_SIG_SHA224 is not set
> > > # CONFIG_MODULE_SIG_SHA256 is not set
> > > # CONFIG_MODULE_SIG_SHA384 is not set
> > > CONFIG_MODULE_SIG_SHA512=y
> > > CONFIG_MODULE_SIG_HASH="sha512"
> > > # CONFIG_MODULE_COMPRESS is not set
> > > # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> > > CONFIG_UNUSED_SYMBOLS=y
> > > CONFIG_MODULES_TREE_LOOKUP=y
> > > CONFIG_BLOCK=y
> > > CONFIG_BLK_SCSI_REQUEST=y
> > > CONFIG_BLK_CGROUP_RWSTAT=y
> > > CONFIG_BLK_DEV_BSG=y
> > > CONFIG_BLK_DEV_BSGLIB=y
> > > CONFIG_BLK_DEV_INTEGRITY=y
> > > CONFIG_BLK_DEV_ZONED=y
> > > CONFIG_BLK_DEV_THROTTLING=y
> > > # CONFIG_BLK_DEV_THROTTLING_LOW is not set
> > > CONFIG_BLK_CMDLINE_PARSER=y
> > > CONFIG_BLK_WBT=y
> > > # CONFIG_BLK_CGROUP_IOLATENCY is not set
> > > # CONFIG_BLK_CGROUP_IOCOST is not set
> > > CONFIG_BLK_WBT_MQ=y
> > > CONFIG_BLK_DEBUG_FS=y
> > > CONFIG_BLK_DEBUG_FS_ZONED=y
> > > CONFIG_BLK_SED_OPAL=y
> > > 
> > > #
> > > # Partition Types
> > > #
> > > CONFIG_PARTITION_ADVANCED=y
> > > # CONFIG_ACORN_PARTITION is not set
> > > CONFIG_AIX_PARTITION=y
> > > CONFIG_OSF_PARTITION=y
> > > CONFIG_AMIGA_PARTITION=y
> > > CONFIG_ATARI_PARTITION=y
> > > CONFIG_MAC_PARTITION=y
> > > CONFIG_MSDOS_PARTITION=y
> > > CONFIG_BSD_DISKLABEL=y
> > > CONFIG_MINIX_SUBPARTITION=y
> > > CONFIG_SOLARIS_X86_PARTITION=y
> > > CONFIG_UNIXWARE_DISKLABEL=y
> > > CONFIG_LDM_PARTITION=y
> > > # CONFIG_LDM_DEBUG is not set
> > > CONFIG_SGI_PARTITION=y
> > > CONFIG_ULTRIX_PARTITION=y
> > > CONFIG_SUN_PARTITION=y
> > > CONFIG_KARMA_PARTITION=y
> > > CONFIG_EFI_PARTITION=y
> > > CONFIG_SYSV68_PARTITION=y
> > > CONFIG_CMDLINE_PARTITION=y
> > > # end of Partition Types
> > > 
> > > CONFIG_BLOCK_COMPAT=y
> > > CONFIG_BLK_MQ_PCI=y
> > > CONFIG_BLK_MQ_VIRTIO=y
> > > CONFIG_BLK_MQ_RDMA=y
> > > CONFIG_BLK_PM=y
> > > 
> > > #
> > > # IO Schedulers
> > > #
> > > CONFIG_MQ_IOSCHED_DEADLINE=y
> > > CONFIG_MQ_IOSCHED_KYBER=m
> > > CONFIG_IOSCHED_BFQ=m
> > > CONFIG_BFQ_GROUP_IOSCHED=y
> > > # CONFIG_BFQ_CGROUP_DEBUG is not set
> > > # end of IO Schedulers
> > > 
> > > CONFIG_PREEMPT_NOTIFIERS=y
> > > CONFIG_PADATA=y
> > > CONFIG_ASN1=y
> > > CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
> > > CONFIG_INLINE_READ_UNLOCK=y
> > > CONFIG_INLINE_READ_UNLOCK_IRQ=y
> > > CONFIG_INLINE_WRITE_UNLOCK=y
> > > CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
> > > CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> > > CONFIG_MUTEX_SPIN_ON_OWNER=y
> > > CONFIG_RWSEM_SPIN_ON_OWNER=y
> > > CONFIG_LOCK_SPIN_ON_OWNER=y
> > > CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> > > CONFIG_QUEUED_SPINLOCKS=y
> > > CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> > > CONFIG_QUEUED_RWLOCKS=y
> > > CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> > > CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> > > CONFIG_FREEZER=y
> > > 
> > > #
> > > # Executable file formats
> > > #
> > > CONFIG_BINFMT_ELF=y
> > > CONFIG_COMPAT_BINFMT_ELF=y
> > > CONFIG_ELFCORE=y
> > > CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
> > > CONFIG_BINFMT_SCRIPT=y
> > > CONFIG_BINFMT_MISC=m
> > > CONFIG_COREDUMP=y
> > > # end of Executable file formats
> > > 
> > > #
> > > # Memory Management options
> > > #
> > > CONFIG_SELECT_MEMORY_MODEL=y
> > > CONFIG_SPARSEMEM_MANUAL=y
> > > CONFIG_SPARSEMEM=y
> > > CONFIG_NEED_MULTIPLE_NODES=y
> > > CONFIG_HAVE_MEMORY_PRESENT=y
> > > CONFIG_SPARSEMEM_EXTREME=y
> > > CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> > > CONFIG_SPARSEMEM_VMEMMAP=y
> > > CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
> > > CONFIG_HAVE_FAST_GUP=y
> > > CONFIG_MEMORY_ISOLATION=y
> > > CONFIG_HAVE_BOOTMEM_INFO_NODE=y
> > > CONFIG_MEMORY_HOTPLUG=y
> > > CONFIG_MEMORY_HOTPLUG_SPARSE=y
> > > CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
> > > CONFIG_MEMORY_HOTREMOVE=y
> > > CONFIG_SPLIT_PTLOCK_CPUS=4
> > > CONFIG_MEMORY_BALLOON=y
> > > CONFIG_BALLOON_COMPACTION=y
> > > CONFIG_COMPACTION=y
> > > CONFIG_MIGRATION=y
> > > CONFIG_CONTIG_ALLOC=y
> > > CONFIG_PHYS_ADDR_T_64BIT=y
> > > CONFIG_BOUNCE=y
> > > CONFIG_VIRT_TO_BUS=y
> > > CONFIG_MMU_NOTIFIER=y
> > > CONFIG_KSM=y
> > > CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
> > > CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
> > > CONFIG_MEMORY_FAILURE=y
> > > CONFIG_HWPOISON_INJECT=m
> > > CONFIG_TRANSPARENT_HUGEPAGE=y
> > > # CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
> > > CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
> > > CONFIG_ARCH_WANTS_THP_SWAP=y
> > > CONFIG_THP_SWAP=y
> > > CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
> > > CONFIG_CLEANCACHE=y
> > > CONFIG_FRONTSWAP=y
> > > CONFIG_CMA=y
> > > # CONFIG_CMA_DEBUG is not set
> > > # CONFIG_CMA_DEBUGFS is not set
> > > CONFIG_CMA_AREAS=7
> > > CONFIG_MEM_SOFT_DIRTY=y
> > > CONFIG_ZSWAP=y
> > > CONFIG_ZPOOL=y
> > > CONFIG_ZBUD=y
> > > CONFIG_Z3FOLD=m
> > > CONFIG_ZSMALLOC=y
> > > CONFIG_PGTABLE_MAPPING=y
> > > # CONFIG_ZSMALLOC_STAT is not set
> > > CONFIG_GENERIC_EARLY_IOREMAP=y
> > > # CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
> > > CONFIG_IDLE_PAGE_TRACKING=y
> > > CONFIG_ARCH_HAS_PTE_DEVMAP=y
> > > CONFIG_ZONE_DEVICE=y
> > > CONFIG_DEV_PAGEMAP_OPS=y
> > > CONFIG_HMM_MIRROR=y
> > > CONFIG_DEVICE_PRIVATE=y
> > > CONFIG_FRAME_VECTOR=y
> > > CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
> > > CONFIG_ARCH_HAS_PKEYS=y
> > > # CONFIG_PERCPU_STATS is not set
> > > # CONFIG_GUP_BENCHMARK is not set
> > > # CONFIG_READ_ONLY_THP_FOR_FS is not set
> > > CONFIG_ARCH_HAS_PTE_SPECIAL=y
> > > CONFIG_MAPPING_DIRTY_HELPERS=y
> > > # end of Memory Management options
> > > 
> > > CONFIG_NET=y
> > > CONFIG_COMPAT_NETLINK_MESSAGES=y
> > > CONFIG_NET_INGRESS=y
> > > CONFIG_NET_EGRESS=y
> > > CONFIG_SKB_EXTENSIONS=y
> > > 
> > > #
> > > # Networking options
> > > #
> > > CONFIG_PACKET=y
> > > CONFIG_PACKET_DIAG=m
> > > CONFIG_UNIX=y
> > > CONFIG_UNIX_SCM=y
> > > CONFIG_UNIX_DIAG=m
> > > CONFIG_TLS=m
> > > CONFIG_TLS_DEVICE=y
> > > # CONFIG_TLS_TOE is not set
> > > CONFIG_XFRM=y
> > > CONFIG_XFRM_OFFLOAD=y
> > > CONFIG_XFRM_ALGO=m
> > > CONFIG_XFRM_USER=m
> > > CONFIG_XFRM_INTERFACE=m
> > > # CONFIG_XFRM_SUB_POLICY is not set
> > > # CONFIG_XFRM_MIGRATE is not set
> > > CONFIG_XFRM_STATISTICS=y
> > > CONFIG_XFRM_IPCOMP=m
> > > CONFIG_NET_KEY=m
> > > # CONFIG_NET_KEY_MIGRATE is not set
> > > CONFIG_SMC=m
> > > CONFIG_SMC_DIAG=m
> > > CONFIG_XDP_SOCKETS=y
> > > CONFIG_XDP_SOCKETS_DIAG=m
> > > CONFIG_INET=y
> > > CONFIG_IP_MULTICAST=y
> > > CONFIG_IP_ADVANCED_ROUTER=y
> > > CONFIG_IP_FIB_TRIE_STATS=y
> > > CONFIG_IP_MULTIPLE_TABLES=y
> > > CONFIG_IP_ROUTE_MULTIPATH=y
> > > CONFIG_IP_ROUTE_VERBOSE=y
> > > CONFIG_IP_ROUTE_CLASSID=y
> > > # CONFIG_IP_PNP is not set
> > > CONFIG_NET_IPIP=m
> > > CONFIG_NET_IPGRE_DEMUX=m
> > > CONFIG_NET_IP_TUNNEL=m
> > > CONFIG_NET_IPGRE=m
> > > CONFIG_NET_IPGRE_BROADCAST=y
> > > CONFIG_IP_MROUTE_COMMON=y
> > > CONFIG_IP_MROUTE=y
> > > # CONFIG_IP_MROUTE_MULTIPLE_TABLES is not set
> > > CONFIG_IP_PIMSM_V1=y
> > > CONFIG_IP_PIMSM_V2=y
> > > CONFIG_SYN_COOKIES=y
> > > CONFIG_NET_IPVTI=m
> > > CONFIG_NET_UDP_TUNNEL=m
> > > CONFIG_NET_FOU=m
> > > CONFIG_NET_FOU_IP_TUNNELS=y
> > > CONFIG_INET_AH=m
> > > CONFIG_INET_ESP=m
> > > CONFIG_INET_ESP_OFFLOAD=m
> > > CONFIG_INET_IPCOMP=m
> > > CONFIG_INET_XFRM_TUNNEL=m
> > > CONFIG_INET_TUNNEL=m
> > > CONFIG_INET_DIAG=m
> > > CONFIG_INET_TCP_DIAG=m
> > > CONFIG_INET_UDP_DIAG=m
> > > CONFIG_INET_RAW_DIAG=m
> > > CONFIG_INET_DIAG_DESTROY=y
> > > CONFIG_TCP_CONG_ADVANCED=y
> > > CONFIG_TCP_CONG_BIC=m
> > > CONFIG_TCP_CONG_CUBIC=y
> > > CONFIG_TCP_CONG_WESTWOOD=m
> > > CONFIG_TCP_CONG_HTCP=m
> > > CONFIG_TCP_CONG_HSTCP=m
> > > CONFIG_TCP_CONG_HYBLA=m
> > > CONFIG_TCP_CONG_VEGAS=m
> > > CONFIG_TCP_CONG_NV=m
> > > CONFIG_TCP_CONG_SCALABLE=m
> > > CONFIG_TCP_CONG_LP=m
> > > CONFIG_TCP_CONG_VENO=m
> > > CONFIG_TCP_CONG_YEAH=m
> > > CONFIG_TCP_CONG_ILLINOIS=m
> > > CONFIG_TCP_CONG_DCTCP=m
> > > CONFIG_TCP_CONG_CDG=m
> > > CONFIG_TCP_CONG_BBR=m
> > > CONFIG_DEFAULT_CUBIC=y
> > > # CONFIG_DEFAULT_RENO is not set
> > > CONFIG_DEFAULT_TCP_CONG="cubic"
> > > CONFIG_TCP_MD5SIG=y
> > > CONFIG_IPV6=y
> > > CONFIG_IPV6_ROUTER_PREF=y
> > > CONFIG_IPV6_ROUTE_INFO=y
> > > # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> > > CONFIG_INET6_AH=m
> > > CONFIG_INET6_ESP=m
> > > CONFIG_INET6_ESP_OFFLOAD=m
> > > CONFIG_INET6_IPCOMP=m
> > > CONFIG_IPV6_MIP6=m
> > > CONFIG_IPV6_ILA=m
> > > CONFIG_INET6_XFRM_TUNNEL=m
> > > CONFIG_INET6_TUNNEL=m
> > > CONFIG_IPV6_VTI=m
> > > CONFIG_IPV6_SIT=m
> > > CONFIG_IPV6_SIT_6RD=y
> > > CONFIG_IPV6_NDISC_NODETYPE=y
> > > CONFIG_IPV6_TUNNEL=m
> > > CONFIG_IPV6_GRE=m
> > > CONFIG_IPV6_FOU=m
> > > CONFIG_IPV6_FOU_TUNNEL=m
> > > CONFIG_IPV6_MULTIPLE_TABLES=y
> > > CONFIG_IPV6_SUBTREES=y
> > > CONFIG_IPV6_MROUTE=y
> > > CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
> > > CONFIG_IPV6_PIMSM_V2=y
> > > CONFIG_IPV6_SEG6_LWTUNNEL=y
> > > CONFIG_IPV6_SEG6_HMAC=y
> > > CONFIG_IPV6_SEG6_BPF=y
> > > CONFIG_NETLABEL=y
> > > CONFIG_NETWORK_SECMARK=y
> > > CONFIG_NET_PTP_CLASSIFY=y
> > > CONFIG_NETWORK_PHY_TIMESTAMPING=y
> > > CONFIG_NETFILTER=y
> > > CONFIG_NETFILTER_ADVANCED=y
> > > CONFIG_BRIDGE_NETFILTER=m
> > > 
> > > #
> > > # Core Netfilter Configuration
> > > #
> > > CONFIG_NETFILTER_INGRESS=y
> > > CONFIG_NETFILTER_NETLINK=m
> > > CONFIG_NETFILTER_FAMILY_BRIDGE=y
> > > CONFIG_NETFILTER_FAMILY_ARP=y
> > > CONFIG_NETFILTER_NETLINK_ACCT=m
> > > CONFIG_NETFILTER_NETLINK_QUEUE=m
> > > CONFIG_NETFILTER_NETLINK_LOG=m
> > > CONFIG_NETFILTER_NETLINK_OSF=m
> > > CONFIG_NF_CONNTRACK=m
> > > CONFIG_NF_LOG_COMMON=m
> > > CONFIG_NF_LOG_NETDEV=m
> > > CONFIG_NETFILTER_CONNCOUNT=m
> > > CONFIG_NF_CONNTRACK_MARK=y
> > > CONFIG_NF_CONNTRACK_SECMARK=y
> > > CONFIG_NF_CONNTRACK_ZONES=y
> > > # CONFIG_NF_CONNTRACK_PROCFS is not set
> > > CONFIG_NF_CONNTRACK_EVENTS=y
> > > CONFIG_NF_CONNTRACK_TIMEOUT=y
> > > CONFIG_NF_CONNTRACK_TIMESTAMP=y
> > > CONFIG_NF_CONNTRACK_LABELS=y
> > > CONFIG_NF_CT_PROTO_DCCP=y
> > > CONFIG_NF_CT_PROTO_GRE=y
> > > CONFIG_NF_CT_PROTO_SCTP=y
> > > CONFIG_NF_CT_PROTO_UDPLITE=y
> > > CONFIG_NF_CONNTRACK_AMANDA=m
> > > CONFIG_NF_CONNTRACK_FTP=m
> > > CONFIG_NF_CONNTRACK_H323=m
> > > CONFIG_NF_CONNTRACK_IRC=m
> > > CONFIG_NF_CONNTRACK_BROADCAST=m
> > > CONFIG_NF_CONNTRACK_NETBIOS_NS=m
> > > CONFIG_NF_CONNTRACK_SNMP=m
> > > CONFIG_NF_CONNTRACK_PPTP=m
> > > CONFIG_NF_CONNTRACK_SANE=m
> > > CONFIG_NF_CONNTRACK_SIP=m
> > > CONFIG_NF_CONNTRACK_TFTP=m
> > > CONFIG_NF_CT_NETLINK=m
> > > CONFIG_NF_CT_NETLINK_TIMEOUT=m
> > > CONFIG_NF_CT_NETLINK_HELPER=m
> > > CONFIG_NETFILTER_NETLINK_GLUE_CT=y
> > > CONFIG_NF_NAT=m
> > > CONFIG_NF_NAT_AMANDA=m
> > > CONFIG_NF_NAT_FTP=m
> > > CONFIG_NF_NAT_IRC=m
> > > CONFIG_NF_NAT_SIP=m
> > > CONFIG_NF_NAT_TFTP=m
> > > CONFIG_NF_NAT_REDIRECT=y
> > > CONFIG_NF_NAT_MASQUERADE=y
> > > CONFIG_NETFILTER_SYNPROXY=m
> > > CONFIG_NF_TABLES=m
> > > CONFIG_NF_TABLES_SET=m
> > > CONFIG_NF_TABLES_INET=y
> > > CONFIG_NF_TABLES_NETDEV=y
> > > CONFIG_NFT_NUMGEN=m
> > > CONFIG_NFT_CT=m
> > > CONFIG_NFT_FLOW_OFFLOAD=m
> > > CONFIG_NFT_COUNTER=m
> > > CONFIG_NFT_CONNLIMIT=m
> > > CONFIG_NFT_LOG=m
> > > CONFIG_NFT_LIMIT=m
> > > CONFIG_NFT_MASQ=m
> > > CONFIG_NFT_REDIR=m
> > > CONFIG_NFT_NAT=m
> > > CONFIG_NFT_TUNNEL=m
> > > CONFIG_NFT_OBJREF=m
> > > CONFIG_NFT_QUEUE=m
> > > CONFIG_NFT_QUOTA=m
> > > CONFIG_NFT_REJECT=m
> > > CONFIG_NFT_REJECT_INET=m
> > > CONFIG_NFT_COMPAT=m
> > > CONFIG_NFT_HASH=m
> > > CONFIG_NFT_FIB=m
> > > CONFIG_NFT_FIB_INET=m
> > > CONFIG_NFT_XFRM=m
> > > CONFIG_NFT_SOCKET=m
> > > CONFIG_NFT_OSF=m
> > > CONFIG_NFT_TPROXY=m
> > > CONFIG_NFT_SYNPROXY=m
> > > CONFIG_NF_DUP_NETDEV=m
> > > CONFIG_NFT_DUP_NETDEV=m
> > > CONFIG_NFT_FWD_NETDEV=m
> > > CONFIG_NFT_FIB_NETDEV=m
> > > CONFIG_NF_FLOW_TABLE_INET=m
> > > CONFIG_NF_FLOW_TABLE=m
> > > CONFIG_NETFILTER_XTABLES=m
> > > 
> > > #
> > > # Xtables combined modules
> > > #
> > > CONFIG_NETFILTER_XT_MARK=m
> > > CONFIG_NETFILTER_XT_CONNMARK=m
> > > CONFIG_NETFILTER_XT_SET=m
> > > 
> > > #
> > > # Xtables targets
> > > #
> > > CONFIG_NETFILTER_XT_TARGET_AUDIT=m
> > > CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
> > > CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
> > > CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
> > > CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
> > > CONFIG_NETFILTER_XT_TARGET_CT=m
> > > CONFIG_NETFILTER_XT_TARGET_DSCP=m
> > > CONFIG_NETFILTER_XT_TARGET_HL=m
> > > CONFIG_NETFILTER_XT_TARGET_HMARK=m
> > > CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
> > > CONFIG_NETFILTER_XT_TARGET_LED=m
> > > CONFIG_NETFILTER_XT_TARGET_LOG=m
> > > CONFIG_NETFILTER_XT_TARGET_MARK=m
> > > CONFIG_NETFILTER_XT_NAT=m
> > > CONFIG_NETFILTER_XT_TARGET_NETMAP=m
> > > CONFIG_NETFILTER_XT_TARGET_NFLOG=m
> > > CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
> > > # CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
> > > CONFIG_NETFILTER_XT_TARGET_RATEEST=m
> > > CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
> > > CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
> > > CONFIG_NETFILTER_XT_TARGET_TEE=m
> > > CONFIG_NETFILTER_XT_TARGET_TPROXY=m
> > > CONFIG_NETFILTER_XT_TARGET_TRACE=m
> > > CONFIG_NETFILTER_XT_TARGET_SECMARK=m
> > > CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
> > > CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m
> > > 
> > > #
> > > # Xtables matches
> > > #
> > > CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
> > > CONFIG_NETFILTER_XT_MATCH_BPF=m
> > > CONFIG_NETFILTER_XT_MATCH_CGROUP=m
> > > CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
> > > CONFIG_NETFILTER_XT_MATCH_COMMENT=m
> > > CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
> > > CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
> > > CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
> > > CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
> > > CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
> > > CONFIG_NETFILTER_XT_MATCH_CPU=m
> > > CONFIG_NETFILTER_XT_MATCH_DCCP=m
> > > CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
> > > CONFIG_NETFILTER_XT_MATCH_DSCP=m
> > > CONFIG_NETFILTER_XT_MATCH_ECN=m
> > > CONFIG_NETFILTER_XT_MATCH_ESP=m
> > > CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
> > > CONFIG_NETFILTER_XT_MATCH_HELPER=m
> > > CONFIG_NETFILTER_XT_MATCH_HL=m
> > > CONFIG_NETFILTER_XT_MATCH_IPCOMP=m
> > > CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
> > > CONFIG_NETFILTER_XT_MATCH_IPVS=m
> > > CONFIG_NETFILTER_XT_MATCH_L2TP=m
> > > CONFIG_NETFILTER_XT_MATCH_LENGTH=m
> > > CONFIG_NETFILTER_XT_MATCH_LIMIT=m
> > > CONFIG_NETFILTER_XT_MATCH_MAC=m
> > > CONFIG_NETFILTER_XT_MATCH_MARK=m
> > > CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
> > > CONFIG_NETFILTER_XT_MATCH_NFACCT=m
> > > CONFIG_NETFILTER_XT_MATCH_OSF=m
> > > CONFIG_NETFILTER_XT_MATCH_OWNER=m
> > > CONFIG_NETFILTER_XT_MATCH_POLICY=m
> > > CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
> > > CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
> > > CONFIG_NETFILTER_XT_MATCH_QUOTA=m
> > > CONFIG_NETFILTER_XT_MATCH_RATEEST=m
> > > CONFIG_NETFILTER_XT_MATCH_REALM=m
> > > CONFIG_NETFILTER_XT_MATCH_RECENT=m
> > > CONFIG_NETFILTER_XT_MATCH_SCTP=m
> > > CONFIG_NETFILTER_XT_MATCH_SOCKET=m
> > > CONFIG_NETFILTER_XT_MATCH_STATE=m
> > > CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
> > > CONFIG_NETFILTER_XT_MATCH_STRING=m
> > > CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
> > > CONFIG_NETFILTER_XT_MATCH_TIME=m
> > > CONFIG_NETFILTER_XT_MATCH_U32=m
> > > # end of Core Netfilter Configuration
> > > 
> > > CONFIG_IP_SET=m
> > > CONFIG_IP_SET_MAX=256
> > > CONFIG_IP_SET_BITMAP_IP=m
> > > CONFIG_IP_SET_BITMAP_IPMAC=m
> > > CONFIG_IP_SET_BITMAP_PORT=m
> > > CONFIG_IP_SET_HASH_IP=m
> > > CONFIG_IP_SET_HASH_IPMARK=m
> > > CONFIG_IP_SET_HASH_IPPORT=m
> > > CONFIG_IP_SET_HASH_IPPORTIP=m
> > > CONFIG_IP_SET_HASH_IPPORTNET=m
> > > CONFIG_IP_SET_HASH_IPMAC=m
> > > CONFIG_IP_SET_HASH_MAC=m
> > > CONFIG_IP_SET_HASH_NETPORTNET=m
> > > CONFIG_IP_SET_HASH_NET=m
> > > CONFIG_IP_SET_HASH_NETNET=m
> > > CONFIG_IP_SET_HASH_NETPORT=m
> > > CONFIG_IP_SET_HASH_NETIFACE=m
> > > CONFIG_IP_SET_LIST_SET=m
> > > CONFIG_IP_VS=m
> > > CONFIG_IP_VS_IPV6=y
> > > # CONFIG_IP_VS_DEBUG is not set
> > > CONFIG_IP_VS_TAB_BITS=12
> > > 
> > > #
> > > # IPVS transport protocol load balancing support
> > > #
> > > CONFIG_IP_VS_PROTO_TCP=y
> > > CONFIG_IP_VS_PROTO_UDP=y
> > > CONFIG_IP_VS_PROTO_AH_ESP=y
> > > CONFIG_IP_VS_PROTO_ESP=y
> > > CONFIG_IP_VS_PROTO_AH=y
> > > CONFIG_IP_VS_PROTO_SCTP=y
> > > 
> > > #
> > > # IPVS scheduler
> > > #
> > > CONFIG_IP_VS_RR=m
> > > CONFIG_IP_VS_WRR=m
> > > CONFIG_IP_VS_LC=m
> > > CONFIG_IP_VS_WLC=m
> > > CONFIG_IP_VS_FO=m
> > > CONFIG_IP_VS_OVF=m
> > > CONFIG_IP_VS_LBLC=m
> > > CONFIG_IP_VS_LBLCR=m
> > > CONFIG_IP_VS_DH=m
> > > CONFIG_IP_VS_SH=m
> > > CONFIG_IP_VS_MH=m
> > > CONFIG_IP_VS_SED=m
> > > CONFIG_IP_VS_NQ=m
> > > 
> > > #
> > > # IPVS SH scheduler
> > > #
> > > CONFIG_IP_VS_SH_TAB_BITS=8
> > > 
> > > #
> > > # IPVS MH scheduler
> > > #
> > > CONFIG_IP_VS_MH_TAB_INDEX=12
> > > 
> > > #
> > > # IPVS application helper
> > > #
> > > CONFIG_IP_VS_FTP=m
> > > CONFIG_IP_VS_NFCT=y
> > > CONFIG_IP_VS_PE_SIP=m
> > > 
> > > #
> > > # IP: Netfilter Configuration
> > > #
> > > CONFIG_NF_DEFRAG_IPV4=m
> > > CONFIG_NF_SOCKET_IPV4=m
> > > CONFIG_NF_TPROXY_IPV4=m
> > > CONFIG_NF_TABLES_IPV4=y
> > > CONFIG_NFT_REJECT_IPV4=m
> > > CONFIG_NFT_DUP_IPV4=m
> > > CONFIG_NFT_FIB_IPV4=m
> > > CONFIG_NF_TABLES_ARP=y
> > > CONFIG_NF_FLOW_TABLE_IPV4=m
> > > CONFIG_NF_DUP_IPV4=m
> > > CONFIG_NF_LOG_ARP=m
> > > CONFIG_NF_LOG_IPV4=m
> > > CONFIG_NF_REJECT_IPV4=m
> > > CONFIG_NF_NAT_SNMP_BASIC=m
> > > CONFIG_NF_NAT_PPTP=m
> > > CONFIG_NF_NAT_H323=m
> > > CONFIG_IP_NF_IPTABLES=m
> > > CONFIG_IP_NF_MATCH_AH=m
> > > CONFIG_IP_NF_MATCH_ECN=m
> > > CONFIG_IP_NF_MATCH_RPFILTER=m
> > > CONFIG_IP_NF_MATCH_TTL=m
> > > CONFIG_IP_NF_FILTER=m
> > > CONFIG_IP_NF_TARGET_REJECT=m
> > > CONFIG_IP_NF_TARGET_SYNPROXY=m
> > > CONFIG_IP_NF_NAT=m
> > > CONFIG_IP_NF_TARGET_MASQUERADE=m
> > > CONFIG_IP_NF_TARGET_NETMAP=m
> > > CONFIG_IP_NF_TARGET_REDIRECT=m
> > > CONFIG_IP_NF_MANGLE=m
> > > CONFIG_IP_NF_TARGET_CLUSTERIP=m
> > > CONFIG_IP_NF_TARGET_ECN=m
> > > CONFIG_IP_NF_TARGET_TTL=m
> > > CONFIG_IP_NF_RAW=m
> > > CONFIG_IP_NF_SECURITY=m
> > > CONFIG_IP_NF_ARPTABLES=m
> > > CONFIG_IP_NF_ARPFILTER=m
> > > CONFIG_IP_NF_ARP_MANGLE=m
> > > # end of IP: Netfilter Configuration
> > > 
> > > #
> > > # IPv6: Netfilter Configuration
> > > #
> > > CONFIG_NF_SOCKET_IPV6=m
> > > CONFIG_NF_TPROXY_IPV6=m
> > > CONFIG_NF_TABLES_IPV6=y
> > > CONFIG_NFT_REJECT_IPV6=m
> > > CONFIG_NFT_DUP_IPV6=m
> > > CONFIG_NFT_FIB_IPV6=m
> > > CONFIG_NF_FLOW_TABLE_IPV6=m
> > > CONFIG_NF_DUP_IPV6=m
> > > CONFIG_NF_REJECT_IPV6=m
> > > CONFIG_NF_LOG_IPV6=m
> > > CONFIG_IP6_NF_IPTABLES=m
> > > CONFIG_IP6_NF_MATCH_AH=m
> > > CONFIG_IP6_NF_MATCH_EUI64=m
> > > CONFIG_IP6_NF_MATCH_FRAG=m
> > > CONFIG_IP6_NF_MATCH_OPTS=m
> > > CONFIG_IP6_NF_MATCH_HL=m
> > > CONFIG_IP6_NF_MATCH_IPV6HEADER=m
> > > CONFIG_IP6_NF_MATCH_MH=m
> > > CONFIG_IP6_NF_MATCH_RPFILTER=m
> > > CONFIG_IP6_NF_MATCH_RT=m
> > > CONFIG_IP6_NF_MATCH_SRH=m
> > > CONFIG_IP6_NF_TARGET_HL=m
> > > CONFIG_IP6_NF_FILTER=m
> > > CONFIG_IP6_NF_TARGET_REJECT=m
> > > CONFIG_IP6_NF_TARGET_SYNPROXY=m
> > > CONFIG_IP6_NF_MANGLE=m
> > > CONFIG_IP6_NF_RAW=m
> > > CONFIG_IP6_NF_SECURITY=m
> > > CONFIG_IP6_NF_NAT=m
> > > CONFIG_IP6_NF_TARGET_MASQUERADE=m
> > > CONFIG_IP6_NF_TARGET_NPT=m
> > > # end of IPv6: Netfilter Configuration
> > > 
> > > CONFIG_NF_DEFRAG_IPV6=m
> > > 
> > > #
> > > # DECnet: Netfilter Configuration
> > > #
> > > CONFIG_DECNET_NF_GRABULATOR=m
> > > # end of DECnet: Netfilter Configuration
> > > 
> > > CONFIG_NF_TABLES_BRIDGE=m
> > > CONFIG_NFT_BRIDGE_META=m
> > > CONFIG_NFT_BRIDGE_REJECT=m
> > > CONFIG_NF_LOG_BRIDGE=m
> > > CONFIG_NF_CONNTRACK_BRIDGE=m
> > > CONFIG_BRIDGE_NF_EBTABLES=m
> > > CONFIG_BRIDGE_EBT_BROUTE=m
> > > CONFIG_BRIDGE_EBT_T_FILTER=m
> > > CONFIG_BRIDGE_EBT_T_NAT=m
> > > CONFIG_BRIDGE_EBT_802_3=m
> > > CONFIG_BRIDGE_EBT_AMONG=m
> > > CONFIG_BRIDGE_EBT_ARP=m
> > > CONFIG_BRIDGE_EBT_IP=m
> > > CONFIG_BRIDGE_EBT_IP6=m
> > > CONFIG_BRIDGE_EBT_LIMIT=m
> > > CONFIG_BRIDGE_EBT_MARK=m
> > > CONFIG_BRIDGE_EBT_PKTTYPE=m
> > > CONFIG_BRIDGE_EBT_STP=m
> > > CONFIG_BRIDGE_EBT_VLAN=m
> > > CONFIG_BRIDGE_EBT_ARPREPLY=m
> > > CONFIG_BRIDGE_EBT_DNAT=m
> > > CONFIG_BRIDGE_EBT_MARK_T=m
> > > CONFIG_BRIDGE_EBT_REDIRECT=m
> > > CONFIG_BRIDGE_EBT_SNAT=m
> > > CONFIG_BRIDGE_EBT_LOG=m
> > > CONFIG_BRIDGE_EBT_NFLOG=m
> > > CONFIG_BPFILTER=y
> > > CONFIG_BPFILTER_UMH=m
> > > CONFIG_IP_DCCP=m
> > > CONFIG_INET_DCCP_DIAG=m
> > > 
> > > #
> > > # DCCP CCIDs Configuration
> > > #
> > > # CONFIG_IP_DCCP_CCID2_DEBUG is not set
> > > # CONFIG_IP_DCCP_CCID3 is not set
> > > # end of DCCP CCIDs Configuration
> > > 
> > > #
> > > # DCCP Kernel Hacking
> > > #
> > > # CONFIG_IP_DCCP_DEBUG is not set
> > > # end of DCCP Kernel Hacking
> > > 
> > > CONFIG_IP_SCTP=m
> > > # CONFIG_SCTP_DBG_OBJCNT is not set
> > > # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
> > > CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
> > > # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
> > > CONFIG_SCTP_COOKIE_HMAC_MD5=y
> > > CONFIG_SCTP_COOKIE_HMAC_SHA1=y
> > > CONFIG_INET_SCTP_DIAG=m
> > > CONFIG_RDS=m
> > > CONFIG_RDS_RDMA=m
> > > CONFIG_RDS_TCP=m
> > > # CONFIG_RDS_DEBUG is not set
> > > CONFIG_TIPC=m
> > > CONFIG_TIPC_MEDIA_IB=y
> > > CONFIG_TIPC_MEDIA_UDP=y
> > > CONFIG_TIPC_CRYPTO=y
> > > CONFIG_TIPC_DIAG=m
> > > CONFIG_ATM=m
> > > CONFIG_ATM_CLIP=m
> > > # CONFIG_ATM_CLIP_NO_ICMP is not set
> > > CONFIG_ATM_LANE=m
> > > CONFIG_ATM_MPOA=m
> > > CONFIG_ATM_BR2684=m
> > > # CONFIG_ATM_BR2684_IPFILTER is not set
> > > CONFIG_L2TP=m
> > > CONFIG_L2TP_DEBUGFS=m
> > > CONFIG_L2TP_V3=y
> > > CONFIG_L2TP_IP=m
> > > CONFIG_L2TP_ETH=m
> > > CONFIG_STP=m
> > > CONFIG_GARP=m
> > > CONFIG_MRP=m
> > > CONFIG_BRIDGE=m
> > > CONFIG_BRIDGE_IGMP_SNOOPING=y
> > > CONFIG_BRIDGE_VLAN_FILTERING=y
> > > CONFIG_HAVE_NET_DSA=y
> > > CONFIG_NET_DSA=m
> > > CONFIG_NET_DSA_TAG_8021Q=m
> > > CONFIG_NET_DSA_TAG_BRCM_COMMON=m
> > > CONFIG_NET_DSA_TAG_BRCM=m
> > > CONFIG_NET_DSA_TAG_BRCM_PREPEND=m
> > > CONFIG_NET_DSA_TAG_GSWIP=m
> > > CONFIG_NET_DSA_TAG_DSA=m
> > > CONFIG_NET_DSA_TAG_EDSA=m
> > > CONFIG_NET_DSA_TAG_MTK=m
> > > CONFIG_NET_DSA_TAG_KSZ=m
> > > # CONFIG_NET_DSA_TAG_OCELOT is not set
> > > CONFIG_NET_DSA_TAG_QCA=m
> > > CONFIG_NET_DSA_TAG_LAN9303=m
> > > CONFIG_NET_DSA_TAG_SJA1105=m
> > > CONFIG_NET_DSA_TAG_TRAILER=m
> > > CONFIG_VLAN_8021Q=m
> > > CONFIG_VLAN_8021Q_GVRP=y
> > > CONFIG_VLAN_8021Q_MVRP=y
> > > CONFIG_DECNET=m
> > > # CONFIG_DECNET_ROUTER is not set
> > > CONFIG_LLC=m
> > > CONFIG_LLC2=m
> > > CONFIG_ATALK=m
> > > CONFIG_DEV_APPLETALK=m
> > > CONFIG_LTPC=m
> > > CONFIG_COPS=m
> > > CONFIG_COPS_DAYNA=y
> > > CONFIG_COPS_TANGENT=y
> > > # CONFIG_IPDDP is not set
> > > CONFIG_X25=m
> > > CONFIG_LAPB=m
> > > CONFIG_PHONET=m
> > > CONFIG_6LOWPAN=m
> > > # CONFIG_6LOWPAN_DEBUGFS is not set
> > > CONFIG_6LOWPAN_NHC=m
> > > CONFIG_6LOWPAN_NHC_DEST=m
> > > CONFIG_6LOWPAN_NHC_FRAGMENT=m
> > > CONFIG_6LOWPAN_NHC_HOP=m
> > > CONFIG_6LOWPAN_NHC_IPV6=m
> > > CONFIG_6LOWPAN_NHC_MOBILITY=m
> > > CONFIG_6LOWPAN_NHC_ROUTING=m
> > > CONFIG_6LOWPAN_NHC_UDP=m
> > > # CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
> > > # CONFIG_6LOWPAN_GHC_UDP is not set
> > > # CONFIG_6LOWPAN_GHC_ICMPV6 is not set
> > > # CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
> > > # CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
> > > # CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
> > > CONFIG_IEEE802154=m
> > > # CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
> > > CONFIG_IEEE802154_SOCKET=m
> > > CONFIG_IEEE802154_6LOWPAN=m
> > > CONFIG_MAC802154=m
> > > CONFIG_NET_SCHED=y
> > > 
> > > #
> > > # Queueing/Scheduling
> > > #
> > > CONFIG_NET_SCH_CBQ=m
> > > CONFIG_NET_SCH_HTB=m
> > > CONFIG_NET_SCH_HFSC=m
> > > CONFIG_NET_SCH_ATM=m
> > > CONFIG_NET_SCH_PRIO=m
> > > CONFIG_NET_SCH_MULTIQ=m
> > > CONFIG_NET_SCH_RED=m
> > > CONFIG_NET_SCH_SFB=m
> > > CONFIG_NET_SCH_SFQ=m
> > > CONFIG_NET_SCH_TEQL=m
> > > CONFIG_NET_SCH_TBF=m
> > > CONFIG_NET_SCH_CBS=m
> > > CONFIG_NET_SCH_ETF=m
> > > CONFIG_NET_SCH_TAPRIO=m
> > > CONFIG_NET_SCH_GRED=m
> > > CONFIG_NET_SCH_DSMARK=m
> > > CONFIG_NET_SCH_NETEM=m
> > > CONFIG_NET_SCH_DRR=m
> > > CONFIG_NET_SCH_MQPRIO=m
> > > CONFIG_NET_SCH_SKBPRIO=m
> > > CONFIG_NET_SCH_CHOKE=m
> > > CONFIG_NET_SCH_QFQ=m
> > > CONFIG_NET_SCH_CODEL=m
> > > CONFIG_NET_SCH_FQ_CODEL=m
> > > CONFIG_NET_SCH_CAKE=m
> > > CONFIG_NET_SCH_FQ=m
> > > CONFIG_NET_SCH_HHF=m
> > > CONFIG_NET_SCH_PIE=m
> > > CONFIG_NET_SCH_INGRESS=m
> > > CONFIG_NET_SCH_PLUG=m
> > > # CONFIG_NET_SCH_DEFAULT is not set
> > > 
> > > #
> > > # Classification
> > > #
> > > CONFIG_NET_CLS=y
> > > CONFIG_NET_CLS_BASIC=m
> > > CONFIG_NET_CLS_TCINDEX=m
> > > CONFIG_NET_CLS_ROUTE4=m
> > > CONFIG_NET_CLS_FW=m
> > > CONFIG_NET_CLS_U32=m
> > > # CONFIG_CLS_U32_PERF is not set
> > > CONFIG_CLS_U32_MARK=y
> > > CONFIG_NET_CLS_RSVP=m
> > > CONFIG_NET_CLS_RSVP6=m
> > > CONFIG_NET_CLS_FLOW=m
> > > CONFIG_NET_CLS_CGROUP=m
> > > CONFIG_NET_CLS_BPF=m
> > > CONFIG_NET_CLS_FLOWER=m
> > > CONFIG_NET_CLS_MATCHALL=m
> > > CONFIG_NET_EMATCH=y
> > > CONFIG_NET_EMATCH_STACK=32
> > > CONFIG_NET_EMATCH_CMP=m
> > > CONFIG_NET_EMATCH_NBYTE=m
> > > CONFIG_NET_EMATCH_U32=m
> > > CONFIG_NET_EMATCH_META=m
> > > CONFIG_NET_EMATCH_TEXT=m
> > > CONFIG_NET_EMATCH_CANID=m
> > > CONFIG_NET_EMATCH_IPSET=m
> > > CONFIG_NET_EMATCH_IPT=m
> > > CONFIG_NET_CLS_ACT=y
> > > CONFIG_NET_ACT_POLICE=m
> > > CONFIG_NET_ACT_GACT=m
> > > CONFIG_GACT_PROB=y
> > > CONFIG_NET_ACT_MIRRED=m
> > > CONFIG_NET_ACT_SAMPLE=m
> > > CONFIG_NET_ACT_IPT=m
> > > CONFIG_NET_ACT_NAT=m
> > > CONFIG_NET_ACT_PEDIT=m
> > > CONFIG_NET_ACT_SIMP=m
> > > CONFIG_NET_ACT_SKBEDIT=m
> > > CONFIG_NET_ACT_CSUM=m
> > > CONFIG_NET_ACT_MPLS=m
> > > CONFIG_NET_ACT_VLAN=m
> > > CONFIG_NET_ACT_BPF=m
> > > CONFIG_NET_ACT_CONNMARK=m
> > > CONFIG_NET_ACT_CTINFO=m
> > > CONFIG_NET_ACT_SKBMOD=m
> > > # CONFIG_NET_ACT_IFE is not set
> > > CONFIG_NET_ACT_TUNNEL_KEY=m
> > > CONFIG_NET_ACT_CT=m
> > > # CONFIG_NET_TC_SKB_EXT is not set
> > > CONFIG_NET_SCH_FIFO=y
> > > CONFIG_DCB=y
> > > CONFIG_DNS_RESOLVER=y
> > > CONFIG_BATMAN_ADV=m
> > > # CONFIG_BATMAN_ADV_BATMAN_V is not set
> > > CONFIG_BATMAN_ADV_BLA=y
> > > CONFIG_BATMAN_ADV_DAT=y
> > > CONFIG_BATMAN_ADV_NC=y
> > > CONFIG_BATMAN_ADV_MCAST=y
> > > # CONFIG_BATMAN_ADV_DEBUGFS is not set
> > > # CONFIG_BATMAN_ADV_DEBUG is not set
> > > CONFIG_BATMAN_ADV_SYSFS=y
> > > # CONFIG_BATMAN_ADV_TRACING is not set
> > > CONFIG_OPENVSWITCH=m
> > > CONFIG_OPENVSWITCH_GRE=m
> > > CONFIG_OPENVSWITCH_VXLAN=m
> > > CONFIG_OPENVSWITCH_GENEVE=m
> > > CONFIG_VSOCKETS=m
> > > CONFIG_VSOCKETS_DIAG=m
> > > CONFIG_VMWARE_VMCI_VSOCKETS=m
> > > CONFIG_VIRTIO_VSOCKETS=m
> > > CONFIG_VIRTIO_VSOCKETS_COMMON=m
> > > CONFIG_HYPERV_VSOCKETS=m
> > > CONFIG_NETLINK_DIAG=m
> > > CONFIG_MPLS=y
> > > CONFIG_NET_MPLS_GSO=m
> > > CONFIG_MPLS_ROUTING=m
> > > CONFIG_MPLS_IPTUNNEL=m
> > > CONFIG_NET_NSH=m
> > > CONFIG_HSR=m
> > > CONFIG_NET_SWITCHDEV=y
> > > CONFIG_NET_L3_MASTER_DEV=y
> > > CONFIG_NET_NCSI=y
> > > CONFIG_NCSI_OEM_CMD_GET_MAC=y
> > > CONFIG_RPS=y
> > > CONFIG_RFS_ACCEL=y
> > > CONFIG_XPS=y
> > > CONFIG_CGROUP_NET_PRIO=y
> > > CONFIG_CGROUP_NET_CLASSID=y
> > > CONFIG_NET_RX_BUSY_POLL=y
> > > CONFIG_BQL=y
> > > CONFIG_BPF_JIT=y
> > > CONFIG_BPF_STREAM_PARSER=y
> > > CONFIG_NET_FLOW_LIMIT=y
> > > 
> > > #
> > > # Network testing
> > > #
> > > CONFIG_NET_PKTGEN=m
> > > CONFIG_NET_DROP_MONITOR=y
> > > # end of Network testing
> > > # end of Networking options
> > > 
> > > CONFIG_HAMRADIO=y
> > > 
> > > #
> > > # Packet Radio protocols
> > > #
> > > CONFIG_AX25=m
> > > CONFIG_AX25_DAMA_SLAVE=y
> > > CONFIG_NETROM=m
> > > CONFIG_ROSE=m
> > > 
> > > #
> > > # AX.25 network device drivers
> > > #
> > > CONFIG_MKISS=m
> > > CONFIG_6PACK=m
> > > CONFIG_BPQETHER=m
> > > CONFIG_BAYCOM_SER_FDX=m
> > > CONFIG_BAYCOM_SER_HDX=m
> > > CONFIG_BAYCOM_PAR=m
> > > CONFIG_YAM=m
> > > # end of AX.25 network device drivers
> > > 
> > > CONFIG_CAN=m
> > > CONFIG_CAN_RAW=m
> > > CONFIG_CAN_BCM=m
> > > CONFIG_CAN_GW=m
> > > # CONFIG_CAN_J1939 is not set
> > > 
> > > #
> > > # CAN Device Drivers
> > > #
> > > CONFIG_CAN_VCAN=m
> > > CONFIG_CAN_VXCAN=m
> > > CONFIG_CAN_SLCAN=m
> > > CONFIG_CAN_DEV=m
> > > CONFIG_CAN_CALC_BITTIMING=y
> > > CONFIG_CAN_JANZ_ICAN3=m
> > > # CONFIG_CAN_KVASER_PCIEFD is not set
> > > CONFIG_CAN_C_CAN=m
> > > CONFIG_CAN_C_CAN_PLATFORM=m
> > > CONFIG_CAN_C_CAN_PCI=m
> > > CONFIG_CAN_CC770=m
> > > CONFIG_CAN_CC770_ISA=m
> > > CONFIG_CAN_CC770_PLATFORM=m
> > > CONFIG_CAN_IFI_CANFD=m
> > > CONFIG_CAN_M_CAN=m
> > > # CONFIG_CAN_M_CAN_PLATFORM is not set
> > > # CONFIG_CAN_M_CAN_TCAN4X5X is not set
> > > CONFIG_CAN_PEAK_PCIEFD=m
> > > CONFIG_CAN_SJA1000=m
> > > CONFIG_CAN_EMS_PCI=m
> > > CONFIG_CAN_EMS_PCMCIA=m
> > > # CONFIG_CAN_F81601 is not set
> > > CONFIG_CAN_KVASER_PCI=m
> > > CONFIG_CAN_PEAK_PCI=m
> > > CONFIG_CAN_PEAK_PCIEC=y
> > > CONFIG_CAN_PEAK_PCMCIA=m
> > > CONFIG_CAN_PLX_PCI=m
> > > CONFIG_CAN_SJA1000_ISA=m
> > > CONFIG_CAN_SJA1000_PLATFORM=m
> > > CONFIG_CAN_SOFTING=m
> > > CONFIG_CAN_SOFTING_CS=m
> > > 
> > > #
> > > # CAN SPI interfaces
> > > #
> > > CONFIG_CAN_HI311X=m
> > > CONFIG_CAN_MCP251X=m
> > > # end of CAN SPI interfaces
> > > 
> > > #
> > > # CAN USB interfaces
> > > #
> > > CONFIG_CAN_8DEV_USB=m
> > > CONFIG_CAN_EMS_USB=m
> > > CONFIG_CAN_ESD_USB2=m
> > > CONFIG_CAN_GS_USB=m
> > > CONFIG_CAN_KVASER_USB=m
> > > CONFIG_CAN_MCBA_USB=m
> > > CONFIG_CAN_PEAK_USB=m
> > > CONFIG_CAN_UCAN=m
> > > # end of CAN USB interfaces
> > > 
> > > # CONFIG_CAN_DEBUG_DEVICES is not set
> > > # end of CAN Device Drivers
> > > 
> > > CONFIG_BT=m
> > > CONFIG_BT_BREDR=y
> > > CONFIG_BT_RFCOMM=m
> > > CONFIG_BT_RFCOMM_TTY=y
> > > CONFIG_BT_BNEP=m
> > > CONFIG_BT_BNEP_MC_FILTER=y
> > > CONFIG_BT_BNEP_PROTO_FILTER=y
> > > CONFIG_BT_CMTP=m
> > > CONFIG_BT_HIDP=m
> > > CONFIG_BT_HS=y
> > > CONFIG_BT_LE=y
> > > CONFIG_BT_6LOWPAN=m
> > > CONFIG_BT_LEDS=y
> > > # CONFIG_BT_SELFTEST is not set
> > > CONFIG_BT_DEBUGFS=y
> > > 
> > > #
> > > # Bluetooth device drivers
> > > #
> > > CONFIG_BT_INTEL=m
> > > CONFIG_BT_BCM=m
> > > CONFIG_BT_RTL=m
> > > CONFIG_BT_QCA=m
> > > CONFIG_BT_HCIBTUSB=m
> > > CONFIG_BT_HCIBTUSB_AUTOSUSPEND=y
> > > CONFIG_BT_HCIBTUSB_BCM=y
> > > CONFIG_BT_HCIBTUSB_MTK=y
> > > CONFIG_BT_HCIBTUSB_RTL=y
> > > CONFIG_BT_HCIBTSDIO=m
> > > CONFIG_BT_HCIUART=m
> > > CONFIG_BT_HCIUART_SERDEV=y
> > > CONFIG_BT_HCIUART_H4=y
> > > CONFIG_BT_HCIUART_NOKIA=m
> > > CONFIG_BT_HCIUART_BCSP=y
> > > CONFIG_BT_HCIUART_ATH3K=y
> > > CONFIG_BT_HCIUART_LL=y
> > > CONFIG_BT_HCIUART_3WIRE=y
> > > CONFIG_BT_HCIUART_INTEL=y
> > > CONFIG_BT_HCIUART_BCM=y
> > > CONFIG_BT_HCIUART_RTL=y
> > > CONFIG_BT_HCIUART_QCA=y
> > > CONFIG_BT_HCIUART_AG6XX=y
> > > CONFIG_BT_HCIUART_MRVL=y
> > > CONFIG_BT_HCIBCM203X=m
> > > CONFIG_BT_HCIBPA10X=m
> > > CONFIG_BT_HCIBFUSB=m
> > > CONFIG_BT_HCIDTL1=m
> > > CONFIG_BT_HCIBT3C=m
> > > CONFIG_BT_HCIBLUECARD=m
> > > CONFIG_BT_HCIVHCI=m
> > > CONFIG_BT_MRVL=m
> > > CONFIG_BT_MRVL_SDIO=m
> > > CONFIG_BT_ATH3K=m
> > > CONFIG_BT_MTKSDIO=m
> > > CONFIG_BT_MTKUART=m
> > > CONFIG_BT_HCIRSI=m
> > > # end of Bluetooth device drivers
> > > 
> > > CONFIG_AF_RXRPC=m
> > > CONFIG_AF_RXRPC_IPV6=y
> > > # CONFIG_AF_RXRPC_INJECT_LOSS is not set
> > > # CONFIG_AF_RXRPC_DEBUG is not set
> > > CONFIG_RXKAD=y
> > > CONFIG_AF_KCM=m
> > > CONFIG_STREAM_PARSER=y
> > > CONFIG_FIB_RULES=y
> > > CONFIG_WIRELESS=y
> > > CONFIG_WIRELESS_EXT=y
> > > CONFIG_WEXT_CORE=y
> > > CONFIG_WEXT_PROC=y
> > > CONFIG_WEXT_SPY=y
> > > CONFIG_WEXT_PRIV=y
> > > CONFIG_CFG80211=m
> > > # CONFIG_NL80211_TESTMODE is not set
> > > # CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
> > > # CONFIG_CFG80211_CERTIFICATION_ONUS is not set
> > > CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
> > > CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
> > > CONFIG_CFG80211_DEFAULT_PS=y
> > > CONFIG_CFG80211_DEBUGFS=y
> > > CONFIG_CFG80211_CRDA_SUPPORT=y
> > > CONFIG_CFG80211_WEXT=y
> > > CONFIG_CFG80211_WEXT_EXPORT=y
> > > CONFIG_LIB80211=m
> > > CONFIG_LIB80211_CRYPT_WEP=m
> > > CONFIG_LIB80211_CRYPT_CCMP=m
> > > CONFIG_LIB80211_CRYPT_TKIP=m
> > > # CONFIG_LIB80211_DEBUG is not set
> > > CONFIG_MAC80211=m
> > > CONFIG_MAC80211_HAS_RC=y
> > > CONFIG_MAC80211_RC_MINSTREL=y
> > > CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
> > > CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
> > > CONFIG_MAC80211_MESH=y
> > > CONFIG_MAC80211_LEDS=y
> > > CONFIG_MAC80211_DEBUGFS=y
> > > CONFIG_MAC80211_MESSAGE_TRACING=y
> > > # CONFIG_MAC80211_DEBUG_MENU is not set
> > > CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> > > CONFIG_WIMAX=m
> > > CONFIG_WIMAX_DEBUG_LEVEL=8
> > > CONFIG_RFKILL=y
> > > CONFIG_RFKILL_LEDS=y
> > > CONFIG_RFKILL_INPUT=y
> > > CONFIG_RFKILL_GPIO=m
> > > CONFIG_NET_9P=m
> > > CONFIG_NET_9P_VIRTIO=m
> > > CONFIG_NET_9P_XEN=m
> > > CONFIG_NET_9P_RDMA=m
> > > # CONFIG_NET_9P_DEBUG is not set
> > > CONFIG_CAIF=m
> > > # CONFIG_CAIF_DEBUG is not set
> > > CONFIG_CAIF_NETDEV=m
> > > CONFIG_CAIF_USB=m
> > > CONFIG_CEPH_LIB=m
> > > # CONFIG_CEPH_LIB_PRETTYDEBUG is not set
> > > CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
> > > CONFIG_NFC=m
> > > CONFIG_NFC_DIGITAL=m
> > > CONFIG_NFC_NCI=m
> > > CONFIG_NFC_NCI_SPI=m
> > > CONFIG_NFC_NCI_UART=m
> > > CONFIG_NFC_HCI=m
> > > CONFIG_NFC_SHDLC=y
> > > 
> > > #
> > > # Near Field Communication (NFC) devices
> > > #
> > > CONFIG_NFC_TRF7970A=m
> > > CONFIG_NFC_MEI_PHY=m
> > > CONFIG_NFC_SIM=m
> > > CONFIG_NFC_PORT100=m
> > > CONFIG_NFC_FDP=m
> > > CONFIG_NFC_FDP_I2C=m
> > > CONFIG_NFC_PN544=m
> > > CONFIG_NFC_PN544_I2C=m
> > > CONFIG_NFC_PN544_MEI=m
> > > CONFIG_NFC_PN533=m
> > > CONFIG_NFC_PN533_USB=m
> > > CONFIG_NFC_PN533_I2C=m
> > > # CONFIG_NFC_PN532_UART is not set
> > > CONFIG_NFC_MICROREAD=m
> > > CONFIG_NFC_MICROREAD_I2C=m
> > > CONFIG_NFC_MICROREAD_MEI=m
> > > CONFIG_NFC_MRVL=m
> > > CONFIG_NFC_MRVL_USB=m
> > > CONFIG_NFC_MRVL_UART=m
> > > CONFIG_NFC_MRVL_I2C=m
> > > CONFIG_NFC_MRVL_SPI=m
> > > CONFIG_NFC_ST21NFCA=m
> > > CONFIG_NFC_ST21NFCA_I2C=m
> > > CONFIG_NFC_ST_NCI=m
> > > CONFIG_NFC_ST_NCI_I2C=m
> > > CONFIG_NFC_ST_NCI_SPI=m
> > > CONFIG_NFC_NXP_NCI=m
> > > CONFIG_NFC_NXP_NCI_I2C=m
> > > CONFIG_NFC_S3FWRN5=m
> > > CONFIG_NFC_S3FWRN5_I2C=m
> > > CONFIG_NFC_ST95HF=m
> > > # end of Near Field Communication (NFC) devices
> > > 
> > > CONFIG_PSAMPLE=m
> > > CONFIG_NET_IFE=m
> > > CONFIG_LWTUNNEL=y
> > > CONFIG_LWTUNNEL_BPF=y
> > > CONFIG_DST_CACHE=y
> > > CONFIG_GRO_CELLS=y
> > > CONFIG_SOCK_VALIDATE_XMIT=y
> > > CONFIG_NET_SOCK_MSG=y
> > > CONFIG_NET_DEVLINK=y
> > > CONFIG_PAGE_POOL=y
> > > CONFIG_FAILOVER=m
> > > CONFIG_HAVE_EBPF_JIT=y
> > > 
> > > #
> > > # Device Drivers
> > > #
> > > CONFIG_HAVE_EISA=y
> > > CONFIG_EISA=y
> > > CONFIG_EISA_VLB_PRIMING=y
> > > CONFIG_EISA_PCI_EISA=y
> > > CONFIG_EISA_VIRTUAL_ROOT=y
> > > CONFIG_EISA_NAMES=y
> > > CONFIG_HAVE_PCI=y
> > > CONFIG_PCI=y
> > > CONFIG_PCI_DOMAINS=y
> > > CONFIG_PCIEPORTBUS=y
> > > CONFIG_HOTPLUG_PCI_PCIE=y
> > > CONFIG_PCIEAER=y
> > > # CONFIG_PCIEAER_INJECT is not set
> > > # CONFIG_PCIE_ECRC is not set
> > > CONFIG_PCIEASPM=y
> > > CONFIG_PCIEASPM_DEFAULT=y
> > > # CONFIG_PCIEASPM_POWERSAVE is not set
> > > # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> > > # CONFIG_PCIEASPM_PERFORMANCE is not set
> > > CONFIG_PCIE_PME=y
> > > CONFIG_PCIE_DPC=y
> > > CONFIG_PCIE_PTM=y
> > > # CONFIG_PCIE_BW is not set
> > > CONFIG_PCI_MSI=y
> > > CONFIG_PCI_MSI_IRQ_DOMAIN=y
> > > CONFIG_PCI_QUIRKS=y
> > > # CONFIG_PCI_DEBUG is not set
> > > CONFIG_PCI_REALLOC_ENABLE_AUTO=y
> > > CONFIG_PCI_STUB=m
> > > CONFIG_PCI_PF_STUB=m
> > > CONFIG_XEN_PCIDEV_FRONTEND=m
> > > CONFIG_PCI_ATS=y
> > > CONFIG_PCI_LOCKLESS_CONFIG=y
> > > CONFIG_PCI_IOV=y
> > > CONFIG_PCI_PRI=y
> > > CONFIG_PCI_PASID=y
> > > # CONFIG_PCI_P2PDMA is not set
> > > CONFIG_PCI_LABEL=y
> > > CONFIG_PCI_HYPERV=m
> > > CONFIG_HOTPLUG_PCI=y
> > > CONFIG_HOTPLUG_PCI_ACPI=y
> > > CONFIG_HOTPLUG_PCI_ACPI_IBM=m
> > > CONFIG_HOTPLUG_PCI_CPCI=y
> > > CONFIG_HOTPLUG_PCI_CPCI_ZT5550=m
> > > CONFIG_HOTPLUG_PCI_CPCI_GENERIC=m
> > > CONFIG_HOTPLUG_PCI_SHPC=y
> > > 
> > > #
> > > # PCI controller drivers
> > > #
> > > CONFIG_VMD=m
> > > CONFIG_PCI_HYPERV_INTERFACE=m
> > > 
> > > #
> > > # DesignWare PCI Core Support
> > > #
> > > CONFIG_PCIE_DW=y
> > > CONFIG_PCIE_DW_HOST=y
> > > CONFIG_PCIE_DW_EP=y
> > > CONFIG_PCIE_DW_PLAT=y
> > > CONFIG_PCIE_DW_PLAT_HOST=y
> > > CONFIG_PCIE_DW_PLAT_EP=y
> > > CONFIG_PCI_MESON=y
> > > # end of DesignWare PCI Core Support
> > > 
> > > #
> > > # Cadence PCIe controllers support
> > > #
> > > # end of Cadence PCIe controllers support
> > > # end of PCI controller drivers
> > > 
> > > #
> > > # PCI Endpoint
> > > #
> > > CONFIG_PCI_ENDPOINT=y
> > > CONFIG_PCI_ENDPOINT_CONFIGFS=y
> > > # CONFIG_PCI_EPF_TEST is not set
> > > # end of PCI Endpoint
> > > 
> > > #
> > > # PCI switch controller drivers
> > > #
> > > CONFIG_PCI_SW_SWITCHTEC=m
> > > # end of PCI switch controller drivers
> > > 
> > > CONFIG_PCCARD=m
> > > CONFIG_PCMCIA=m
> > > CONFIG_PCMCIA_LOAD_CIS=y
> > > CONFIG_CARDBUS=y
> > > 
> > > #
> > > # PC-card bridges
> > > #
> > > CONFIG_YENTA=m
> > > CONFIG_YENTA_O2=y
> > > CONFIG_YENTA_RICOH=y
> > > CONFIG_YENTA_TI=y
> > > CONFIG_YENTA_ENE_TUNE=y
> > > CONFIG_YENTA_TOSHIBA=y
> > > CONFIG_PD6729=m
> > > CONFIG_I82092=m
> > > CONFIG_PCCARD_NONSTATIC=y
> > > CONFIG_RAPIDIO=y
> > > CONFIG_RAPIDIO_TSI721=m
> > > CONFIG_RAPIDIO_DISC_TIMEOUT=30
> > > # CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
> > > CONFIG_RAPIDIO_DMA_ENGINE=y
> > > # CONFIG_RAPIDIO_DEBUG is not set
> > > CONFIG_RAPIDIO_ENUM_BASIC=m
> > > CONFIG_RAPIDIO_CHMAN=m
> > > CONFIG_RAPIDIO_MPORT_CDEV=m
> > > 
> > > #
> > > # RapidIO Switch drivers
> > > #
> > > CONFIG_RAPIDIO_TSI57X=m
> > > CONFIG_RAPIDIO_CPS_XX=m
> > > CONFIG_RAPIDIO_TSI568=m
> > > CONFIG_RAPIDIO_CPS_GEN2=m
> > > CONFIG_RAPIDIO_RXS_GEN3=m
> > > # end of RapidIO Switch drivers
> > > 
> > > #
> > > # Generic Driver Options
> > > #
> > > CONFIG_UEVENT_HELPER=y
> > > CONFIG_UEVENT_HELPER_PATH=""
> > > CONFIG_DEVTMPFS=y
> > > CONFIG_DEVTMPFS_MOUNT=y
> > > # CONFIG_STANDALONE is not set
> > > CONFIG_PREVENT_FIRMWARE_BUILD=y
> > > 
> > > #
> > > # Firmware loader
> > > #
> > > CONFIG_FW_LOADER=y
> > > CONFIG_FW_LOADER_PAGED_BUF=y
> > > CONFIG_EXTRA_FIRMWARE=""
> > > CONFIG_FW_LOADER_USER_HELPER=y
> > > # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> > > CONFIG_FW_LOADER_COMPRESS=y
> > > CONFIG_FW_CACHE=y
> > > # end of Firmware loader
> > > 
> > > CONFIG_WANT_DEV_COREDUMP=y
> > > CONFIG_ALLOW_DEV_COREDUMP=y
> > > CONFIG_DEV_COREDUMP=y
> > > # CONFIG_DEBUG_DRIVER is not set
> > > # CONFIG_DEBUG_DEVRES is not set
> > > # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> > > CONFIG_HMEM_REPORTING=y
> > > # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> > > CONFIG_SYS_HYPERVISOR=y
> > > CONFIG_GENERIC_CPU_AUTOPROBE=y
> > > CONFIG_GENERIC_CPU_VULNERABILITIES=y
> > > CONFIG_REGMAP=y
> > > CONFIG_REGMAP_I2C=y
> > > CONFIG_REGMAP_SLIMBUS=m
> > > CONFIG_REGMAP_SPI=y
> > > CONFIG_REGMAP_SPMI=m
> > > CONFIG_REGMAP_W1=m
> > > CONFIG_REGMAP_MMIO=y
> > > CONFIG_REGMAP_IRQ=y
> > > CONFIG_REGMAP_SCCB=m
> > > CONFIG_REGMAP_I3C=m
> > > CONFIG_DMA_SHARED_BUFFER=y
> > > # CONFIG_DMA_FENCE_TRACE is not set
> > > # end of Generic Driver Options
> > > 
> > > #
> > > # Bus devices
> > > #
> > > # end of Bus devices
> > > 
> > > CONFIG_CONNECTOR=y
> > > CONFIG_PROC_EVENTS=y
> > > CONFIG_GNSS=m
> > > CONFIG_GNSS_SERIAL=m
> > > CONFIG_GNSS_MTK_SERIAL=m
> > > CONFIG_GNSS_SIRF_SERIAL=m
> > > CONFIG_GNSS_UBX_SERIAL=m
> > > CONFIG_MTD=m
> > > # CONFIG_MTD_TESTS is not set
> > > 
> > > #
> > > # Partition parsers
> > > #
> > > CONFIG_MTD_AR7_PARTS=m
> > > CONFIG_MTD_CMDLINE_PARTS=m
> > > CONFIG_MTD_REDBOOT_PARTS=m
> > > CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
> > > # CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
> > > # CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
> > > # end of Partition parsers
> > > 
> > > #
> > > # User Modules And Translation Layers
> > > #
> > > CONFIG_MTD_BLKDEVS=m
> > > CONFIG_MTD_BLOCK=m
> > > CONFIG_MTD_BLOCK_RO=m
> > > CONFIG_FTL=m
> > > CONFIG_NFTL=m
> > > CONFIG_NFTL_RW=y
> > > CONFIG_INFTL=m
> > > CONFIG_RFD_FTL=m
> > > CONFIG_SSFDC=m
> > > CONFIG_SM_FTL=m
> > > CONFIG_MTD_OOPS=m
> > > CONFIG_MTD_SWAP=m
> > > # CONFIG_MTD_PARTITIONED_MASTER is not set
> > > 
> > > #
> > > # RAM/ROM/Flash chip drivers
> > > #
> > > CONFIG_MTD_CFI=m
> > > CONFIG_MTD_JEDECPROBE=m
> > > CONFIG_MTD_GEN_PROBE=m
> > > # CONFIG_MTD_CFI_ADV_OPTIONS is not set
> > > CONFIG_MTD_MAP_BANK_WIDTH_1=y
> > > CONFIG_MTD_MAP_BANK_WIDTH_2=y
> > > CONFIG_MTD_MAP_BANK_WIDTH_4=y
> > > CONFIG_MTD_CFI_I1=y
> > > CONFIG_MTD_CFI_I2=y
> > > CONFIG_MTD_CFI_INTELEXT=m
> > > CONFIG_MTD_CFI_AMDSTD=m
> > > CONFIG_MTD_CFI_STAA=m
> > > CONFIG_MTD_CFI_UTIL=m
> > > CONFIG_MTD_RAM=m
> > > CONFIG_MTD_ROM=m
> > > CONFIG_MTD_ABSENT=m
> > > # end of RAM/ROM/Flash chip drivers
> > > 
> > > #
> > > # Mapping drivers for chip access
> > > #
> > > CONFIG_MTD_COMPLEX_MAPPINGS=y
> > > CONFIG_MTD_PHYSMAP=m
> > > # CONFIG_MTD_PHYSMAP_COMPAT is not set
> > > CONFIG_MTD_PHYSMAP_GPIO_ADDR=y
> > > CONFIG_MTD_SBC_GXX=m
> > > CONFIG_MTD_AMD76XROM=m
> > > CONFIG_MTD_ICHXROM=m
> > > CONFIG_MTD_ESB2ROM=m
> > > CONFIG_MTD_CK804XROM=m
> > > CONFIG_MTD_SCB2_FLASH=m
> > > CONFIG_MTD_NETtel=m
> > > CONFIG_MTD_L440GX=m
> > > CONFIG_MTD_PCI=m
> > > CONFIG_MTD_PCMCIA=m
> > > # CONFIG_MTD_PCMCIA_ANONYMOUS is not set
> > > CONFIG_MTD_INTEL_VR_NOR=m
> > > CONFIG_MTD_PLATRAM=m
> > > # end of Mapping drivers for chip access
> > > 
> > > #
> > > # Self-contained MTD device drivers
> > > #
> > > CONFIG_MTD_PMC551=m
> > > # CONFIG_MTD_PMC551_BUGFIX is not set
> > > # CONFIG_MTD_PMC551_DEBUG is not set
> > > CONFIG_MTD_DATAFLASH=m
> > > # CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
> > > CONFIG_MTD_DATAFLASH_OTP=y
> > > CONFIG_MTD_MCHP23K256=m
> > > CONFIG_MTD_SST25L=m
> > > CONFIG_MTD_SLRAM=m
> > > CONFIG_MTD_PHRAM=m
> > > CONFIG_MTD_MTDRAM=m
> > > CONFIG_MTDRAM_TOTAL_SIZE=4096
> > > CONFIG_MTDRAM_ERASE_SIZE=128
> > > CONFIG_MTD_BLOCK2MTD=m
> > > 
> > > #
> > > # Disk-On-Chip Device Drivers
> > > #
> > > # CONFIG_MTD_DOCG3 is not set
> > > # end of Self-contained MTD device drivers
> > > 
> > > CONFIG_MTD_NAND_CORE=m
> > > CONFIG_MTD_ONENAND=m
> > > CONFIG_MTD_ONENAND_VERIFY_WRITE=y
> > > CONFIG_MTD_ONENAND_GENERIC=m
> > > # CONFIG_MTD_ONENAND_OTP is not set
> > > CONFIG_MTD_ONENAND_2X_PROGRAM=y
> > > CONFIG_MTD_NAND_ECC_SW_HAMMING=m
> > > # CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
> > > CONFIG_MTD_RAW_NAND=m
> > > CONFIG_MTD_NAND_ECC_SW_BCH=y
> > > 
> > > #
> > > # Raw/parallel NAND flash controllers
> > > #
> > > CONFIG_MTD_NAND_DENALI=m
> > > CONFIG_MTD_NAND_DENALI_PCI=m
> > > CONFIG_MTD_NAND_CAFE=m
> > > # CONFIG_MTD_NAND_MXIC is not set
> > > CONFIG_MTD_NAND_GPIO=m
> > > CONFIG_MTD_NAND_PLATFORM=m
> > > 
> > > #
> > > # Misc
> > > #
> > > CONFIG_MTD_SM_COMMON=m
> > > CONFIG_MTD_NAND_NANDSIM=m
> > > CONFIG_MTD_NAND_RICOH=m
> > > CONFIG_MTD_NAND_DISKONCHIP=m
> > > # CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
> > > CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
> > > # CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
> > > CONFIG_MTD_SPI_NAND=m
> > > 
> > > #
> > > # LPDDR & LPDDR2 PCM memory drivers
> > > #
> > > CONFIG_MTD_LPDDR=m
> > > CONFIG_MTD_QINFO_PROBE=m
> > > # end of LPDDR & LPDDR2 PCM memory drivers
> > > 
> > > CONFIG_MTD_SPI_NOR=m
> > > CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
> > > CONFIG_SPI_MTK_QUADSPI=m
> > > # CONFIG_SPI_INTEL_SPI_PCI is not set
> > > # CONFIG_SPI_INTEL_SPI_PLATFORM is not set
> > > CONFIG_MTD_UBI=m
> > > CONFIG_MTD_UBI_WL_THRESHOLD=4096
> > > CONFIG_MTD_UBI_BEB_LIMIT=20
> > > CONFIG_MTD_UBI_FASTMAP=y
> > > CONFIG_MTD_UBI_GLUEBI=m
> > > CONFIG_MTD_UBI_BLOCK=y
> > > CONFIG_MTD_HYPERBUS=m
> > > # CONFIG_OF is not set
> > > CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> > > CONFIG_PARPORT=m
> > > CONFIG_PARPORT_PC=m
> > > CONFIG_PARPORT_SERIAL=m
> > > CONFIG_PARPORT_PC_FIFO=y
> > > # CONFIG_PARPORT_PC_SUPERIO is not set
> > > CONFIG_PARPORT_PC_PCMCIA=m
> > > CONFIG_PARPORT_AX88796=m
> > > CONFIG_PARPORT_1284=y
> > > CONFIG_PARPORT_NOT_PC=y
> > > CONFIG_PNP=y
> > > # CONFIG_PNP_DEBUG_MESSAGES is not set
> > > 
> > > #
> > > # Protocols
> > > #
> > > CONFIG_PNPACPI=y
> > > CONFIG_BLK_DEV=y
> > > CONFIG_BLK_DEV_NULL_BLK=m
> > > CONFIG_BLK_DEV_FD=m
> > > CONFIG_CDROM=y
> > > CONFIG_PARIDE=m
> > > 
> > > #
> > > # Parallel IDE high-level drivers
> > > #
> > > CONFIG_PARIDE_PD=m
> > > CONFIG_PARIDE_PCD=m
> > > CONFIG_PARIDE_PF=m
> > > CONFIG_PARIDE_PT=m
> > > CONFIG_PARIDE_PG=m
> > > 
> > > #
> > > # Parallel IDE protocol modules
> > > #
> > > CONFIG_PARIDE_ATEN=m
> > > CONFIG_PARIDE_BPCK=m
> > > CONFIG_PARIDE_COMM=m
> > > CONFIG_PARIDE_DSTR=m
> > > CONFIG_PARIDE_FIT2=m
> > > CONFIG_PARIDE_FIT3=m
> > > CONFIG_PARIDE_EPAT=m
> > > CONFIG_PARIDE_EPATC8=y
> > > CONFIG_PARIDE_EPIA=m
> > > CONFIG_PARIDE_FRIQ=m
> > > CONFIG_PARIDE_FRPW=m
> > > CONFIG_PARIDE_KBIC=m
> > > CONFIG_PARIDE_KTTI=m
> > > CONFIG_PARIDE_ON20=m
> > > CONFIG_PARIDE_ON26=m
> > > CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
> > > CONFIG_ZRAM=m
> > > CONFIG_ZRAM_WRITEBACK=y
> > > CONFIG_ZRAM_MEMORY_TRACKING=y
> > > CONFIG_BLK_DEV_UMEM=m
> > > CONFIG_BLK_DEV_LOOP=y
> > > CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
> > > CONFIG_BLK_DEV_CRYPTOLOOP=m
> > > CONFIG_BLK_DEV_DRBD=m
> > > # CONFIG_DRBD_FAULT_INJECTION is not set
> > > CONFIG_BLK_DEV_NBD=m
> > > CONFIG_BLK_DEV_SKD=m
> > > CONFIG_BLK_DEV_SX8=m
> > > CONFIG_BLK_DEV_RAM=m
> > > CONFIG_BLK_DEV_RAM_COUNT=16
> > > CONFIG_BLK_DEV_RAM_SIZE=65536
> > > CONFIG_CDROM_PKTCDVD=m
> > > CONFIG_CDROM_PKTCDVD_BUFFERS=8
> > > # CONFIG_CDROM_PKTCDVD_WCACHE is not set
> > > CONFIG_ATA_OVER_ETH=m
> > > CONFIG_XEN_BLKDEV_FRONTEND=y
> > > CONFIG_XEN_BLKDEV_BACKEND=m
> > > CONFIG_VIRTIO_BLK=m
> > > CONFIG_VIRTIO_BLK_SCSI=y
> > > CONFIG_BLK_DEV_RBD=m
> > > CONFIG_BLK_DEV_RSXX=m
> > > 
> > > #
> > > # NVME Support
> > > #
> > > CONFIG_NVME_CORE=m
> > > CONFIG_BLK_DEV_NVME=m
> > > CONFIG_NVME_MULTIPATH=y
> > > # CONFIG_NVME_HWMON is not set
> > > CONFIG_NVME_FABRICS=m
> > > CONFIG_NVME_RDMA=m
> > > CONFIG_NVME_FC=m
> > > CONFIG_NVME_TCP=m
> > > CONFIG_NVME_TARGET=m
> > > CONFIG_NVME_TARGET_LOOP=m
> > > CONFIG_NVME_TARGET_RDMA=m
> > > CONFIG_NVME_TARGET_FC=m
> > > # CONFIG_NVME_TARGET_FCLOOP is not set
> > > CONFIG_NVME_TARGET_TCP=m
> > > # end of NVME Support
> > > 
> > > #
> > > # Misc devices
> > > #
> > > CONFIG_SENSORS_LIS3LV02D=m
> > > CONFIG_AD525X_DPOT=m
> > > CONFIG_AD525X_DPOT_I2C=m
> > > CONFIG_AD525X_DPOT_SPI=m
> > > CONFIG_DUMMY_IRQ=m
> > > CONFIG_IBM_ASM=m
> > > CONFIG_PHANTOM=m
> > > CONFIG_TIFM_CORE=m
> > > CONFIG_TIFM_7XX1=m
> > > CONFIG_ICS932S401=m
> > > CONFIG_ENCLOSURE_SERVICES=m
> > > CONFIG_HP_ILO=m
> > > CONFIG_APDS9802ALS=m
> > > CONFIG_ISL29003=m
> > > CONFIG_ISL29020=m
> > > CONFIG_SENSORS_TSL2550=m
> > > CONFIG_SENSORS_BH1770=m
> > > CONFIG_SENSORS_APDS990X=m
> > > CONFIG_HMC6352=m
> > > CONFIG_DS1682=m
> > > CONFIG_VMWARE_BALLOON=m
> > > CONFIG_LATTICE_ECP3_CONFIG=m
> > > CONFIG_SRAM=y
> > > # CONFIG_PCI_ENDPOINT_TEST is not set
> > > CONFIG_XILINX_SDFEC=m
> > > CONFIG_MISC_RTSX=m
> > > CONFIG_PVPANIC=m
> > > CONFIG_C2PORT=m
> > > CONFIG_C2PORT_DURAMAR_2150=m
> > > 
> > > #
> > > # EEPROM support
> > > #
> > > CONFIG_EEPROM_AT24=m
> > > CONFIG_EEPROM_AT25=m
> > > CONFIG_EEPROM_LEGACY=m
> > > CONFIG_EEPROM_MAX6875=m
> > > CONFIG_EEPROM_93CX6=m
> > > CONFIG_EEPROM_93XX46=m
> > > CONFIG_EEPROM_IDT_89HPESX=m
> > > CONFIG_EEPROM_EE1004=m
> > > # end of EEPROM support
> > > 
> > > CONFIG_CB710_CORE=m
> > > # CONFIG_CB710_DEBUG is not set
> > > CONFIG_CB710_DEBUG_ASSUMPTIONS=y
> > > 
> > > #
> > > # Texas Instruments shared transport line discipline
> > > #
> > > CONFIG_TI_ST=m
> > > # end of Texas Instruments shared transport line discipline
> > > 
> > > CONFIG_SENSORS_LIS3_I2C=m
> > > CONFIG_ALTERA_STAPL=m
> > > CONFIG_INTEL_MEI=m
> > > CONFIG_INTEL_MEI_ME=m
> > > CONFIG_INTEL_MEI_TXE=m
> > > CONFIG_INTEL_MEI_HDCP=m
> > > CONFIG_VMWARE_VMCI=m
> > > 
> > > #
> > > # Intel MIC & related support
> > > #
> > > CONFIG_INTEL_MIC_BUS=m
> > > CONFIG_SCIF_BUS=m
> > > CONFIG_VOP_BUS=m
> > > CONFIG_INTEL_MIC_HOST=m
> > > CONFIG_INTEL_MIC_CARD=m
> > > CONFIG_SCIF=m
> > > CONFIG_MIC_COSM=m
> > > CONFIG_VOP=m
> > > CONFIG_VHOST_RING=m
> > > # end of Intel MIC & related support
> > > 
> > > CONFIG_GENWQE=m
> > > CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
> > > CONFIG_ECHO=m
> > > CONFIG_MISC_ALCOR_PCI=m
> > > CONFIG_MISC_RTSX_PCI=m
> > > CONFIG_MISC_RTSX_USB=m
> > > CONFIG_HABANA_AI=m
> > > # end of Misc devices
> > > 
> > > CONFIG_HAVE_IDE=y
> > > # CONFIG_IDE is not set
> > > 
> > > #
> > > # SCSI device support
> > > #
> > > CONFIG_SCSI_MOD=y
> > > CONFIG_RAID_ATTRS=m
> > > CONFIG_SCSI=y
> > > CONFIG_SCSI_DMA=y
> > > CONFIG_SCSI_NETLINK=y
> > > CONFIG_SCSI_PROC_FS=y
> > > 
> > > #
> > > # SCSI support type (disk, tape, CD-ROM)
> > > #
> > > CONFIG_BLK_DEV_SD=y
> > > CONFIG_CHR_DEV_ST=m
> > > CONFIG_BLK_DEV_SR=y
> > > # CONFIG_BLK_DEV_SR_VENDOR is not set
> > > CONFIG_CHR_DEV_SG=y
> > > CONFIG_CHR_DEV_SCH=m
> > > CONFIG_SCSI_ENCLOSURE=m
> > > CONFIG_SCSI_CONSTANTS=y
> > > CONFIG_SCSI_LOGGING=y
> > > CONFIG_SCSI_SCAN_ASYNC=y
> > > 
> > > #
> > > # SCSI Transports
> > > #
> > > CONFIG_SCSI_SPI_ATTRS=m
> > > CONFIG_SCSI_FC_ATTRS=m
> > > CONFIG_SCSI_ISCSI_ATTRS=m
> > > CONFIG_SCSI_SAS_ATTRS=m
> > > CONFIG_SCSI_SAS_LIBSAS=m
> > > CONFIG_SCSI_SAS_ATA=y
> > > CONFIG_SCSI_SAS_HOST_SMP=y
> > > CONFIG_SCSI_SRP_ATTRS=m
> > > # end of SCSI Transports
> > > 
> > > CONFIG_SCSI_LOWLEVEL=y
> > > CONFIG_ISCSI_TCP=m
> > > CONFIG_ISCSI_BOOT_SYSFS=m
> > > CONFIG_SCSI_CXGB3_ISCSI=m
> > > CONFIG_SCSI_CXGB4_ISCSI=m
> > > CONFIG_SCSI_BNX2_ISCSI=m
> > > CONFIG_SCSI_BNX2X_FCOE=m
> > > CONFIG_BE2ISCSI=m
> > > CONFIG_BLK_DEV_3W_XXXX_RAID=m
> > > CONFIG_SCSI_HPSA=m
> > > CONFIG_SCSI_3W_9XXX=m
> > > CONFIG_SCSI_3W_SAS=m
> > > CONFIG_SCSI_ACARD=m
> > > CONFIG_SCSI_AHA1740=m
> > > CONFIG_SCSI_AACRAID=m
> > > CONFIG_SCSI_AIC7XXX=m
> > > CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
> > > CONFIG_AIC7XXX_RESET_DELAY_MS=5000
> > > # CONFIG_AIC7XXX_DEBUG_ENABLE is not set
> > > CONFIG_AIC7XXX_DEBUG_MASK=0
> > > CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
> > > CONFIG_SCSI_AIC79XX=m
> > > CONFIG_AIC79XX_CMDS_PER_DEVICE=32
> > > CONFIG_AIC79XX_RESET_DELAY_MS=5000
> > > # CONFIG_AIC79XX_DEBUG_ENABLE is not set
> > > CONFIG_AIC79XX_DEBUG_MASK=0
> > > CONFIG_AIC79XX_REG_PRETTY_PRINT=y
> > > CONFIG_SCSI_AIC94XX=m
> > > # CONFIG_AIC94XX_DEBUG is not set
> > > CONFIG_SCSI_MVSAS=m
> > > # CONFIG_SCSI_MVSAS_DEBUG is not set
> > > # CONFIG_SCSI_MVSAS_TASKLET is not set
> > > CONFIG_SCSI_MVUMI=m
> > > CONFIG_SCSI_DPT_I2O=m
> > > CONFIG_SCSI_ADVANSYS=m
> > > CONFIG_SCSI_ARCMSR=m
> > > CONFIG_SCSI_ESAS2R=m
> > > CONFIG_MEGARAID_NEWGEN=y
> > > CONFIG_MEGARAID_MM=m
> > > CONFIG_MEGARAID_MAILBOX=m
> > > CONFIG_MEGARAID_LEGACY=m
> > > CONFIG_MEGARAID_SAS=m
> > > CONFIG_SCSI_MPT3SAS=m
> > > CONFIG_SCSI_MPT2SAS_MAX_SGE=128
> > > CONFIG_SCSI_MPT3SAS_MAX_SGE=128
> > > CONFIG_SCSI_MPT2SAS=m
> > > CONFIG_SCSI_SMARTPQI=m
> > > CONFIG_SCSI_UFSHCD=m
> > > CONFIG_SCSI_UFSHCD_PCI=m
> > > CONFIG_SCSI_UFS_DWC_TC_PCI=m
> > > CONFIG_SCSI_UFSHCD_PLATFORM=m
> > > CONFIG_SCSI_UFS_CDNS_PLATFORM=m
> > > CONFIG_SCSI_UFS_DWC_TC_PLATFORM=m
> > > CONFIG_SCSI_UFS_BSG=y
> > > CONFIG_SCSI_HPTIOP=m
> > > CONFIG_SCSI_BUSLOGIC=m
> > > CONFIG_SCSI_FLASHPOINT=y
> > > CONFIG_SCSI_MYRB=m
> > > CONFIG_SCSI_MYRS=m
> > > CONFIG_VMWARE_PVSCSI=m
> > > CONFIG_XEN_SCSI_FRONTEND=m
> > > CONFIG_HYPERV_STORAGE=m
> > > CONFIG_LIBFC=m
> > > CONFIG_LIBFCOE=m
> > > CONFIG_FCOE=m
> > > CONFIG_FCOE_FNIC=m
> > > CONFIG_SCSI_SNIC=m
> > > # CONFIG_SCSI_SNIC_DEBUG_FS is not set
> > > CONFIG_SCSI_DMX3191D=m
> > > CONFIG_SCSI_FDOMAIN=m
> > > CONFIG_SCSI_FDOMAIN_PCI=m
> > > CONFIG_SCSI_GDTH=m
> > > CONFIG_SCSI_ISCI=m
> > > CONFIG_SCSI_IPS=m
> > > CONFIG_SCSI_INITIO=m
> > > CONFIG_SCSI_INIA100=m
> > > CONFIG_SCSI_PPA=m
> > > CONFIG_SCSI_IMM=m
> > > # CONFIG_SCSI_IZIP_EPP16 is not set
> > > # CONFIG_SCSI_IZIP_SLOW_CTR is not set
> > > CONFIG_SCSI_STEX=m
> > > CONFIG_SCSI_SYM53C8XX_2=m
> > > CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
> > > CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
> > > CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
> > > CONFIG_SCSI_SYM53C8XX_MMIO=y
> > > CONFIG_SCSI_IPR=m
> > > CONFIG_SCSI_IPR_TRACE=y
> > > CONFIG_SCSI_IPR_DUMP=y
> > > CONFIG_SCSI_QLOGIC_1280=m
> > > CONFIG_SCSI_QLA_FC=m
> > > CONFIG_TCM_QLA2XXX=m
> > > # CONFIG_TCM_QLA2XXX_DEBUG is not set
> > > CONFIG_SCSI_QLA_ISCSI=m
> > > CONFIG_QEDI=m
> > > CONFIG_QEDF=m
> > > CONFIG_SCSI_LPFC=m
> > > # CONFIG_SCSI_LPFC_DEBUG_FS is not set
> > > CONFIG_SCSI_SIM710=m
> > > CONFIG_SCSI_DC395x=m
> > > CONFIG_SCSI_AM53C974=m
> > > CONFIG_SCSI_WD719X=m
> > > CONFIG_SCSI_DEBUG=m
> > > CONFIG_SCSI_PMCRAID=m
> > > CONFIG_SCSI_PM8001=m
> > > CONFIG_SCSI_BFA_FC=m
> > > CONFIG_SCSI_VIRTIO=m
> > > CONFIG_SCSI_CHELSIO_FCOE=m
> > > CONFIG_SCSI_LOWLEVEL_PCMCIA=y
> > > CONFIG_PCMCIA_AHA152X=m
> > > CONFIG_PCMCIA_FDOMAIN=m
> > > CONFIG_PCMCIA_QLOGIC=m
> > > CONFIG_PCMCIA_SYM53C500=m
> > > CONFIG_SCSI_DH=y
> > > CONFIG_SCSI_DH_RDAC=m
> > > CONFIG_SCSI_DH_HP_SW=m
> > > CONFIG_SCSI_DH_EMC=m
> > > CONFIG_SCSI_DH_ALUA=m
> > > # end of SCSI device support
> > > 
> > > CONFIG_ATA=y
> > > CONFIG_ATA_VERBOSE_ERROR=y
> > > CONFIG_ATA_ACPI=y
> > > CONFIG_SATA_ZPODD=y
> > > CONFIG_SATA_PMP=y
> > > 
> > > #
> > > # Controllers with non-SFF native interface
> > > #
> > > CONFIG_SATA_AHCI=m
> > > CONFIG_SATA_MOBILE_LPM_POLICY=3
> > > CONFIG_SATA_AHCI_PLATFORM=m
> > > CONFIG_SATA_INIC162X=m
> > > CONFIG_SATA_ACARD_AHCI=m
> > > CONFIG_SATA_SIL24=m
> > > CONFIG_ATA_SFF=y
> > > 
> > > #
> > > # SFF controllers with custom DMA interface
> > > #
> > > CONFIG_PDC_ADMA=m
> > > CONFIG_SATA_QSTOR=m
> > > CONFIG_SATA_SX4=m
> > > CONFIG_ATA_BMDMA=y
> > > 
> > > #
> > > # SATA SFF controllers with BMDMA
> > > #
> > > CONFIG_ATA_PIIX=y
> > > CONFIG_SATA_DWC=m
> > > CONFIG_SATA_DWC_OLD_DMA=y
> > > # CONFIG_SATA_DWC_DEBUG is not set
> > > CONFIG_SATA_MV=m
> > > CONFIG_SATA_NV=m
> > > CONFIG_SATA_PROMISE=m
> > > CONFIG_SATA_SIL=m
> > > CONFIG_SATA_SIS=m
> > > CONFIG_SATA_SVW=m
> > > CONFIG_SATA_ULI=m
> > > CONFIG_SATA_VIA=m
> > > CONFIG_SATA_VITESSE=m
> > > 
> > > #
> > > # PATA SFF controllers with BMDMA
> > > #
> > > CONFIG_PATA_ALI=m
> > > CONFIG_PATA_AMD=m
> > > CONFIG_PATA_ARTOP=m
> > > CONFIG_PATA_ATIIXP=m
> > > CONFIG_PATA_ATP867X=m
> > > CONFIG_PATA_CMD64X=m
> > > CONFIG_PATA_CYPRESS=m
> > > CONFIG_PATA_EFAR=m
> > > CONFIG_PATA_HPT366=m
> > > CONFIG_PATA_HPT37X=m
> > > CONFIG_PATA_HPT3X2N=m
> > > CONFIG_PATA_HPT3X3=m
> > > # CONFIG_PATA_HPT3X3_DMA is not set
> > > CONFIG_PATA_IT8213=m
> > > CONFIG_PATA_IT821X=m
> > > CONFIG_PATA_JMICRON=m
> > > CONFIG_PATA_MARVELL=m
> > > CONFIG_PATA_NETCELL=m
> > > CONFIG_PATA_NINJA32=m
> > > CONFIG_PATA_NS87415=m
> > > CONFIG_PATA_OLDPIIX=m
> > > CONFIG_PATA_OPTIDMA=m
> > > CONFIG_PATA_PDC2027X=m
> > > CONFIG_PATA_PDC_OLD=m
> > > CONFIG_PATA_RADISYS=m
> > > CONFIG_PATA_RDC=m
> > > CONFIG_PATA_SCH=m
> > > CONFIG_PATA_SERVERWORKS=m
> > > CONFIG_PATA_SIL680=m
> > > CONFIG_PATA_SIS=y
> > > CONFIG_PATA_TOSHIBA=m
> > > CONFIG_PATA_TRIFLEX=m
> > > CONFIG_PATA_VIA=m
> > > CONFIG_PATA_WINBOND=m
> > > 
> > > #
> > > # PIO-only SFF controllers
> > > #
> > > CONFIG_PATA_CMD640_PCI=m
> > > CONFIG_PATA_MPIIX=m
> > > CONFIG_PATA_NS87410=m
> > > CONFIG_PATA_OPTI=m
> > > CONFIG_PATA_PCMCIA=m
> > > CONFIG_PATA_PLATFORM=m
> > > CONFIG_PATA_RZ1000=m
> > > 
> > > #
> > > # Generic fallback / legacy drivers
> > > #
> > > CONFIG_PATA_ACPI=m
> > > CONFIG_ATA_GENERIC=y
> > > CONFIG_PATA_LEGACY=m
> > > CONFIG_MD=y
> > > CONFIG_BLK_DEV_MD=y
> > > CONFIG_MD_AUTODETECT=y
> > > CONFIG_MD_LINEAR=m
> > > CONFIG_MD_RAID0=m
> > > CONFIG_MD_RAID1=m
> > > CONFIG_MD_RAID10=m
> > > CONFIG_MD_RAID456=m
> > > CONFIG_MD_MULTIPATH=m
> > > CONFIG_MD_FAULTY=m
> > > CONFIG_MD_CLUSTER=m
> > > CONFIG_BCACHE=m
> > > # CONFIG_BCACHE_DEBUG is not set
> > > # CONFIG_BCACHE_CLOSURES_DEBUG is not set
> > > CONFIG_BLK_DEV_DM_BUILTIN=y
> > > CONFIG_BLK_DEV_DM=y
> > > # CONFIG_DM_DEBUG is not set
> > > CONFIG_DM_BUFIO=m
> > > # CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
> > > CONFIG_DM_BIO_PRISON=m
> > > CONFIG_DM_PERSISTENT_DATA=m
> > > CONFIG_DM_UNSTRIPED=m
> > > CONFIG_DM_CRYPT=m
> > > CONFIG_DM_SNAPSHOT=m
> > > CONFIG_DM_THIN_PROVISIONING=m
> > > CONFIG_DM_CACHE=m
> > > CONFIG_DM_CACHE_SMQ=m
> > > CONFIG_DM_WRITECACHE=m
> > > CONFIG_DM_ERA=m
> > > # CONFIG_DM_CLONE is not set
> > > CONFIG_DM_MIRROR=m
> > > CONFIG_DM_LOG_USERSPACE=m
> > > CONFIG_DM_RAID=m
> > > CONFIG_DM_ZERO=m
> > > CONFIG_DM_MULTIPATH=m
> > > CONFIG_DM_MULTIPATH_QL=m
> > > CONFIG_DM_MULTIPATH_ST=m
> > > CONFIG_DM_DELAY=m
> > > # CONFIG_DM_DUST is not set
> > > CONFIG_DM_INIT=y
> > > CONFIG_DM_UEVENT=y
> > > CONFIG_DM_FLAKEY=m
> > > CONFIG_DM_VERITY=m
> > > # CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
> > > # CONFIG_DM_VERITY_FEC is not set
> > > CONFIG_DM_SWITCH=m
> > > CONFIG_DM_LOG_WRITES=m
> > > CONFIG_DM_INTEGRITY=m
> > > CONFIG_DM_ZONED=m
> > > CONFIG_TARGET_CORE=m
> > > CONFIG_TCM_IBLOCK=m
> > > CONFIG_TCM_FILEIO=m
> > > CONFIG_TCM_PSCSI=m
> > > CONFIG_TCM_USER2=m
> > > CONFIG_LOOPBACK_TARGET=m
> > > CONFIG_TCM_FC=m
> > > CONFIG_ISCSI_TARGET=m
> > > CONFIG_ISCSI_TARGET_CXGB4=m
> > > CONFIG_SBP_TARGET=m
> > > CONFIG_FUSION=y
> > > CONFIG_FUSION_SPI=m
> > > CONFIG_FUSION_FC=m
> > > CONFIG_FUSION_SAS=m
> > > CONFIG_FUSION_MAX_SGE=128
> > > CONFIG_FUSION_CTL=m
> > > CONFIG_FUSION_LAN=m
> > > CONFIG_FUSION_LOGGING=y
> > > 
> > > #
> > > # IEEE 1394 (FireWire) support
> > > #
> > > CONFIG_FIREWIRE=m
> > > CONFIG_FIREWIRE_OHCI=m
> > > CONFIG_FIREWIRE_SBP2=m
> > > CONFIG_FIREWIRE_NET=m
> > > CONFIG_FIREWIRE_NOSY=m
> > > # end of IEEE 1394 (FireWire) support
> > > 
> > > CONFIG_MACINTOSH_DRIVERS=y
> > > CONFIG_MAC_EMUMOUSEBTN=m
> > > CONFIG_NETDEVICES=y
> > > CONFIG_MII=m
> > > CONFIG_NET_CORE=y
> > > CONFIG_BONDING=m
> > > CONFIG_DUMMY=m
> > > CONFIG_EQUALIZER=m
> > > CONFIG_NET_FC=y
> > > CONFIG_IFB=m
> > > CONFIG_NET_TEAM=m
> > > CONFIG_NET_TEAM_MODE_BROADCAST=m
> > > CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
> > > CONFIG_NET_TEAM_MODE_RANDOM=m
> > > CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
> > > CONFIG_NET_TEAM_MODE_LOADBALANCE=m
> > > CONFIG_MACVLAN=m
> > > CONFIG_MACVTAP=m
> > > CONFIG_IPVLAN_L3S=y
> > > CONFIG_IPVLAN=m
> > > CONFIG_IPVTAP=m
> > > CONFIG_VXLAN=m
> > > CONFIG_GENEVE=m
> > > CONFIG_GTP=m
> > > CONFIG_MACSEC=m
> > > CONFIG_NETCONSOLE=m
> > > CONFIG_NETCONSOLE_DYNAMIC=y
> > > CONFIG_NETPOLL=y
> > > CONFIG_NET_POLL_CONTROLLER=y
> > > CONFIG_NTB_NETDEV=m
> > > CONFIG_RIONET=m
> > > CONFIG_RIONET_TX_SIZE=128
> > > CONFIG_RIONET_RX_SIZE=128
> > > CONFIG_TUN=y
> > > CONFIG_TAP=m
> > > # CONFIG_TUN_VNET_CROSS_LE is not set
> > > CONFIG_VETH=m
> > > CONFIG_VIRTIO_NET=m
> > > CONFIG_NLMON=m
> > > CONFIG_NET_VRF=m
> > > CONFIG_VSOCKMON=m
> > > CONFIG_SUNGEM_PHY=m
> > > CONFIG_ARCNET=m
> > > CONFIG_ARCNET_1201=m
> > > CONFIG_ARCNET_1051=m
> > > CONFIG_ARCNET_RAW=m
> > > CONFIG_ARCNET_CAP=m
> > > CONFIG_ARCNET_COM90xx=m
> > > CONFIG_ARCNET_COM90xxIO=m
> > > CONFIG_ARCNET_RIM_I=m
> > > CONFIG_ARCNET_COM20020=m
> > > CONFIG_ARCNET_COM20020_PCI=m
> > > CONFIG_ARCNET_COM20020_CS=m
> > > CONFIG_ATM_DRIVERS=y
> > > CONFIG_ATM_DUMMY=m
> > > CONFIG_ATM_TCP=m
> > > CONFIG_ATM_LANAI=m
> > > CONFIG_ATM_ENI=m
> > > # CONFIG_ATM_ENI_DEBUG is not set
> > > # CONFIG_ATM_ENI_TUNE_BURST is not set
> > > CONFIG_ATM_FIRESTREAM=m
> > > CONFIG_ATM_ZATM=m
> > > # CONFIG_ATM_ZATM_DEBUG is not set
> > > CONFIG_ATM_NICSTAR=m
> > > # CONFIG_ATM_NICSTAR_USE_SUNI is not set
> > > # CONFIG_ATM_NICSTAR_USE_IDT77105 is not set
> > > CONFIG_ATM_IDT77252=m
> > > # CONFIG_ATM_IDT77252_DEBUG is not set
> > > # CONFIG_ATM_IDT77252_RCV_ALL is not set
> > > CONFIG_ATM_IDT77252_USE_SUNI=y
> > > CONFIG_ATM_AMBASSADOR=m
> > > # CONFIG_ATM_AMBASSADOR_DEBUG is not set
> > > CONFIG_ATM_HORIZON=m
> > > # CONFIG_ATM_HORIZON_DEBUG is not set
> > > CONFIG_ATM_IA=m
> > > # CONFIG_ATM_IA_DEBUG is not set
> > > CONFIG_ATM_FORE200E=m
> > > # CONFIG_ATM_FORE200E_USE_TASKLET is not set
> > > CONFIG_ATM_FORE200E_TX_RETRY=16
> > > CONFIG_ATM_FORE200E_DEBUG=0
> > > CONFIG_ATM_HE=m
> > > CONFIG_ATM_HE_USE_SUNI=y
> > > CONFIG_ATM_SOLOS=m
> > > # CONFIG_CAIF_DRIVERS is not set
> > > 
> > > #
> > > # Distributed Switch Architecture drivers
> > > #
> > > CONFIG_B53=m
> > > CONFIG_B53_SPI_DRIVER=m
> > > CONFIG_B53_MDIO_DRIVER=m
> > > CONFIG_B53_MMAP_DRIVER=m
> > > CONFIG_B53_SRAB_DRIVER=m
> > > CONFIG_B53_SERDES=m
> > > CONFIG_NET_DSA_BCM_SF2=m
> > > # CONFIG_NET_DSA_LOOP is not set
> > > CONFIG_NET_DSA_LANTIQ_GSWIP=m
> > > CONFIG_NET_DSA_MT7530=m
> > > CONFIG_NET_DSA_MV88E6060=m
> > > CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON=m
> > > CONFIG_NET_DSA_MICROCHIP_KSZ9477=m
> > > # CONFIG_NET_DSA_MICROCHIP_KSZ9477_I2C is not set
> > > CONFIG_NET_DSA_MICROCHIP_KSZ9477_SPI=m
> > > # CONFIG_NET_DSA_MICROCHIP_KSZ8795 is not set
> > > CONFIG_NET_DSA_MV88E6XXX=m
> > > CONFIG_NET_DSA_MV88E6XXX_GLOBAL2=y
> > > CONFIG_NET_DSA_MV88E6XXX_PTP=y
> > > # CONFIG_NET_DSA_MSCC_FELIX is not set
> > > CONFIG_NET_DSA_SJA1105=m
> > > CONFIG_NET_DSA_SJA1105_PTP=y
> > > # CONFIG_NET_DSA_SJA1105_TAS is not set
> > > CONFIG_NET_DSA_QCA8K=m
> > > CONFIG_NET_DSA_REALTEK_SMI=m
> > > CONFIG_NET_DSA_SMSC_LAN9303=m
> > > CONFIG_NET_DSA_SMSC_LAN9303_I2C=m
> > > CONFIG_NET_DSA_SMSC_LAN9303_MDIO=m
> > > # end of Distributed Switch Architecture drivers
> > > 
> > > CONFIG_ETHERNET=y
> > > CONFIG_MDIO=m
> > > CONFIG_NET_VENDOR_3COM=y
> > > CONFIG_EL3=m
> > > CONFIG_PCMCIA_3C574=m
> > > CONFIG_PCMCIA_3C589=m
> > > CONFIG_VORTEX=m
> > > CONFIG_TYPHOON=m
> > > CONFIG_NET_VENDOR_ADAPTEC=y
> > > CONFIG_ADAPTEC_STARFIRE=m
> > > CONFIG_NET_VENDOR_AGERE=y
> > > CONFIG_ET131X=m
> > > CONFIG_NET_VENDOR_ALACRITECH=y
> > > CONFIG_SLICOSS=m
> > > CONFIG_NET_VENDOR_ALTEON=y
> > > CONFIG_ACENIC=m
> > > # CONFIG_ACENIC_OMIT_TIGON_I is not set
> > > CONFIG_ALTERA_TSE=m
> > > CONFIG_NET_VENDOR_AMAZON=y
> > > CONFIG_ENA_ETHERNET=m
> > > CONFIG_NET_VENDOR_AMD=y
> > > CONFIG_AMD8111_ETH=m
> > > CONFIG_PCNET32=m
> > > CONFIG_PCMCIA_NMCLAN=m
> > > CONFIG_AMD_XGBE=m
> > > CONFIG_AMD_XGBE_DCB=y
> > > CONFIG_AMD_XGBE_HAVE_ECC=y
> > > CONFIG_NET_VENDOR_AQUANTIA=y
> > > CONFIG_AQTION=m
> > > CONFIG_NET_VENDOR_ARC=y
> > > CONFIG_NET_VENDOR_ATHEROS=y
> > > CONFIG_ATL2=m
> > > CONFIG_ATL1=m
> > > CONFIG_ATL1E=m
> > > CONFIG_ATL1C=m
> > > CONFIG_ALX=m
> > > CONFIG_NET_VENDOR_AURORA=y
> > > CONFIG_AURORA_NB8800=m
> > > CONFIG_NET_VENDOR_BROADCOM=y
> > > CONFIG_B44=m
> > > CONFIG_B44_PCI_AUTOSELECT=y
> > > CONFIG_B44_PCICORE_AUTOSELECT=y
> > > CONFIG_B44_PCI=y
> > > CONFIG_BCMGENET=m
> > > CONFIG_BNX2=m
> > > CONFIG_CNIC=m
> > > CONFIG_TIGON3=m
> > > CONFIG_TIGON3_HWMON=y
> > > CONFIG_BNX2X=m
> > > CONFIG_BNX2X_SRIOV=y
> > > CONFIG_SYSTEMPORT=m
> > > CONFIG_BNXT=m
> > > CONFIG_BNXT_SRIOV=y
> > > CONFIG_BNXT_FLOWER_OFFLOAD=y
> > > CONFIG_BNXT_DCB=y
> > > CONFIG_BNXT_HWMON=y
> > > CONFIG_NET_VENDOR_BROCADE=y
> > > CONFIG_BNA=m
> > > CONFIG_NET_VENDOR_CADENCE=y
> > > CONFIG_MACB=m
> > > CONFIG_MACB_USE_HWSTAMP=y
> > > CONFIG_MACB_PCI=m
> > > CONFIG_NET_VENDOR_CAVIUM=y
> > > CONFIG_THUNDER_NIC_PF=m
> > > CONFIG_THUNDER_NIC_VF=m
> > > CONFIG_THUNDER_NIC_BGX=m
> > > CONFIG_THUNDER_NIC_RGX=m
> > > CONFIG_CAVIUM_PTP=m
> > > CONFIG_LIQUIDIO=m
> > > CONFIG_LIQUIDIO_VF=m
> > > CONFIG_NET_VENDOR_CHELSIO=y
> > > CONFIG_CHELSIO_T1=m
> > > CONFIG_CHELSIO_T1_1G=y
> > > CONFIG_CHELSIO_T3=m
> > > CONFIG_CHELSIO_T4=m
> > > CONFIG_CHELSIO_T4_DCB=y
> > > CONFIG_CHELSIO_T4_FCOE=y
> > > CONFIG_CHELSIO_T4VF=m
> > > CONFIG_CHELSIO_LIB=m
> > > CONFIG_NET_VENDOR_CIRRUS=y
> > > CONFIG_CS89x0=m
> > > CONFIG_CS89x0_PLATFORM=y
> > > CONFIG_NET_VENDOR_CISCO=y
> > > CONFIG_ENIC=m
> > > CONFIG_NET_VENDOR_CORTINA=y
> > > CONFIG_CX_ECAT=m
> > > CONFIG_DNET=m
> > > CONFIG_NET_VENDOR_DEC=y
> > > CONFIG_NET_TULIP=y
> > > CONFIG_DE2104X=m
> > > CONFIG_DE2104X_DSL=0
> > > CONFIG_TULIP=m
> > > # CONFIG_TULIP_MWI is not set
> > > # CONFIG_TULIP_MMIO is not set
> > > # CONFIG_TULIP_NAPI is not set
> > > CONFIG_DE4X5=m
> > > CONFIG_WINBOND_840=m
> > > CONFIG_DM9102=m
> > > CONFIG_ULI526X=m
> > > CONFIG_PCMCIA_XIRCOM=m
> > > CONFIG_NET_VENDOR_DLINK=y
> > > CONFIG_DL2K=m
> > > CONFIG_SUNDANCE=m
> > > # CONFIG_SUNDANCE_MMIO is not set
> > > CONFIG_NET_VENDOR_EMULEX=y
> > > CONFIG_BE2NET=m
> > > CONFIG_BE2NET_HWMON=y
> > > CONFIG_BE2NET_BE2=y
> > > CONFIG_BE2NET_BE3=y
> > > CONFIG_BE2NET_LANCER=y
> > > CONFIG_BE2NET_SKYHAWK=y
> > > CONFIG_NET_VENDOR_EZCHIP=y
> > > CONFIG_NET_VENDOR_FUJITSU=y
> > > CONFIG_PCMCIA_FMVJ18X=m
> > > CONFIG_NET_VENDOR_GOOGLE=y
> > > CONFIG_GVE=m
> > > CONFIG_NET_VENDOR_HUAWEI=y
> > > CONFIG_HINIC=m
> > > CONFIG_NET_VENDOR_I825XX=y
> > > CONFIG_NET_VENDOR_INTEL=y
> > > CONFIG_E100=m
> > > CONFIG_E1000=m
> > > CONFIG_E1000E=m
> > > CONFIG_E1000E_HWTS=y
> > > CONFIG_IGB=m
> > > CONFIG_IGB_HWMON=y
> > > CONFIG_IGB_DCA=y
> > > CONFIG_IGBVF=m
> > > CONFIG_IXGB=m
> > > CONFIG_IXGBE=m
> > > CONFIG_IXGBE_HWMON=y
> > > CONFIG_IXGBE_DCA=y
> > > CONFIG_IXGBE_DCB=y
> > > CONFIG_IXGBE_IPSEC=y
> > > CONFIG_IXGBEVF=m
> > > CONFIG_IXGBEVF_IPSEC=y
> > > CONFIG_I40E=m
> > > CONFIG_I40E_DCB=y
> > > CONFIG_IAVF=m
> > > CONFIG_I40EVF=m
> > > CONFIG_ICE=m
> > > CONFIG_FM10K=m
> > > CONFIG_IGC=m
> > > CONFIG_JME=m
> > > CONFIG_NET_VENDOR_MARVELL=y
> > > CONFIG_MVMDIO=m
> > > CONFIG_SKGE=m
> > > # CONFIG_SKGE_DEBUG is not set
> > > CONFIG_SKGE_GENESIS=y
> > > CONFIG_SKY2=m
> > > # CONFIG_SKY2_DEBUG is not set
> > > CONFIG_NET_VENDOR_MELLANOX=y
> > > CONFIG_MLX4_EN=m
> > > CONFIG_MLX4_EN_DCB=y
> > > CONFIG_MLX4_CORE=m
> > > CONFIG_MLX4_DEBUG=y
> > > CONFIG_MLX4_CORE_GEN2=y
> > > CONFIG_MLX5_CORE=m
> > > CONFIG_MLX5_ACCEL=y
> > > CONFIG_MLX5_FPGA=y
> > > CONFIG_MLX5_CORE_EN=y
> > > CONFIG_MLX5_EN_ARFS=y
> > > CONFIG_MLX5_EN_RXNFC=y
> > > CONFIG_MLX5_MPFS=y
> > > CONFIG_MLX5_ESWITCH=y
> > > CONFIG_MLX5_CORE_EN_DCB=y
> > > CONFIG_MLX5_CORE_IPOIB=y
> > > CONFIG_MLX5_FPGA_IPSEC=y
> > > CONFIG_MLX5_EN_IPSEC=y
> > > CONFIG_MLX5_FPGA_TLS=y
> > > CONFIG_MLX5_TLS=y
> > > CONFIG_MLX5_EN_TLS=y
> > > CONFIG_MLX5_SW_STEERING=y
> > > CONFIG_MLXSW_CORE=m
> > > CONFIG_MLXSW_CORE_HWMON=y
> > > CONFIG_MLXSW_CORE_THERMAL=y
> > > CONFIG_MLXSW_PCI=m
> > > CONFIG_MLXSW_I2C=m
> > > CONFIG_MLXSW_SWITCHIB=m
> > > CONFIG_MLXSW_SWITCHX2=m
> > > CONFIG_MLXSW_SPECTRUM=m
> > > CONFIG_MLXSW_SPECTRUM_DCB=y
> > > CONFIG_MLXSW_MINIMAL=m
> > > CONFIG_MLXFW=m
> > > CONFIG_NET_VENDOR_MICREL=y
> > > CONFIG_KS8842=m
> > > CONFIG_KS8851=m
> > > CONFIG_KS8851_MLL=m
> > > CONFIG_KSZ884X_PCI=m
> > > CONFIG_NET_VENDOR_MICROCHIP=y
> > > CONFIG_ENC28J60=m
> > > # CONFIG_ENC28J60_WRITEVERIFY is not set
> > > CONFIG_ENCX24J600=m
> > > CONFIG_LAN743X=m
> > > CONFIG_NET_VENDOR_MICROSEMI=y
> > > CONFIG_MSCC_OCELOT_SWITCH=m
> > > CONFIG_NET_VENDOR_MYRI=y
> > > CONFIG_MYRI10GE=m
> > > CONFIG_MYRI10GE_DCA=y
> > > CONFIG_FEALNX=m
> > > CONFIG_NET_VENDOR_NATSEMI=y
> > > CONFIG_NATSEMI=m
> > > CONFIG_NS83820=m
> > > CONFIG_NET_VENDOR_NETERION=y
> > > CONFIG_S2IO=m
> > > CONFIG_VXGE=m
> > > # CONFIG_VXGE_DEBUG_TRACE_ALL is not set
> > > CONFIG_NET_VENDOR_NETRONOME=y
> > > CONFIG_NFP=m
> > > CONFIG_NFP_APP_FLOWER=y
> > > CONFIG_NFP_APP_ABM_NIC=y
> > > # CONFIG_NFP_DEBUG is not set
> > > CONFIG_NET_VENDOR_NI=y
> > > CONFIG_NI_XGE_MANAGEMENT_ENET=m
> > > CONFIG_NET_VENDOR_8390=y
> > > CONFIG_PCMCIA_AXNET=m
> > > CONFIG_NE2K_PCI=m
> > > CONFIG_PCMCIA_PCNET=m
> > > CONFIG_NET_VENDOR_NVIDIA=y
> > > CONFIG_FORCEDETH=m
> > > CONFIG_NET_VENDOR_OKI=y
> > > CONFIG_ETHOC=m
> > > CONFIG_NET_VENDOR_PACKET_ENGINES=y
> > > CONFIG_HAMACHI=m
> > > CONFIG_YELLOWFIN=m
> > > CONFIG_NET_VENDOR_PENSANDO=y
> > > # CONFIG_IONIC is not set
> > > CONFIG_NET_VENDOR_QLOGIC=y
> > > CONFIG_QLA3XXX=m
> > > CONFIG_QLCNIC=m
> > > CONFIG_QLCNIC_SRIOV=y
> > > CONFIG_QLCNIC_DCB=y
> > > CONFIG_QLCNIC_HWMON=y
> > > CONFIG_NETXEN_NIC=m
> > > CONFIG_QED=m
> > > CONFIG_QED_LL2=y
> > > CONFIG_QED_SRIOV=y
> > > CONFIG_QEDE=m
> > > CONFIG_QED_RDMA=y
> > > CONFIG_QED_ISCSI=y
> > > CONFIG_QED_FCOE=y
> > > CONFIG_QED_OOO=y
> > > CONFIG_NET_VENDOR_QUALCOMM=y
> > > CONFIG_QCOM_EMAC=m
> > > CONFIG_RMNET=m
> > > CONFIG_NET_VENDOR_RDC=y
> > > CONFIG_R6040=m
> > > CONFIG_NET_VENDOR_REALTEK=y
> > > CONFIG_ATP=m
> > > CONFIG_8139CP=m
> > > CONFIG_8139TOO=m
> > > CONFIG_8139TOO_PIO=y
> > > # CONFIG_8139TOO_TUNE_TWISTER is not set
> > > CONFIG_8139TOO_8129=y
> > > # CONFIG_8139_OLD_RX_RESET is not set
> > > CONFIG_R8169=m
> > > CONFIG_NET_VENDOR_RENESAS=y
> > > CONFIG_NET_VENDOR_ROCKER=y
> > > CONFIG_ROCKER=m
> > > CONFIG_NET_VENDOR_SAMSUNG=y
> > > CONFIG_SXGBE_ETH=m
> > > CONFIG_NET_VENDOR_SEEQ=y
> > > CONFIG_NET_VENDOR_SOLARFLARE=y
> > > CONFIG_SFC=m
> > > CONFIG_SFC_MTD=y
> > > CONFIG_SFC_MCDI_MON=y
> > > CONFIG_SFC_SRIOV=y
> > > CONFIG_SFC_MCDI_LOGGING=y
> > > CONFIG_SFC_FALCON=m
> > > CONFIG_SFC_FALCON_MTD=y
> > > CONFIG_NET_VENDOR_SILAN=y
> > > CONFIG_SC92031=m
> > > CONFIG_NET_VENDOR_SIS=y
> > > CONFIG_SIS900=m
> > > CONFIG_SIS190=m
> > > CONFIG_NET_VENDOR_SMSC=y
> > > CONFIG_PCMCIA_SMC91C92=m
> > > CONFIG_EPIC100=m
> > > CONFIG_SMSC911X=m
> > > CONFIG_SMSC9420=m
> > > CONFIG_NET_VENDOR_SOCIONEXT=y
> > > CONFIG_NET_VENDOR_STMICRO=y
> > > CONFIG_STMMAC_ETH=m
> > > # CONFIG_STMMAC_SELFTESTS is not set
> > > CONFIG_STMMAC_PLATFORM=m
> > > CONFIG_DWMAC_GENERIC=m
> > > # CONFIG_STMMAC_PCI is not set
> > > CONFIG_NET_VENDOR_SUN=y
> > > CONFIG_HAPPYMEAL=m
> > > CONFIG_SUNGEM=m
> > > CONFIG_CASSINI=m
> > > CONFIG_NIU=m
> > > CONFIG_NET_VENDOR_SYNOPSYS=y
> > > CONFIG_DWC_XLGMAC=m
> > > CONFIG_DWC_XLGMAC_PCI=m
> > > CONFIG_NET_VENDOR_TEHUTI=y
> > > CONFIG_TEHUTI=m
> > > CONFIG_NET_VENDOR_TI=y
> > > # CONFIG_TI_CPSW_PHY_SEL is not set
> > > CONFIG_TLAN=m
> > > CONFIG_NET_VENDOR_VIA=y
> > > CONFIG_VIA_RHINE=m
> > > CONFIG_VIA_RHINE_MMIO=y
> > > CONFIG_VIA_VELOCITY=m
> > > CONFIG_NET_VENDOR_WIZNET=y
> > > CONFIG_WIZNET_W5100=m
> > > CONFIG_WIZNET_W5300=m
> > > # CONFIG_WIZNET_BUS_DIRECT is not set
> > > # CONFIG_WIZNET_BUS_INDIRECT is not set
> > > CONFIG_WIZNET_BUS_ANY=y
> > > CONFIG_WIZNET_W5100_SPI=m
> > > CONFIG_NET_VENDOR_XILINX=y
> > > CONFIG_XILINX_AXI_EMAC=m
> > > CONFIG_XILINX_LL_TEMAC=m
> > > CONFIG_NET_VENDOR_XIRCOM=y
> > > CONFIG_PCMCIA_XIRC2PS=m
> > > CONFIG_FDDI=y
> > > CONFIG_DEFXX=m
> > > # CONFIG_DEFXX_MMIO is not set
> > > CONFIG_SKFP=m
> > > # CONFIG_HIPPI is not set
> > > CONFIG_NET_SB1000=m
> > > CONFIG_MDIO_DEVICE=y
> > > CONFIG_MDIO_BUS=y
> > > CONFIG_MDIO_BCM_UNIMAC=m
> > > CONFIG_MDIO_BITBANG=m
> > > CONFIG_MDIO_CAVIUM=m
> > > CONFIG_MDIO_GPIO=m
> > > CONFIG_MDIO_I2C=m
> > > CONFIG_MDIO_MSCC_MIIM=m
> > > CONFIG_MDIO_THUNDER=m
> > > CONFIG_PHYLINK=m
> > > CONFIG_PHYLIB=y
> > > CONFIG_SWPHY=y
> > > CONFIG_LED_TRIGGER_PHY=y
> > > 
> > > #
> > > # MII PHY device drivers
> > > #
> > > CONFIG_SFP=m
> > > # CONFIG_ADIN_PHY is not set
> > > CONFIG_AMD_PHY=m
> > > CONFIG_AQUANTIA_PHY=m
> > > CONFIG_AX88796B_PHY=m
> > > CONFIG_BCM7XXX_PHY=m
> > > CONFIG_BCM87XX_PHY=m
> > > CONFIG_BCM_NET_PHYLIB=m
> > > CONFIG_BROADCOM_PHY=m
> > > CONFIG_CICADA_PHY=m
> > > CONFIG_CORTINA_PHY=m
> > > CONFIG_DAVICOM_PHY=m
> > > CONFIG_DP83822_PHY=m
> > > CONFIG_DP83TC811_PHY=m
> > > CONFIG_DP83848_PHY=m
> > > CONFIG_DP83867_PHY=m
> > > # CONFIG_DP83869_PHY is not set
> > > CONFIG_FIXED_PHY=y
> > > CONFIG_ICPLUS_PHY=m
> > > CONFIG_INTEL_XWAY_PHY=m
> > > CONFIG_LSI_ET1011C_PHY=m
> > > CONFIG_LXT_PHY=m
> > > CONFIG_MARVELL_PHY=m
> > > CONFIG_MARVELL_10G_PHY=m
> > > CONFIG_MICREL_PHY=m
> > > CONFIG_MICROCHIP_PHY=m
> > > CONFIG_MICROCHIP_T1_PHY=m
> > > CONFIG_MICROSEMI_PHY=m
> > > CONFIG_NATIONAL_PHY=m
> > > CONFIG_NXP_TJA11XX_PHY=m
> > > CONFIG_AT803X_PHY=m
> > > CONFIG_QSEMI_PHY=m
> > > CONFIG_REALTEK_PHY=m
> > > CONFIG_RENESAS_PHY=m
> > > CONFIG_ROCKCHIP_PHY=m
> > > CONFIG_SMSC_PHY=m
> > > CONFIG_STE10XP=m
> > > CONFIG_TERANETICS_PHY=m
> > > CONFIG_VITESSE_PHY=m
> > > CONFIG_XILINX_GMII2RGMII=m
> > > CONFIG_MICREL_KS8995MA=m
> > > CONFIG_PLIP=m
> > > CONFIG_PPP=y
> > > CONFIG_PPP_BSDCOMP=m
> > > CONFIG_PPP_DEFLATE=m
> > > CONFIG_PPP_FILTER=y
> > > CONFIG_PPP_MPPE=m
> > > CONFIG_PPP_MULTILINK=y
> > > CONFIG_PPPOATM=m
> > > CONFIG_PPPOE=m
> > > CONFIG_PPTP=m
> > > CONFIG_PPPOL2TP=m
> > > CONFIG_PPP_ASYNC=m
> > > CONFIG_PPP_SYNC_TTY=m
> > > CONFIG_SLIP=m
> > > CONFIG_SLHC=y
> > > CONFIG_SLIP_COMPRESSED=y
> > > CONFIG_SLIP_SMART=y
> > > CONFIG_SLIP_MODE_SLIP6=y
> > > CONFIG_USB_NET_DRIVERS=m
> > > CONFIG_USB_CATC=m
> > > CONFIG_USB_KAWETH=m
> > > CONFIG_USB_PEGASUS=m
> > > CONFIG_USB_RTL8150=m
> > > CONFIG_USB_RTL8152=m
> > > CONFIG_USB_LAN78XX=m
> > > CONFIG_USB_USBNET=m
> > > CONFIG_USB_NET_AX8817X=m
> > > CONFIG_USB_NET_AX88179_178A=m
> > > CONFIG_USB_NET_CDCETHER=m
> > > CONFIG_USB_NET_CDC_EEM=m
> > > CONFIG_USB_NET_CDC_NCM=m
> > > CONFIG_USB_NET_HUAWEI_CDC_NCM=m
> > > CONFIG_USB_NET_CDC_MBIM=m
> > > CONFIG_USB_NET_DM9601=m
> > > CONFIG_USB_NET_SR9700=m
> > > CONFIG_USB_NET_SR9800=m
> > > CONFIG_USB_NET_SMSC75XX=m
> > > CONFIG_USB_NET_SMSC95XX=m
> > > CONFIG_USB_NET_GL620A=m
> > > CONFIG_USB_NET_NET1080=m
> > > CONFIG_USB_NET_PLUSB=m
> > > CONFIG_USB_NET_MCS7830=m
> > > CONFIG_USB_NET_RNDIS_HOST=m
> > > CONFIG_USB_NET_CDC_SUBSET_ENABLE=m
> > > CONFIG_USB_NET_CDC_SUBSET=m
> > > CONFIG_USB_ALI_M5632=y
> > > CONFIG_USB_AN2720=y
> > > CONFIG_USB_BELKIN=y
> > > CONFIG_USB_ARMLINUX=y
> > > CONFIG_USB_EPSON2888=y
> > > CONFIG_USB_KC2190=y
> > > CONFIG_USB_NET_ZAURUS=m
> > > CONFIG_USB_NET_CX82310_ETH=m
> > > CONFIG_USB_NET_KALMIA=m
> > > CONFIG_USB_NET_QMI_WWAN=m
> > > CONFIG_USB_HSO=m
> > > CONFIG_USB_NET_INT51X1=m
> > > CONFIG_USB_CDC_PHONET=m
> > > CONFIG_USB_IPHETH=m
> > > CONFIG_USB_SIERRA_NET=m
> > > CONFIG_USB_VL600=m
> > > CONFIG_USB_NET_CH9200=m
> > > CONFIG_USB_NET_AQC111=m
> > > CONFIG_WLAN=y
> > > # CONFIG_WIRELESS_WDS is not set
> > > CONFIG_WLAN_VENDOR_ADMTEK=y
> > > CONFIG_ADM8211=m
> > > CONFIG_ATH_COMMON=m
> > > CONFIG_WLAN_VENDOR_ATH=y
> > > # CONFIG_ATH_DEBUG is not set
> > > CONFIG_ATH5K=m
> > > # CONFIG_ATH5K_DEBUG is not set
> > > # CONFIG_ATH5K_TRACER is not set
> > > CONFIG_ATH5K_PCI=y
> > > CONFIG_ATH9K_HW=m
> > > CONFIG_ATH9K_COMMON=m
> > > CONFIG_ATH9K_COMMON_DEBUG=y
> > > CONFIG_ATH9K_BTCOEX_SUPPORT=y
> > > CONFIG_ATH9K=m
> > > CONFIG_ATH9K_PCI=y
> > > CONFIG_ATH9K_AHB=y
> > > CONFIG_ATH9K_DEBUGFS=y
> > > CONFIG_ATH9K_STATION_STATISTICS=y
> > > # CONFIG_ATH9K_DYNACK is not set
> > > CONFIG_ATH9K_WOW=y
> > > CONFIG_ATH9K_RFKILL=y
> > > CONFIG_ATH9K_CHANNEL_CONTEXT=y
> > > CONFIG_ATH9K_PCOEM=y
> > > # CONFIG_ATH9K_PCI_NO_EEPROM is not set
> > > CONFIG_ATH9K_HTC=m
> > > CONFIG_ATH9K_HTC_DEBUGFS=y
> > > CONFIG_ATH9K_HWRNG=y
> > > CONFIG_ATH9K_COMMON_SPECTRAL=y
> > > CONFIG_CARL9170=m
> > > CONFIG_CARL9170_LEDS=y
> > > # CONFIG_CARL9170_DEBUGFS is not set
> > > CONFIG_CARL9170_WPC=y
> > > CONFIG_CARL9170_HWRNG=y
> > > CONFIG_ATH6KL=m
> > > CONFIG_ATH6KL_SDIO=m
> > > CONFIG_ATH6KL_USB=m
> > > # CONFIG_ATH6KL_DEBUG is not set
> > > # CONFIG_ATH6KL_TRACING is not set
> > > CONFIG_AR5523=m
> > > CONFIG_WIL6210=m
> > > CONFIG_WIL6210_ISR_COR=y
> > > CONFIG_WIL6210_TRACING=y
> > > CONFIG_WIL6210_DEBUGFS=y
> > > CONFIG_ATH10K=m
> > > CONFIG_ATH10K_CE=y
> > > CONFIG_ATH10K_PCI=m
> > > CONFIG_ATH10K_SDIO=m
> > > CONFIG_ATH10K_USB=m
> > > # CONFIG_ATH10K_DEBUG is not set
> > > CONFIG_ATH10K_DEBUGFS=y
> > > CONFIG_ATH10K_SPECTRAL=y
> > > CONFIG_ATH10K_TRACING=y
> > > CONFIG_WCN36XX=m
> > > # CONFIG_WCN36XX_DEBUGFS is not set
> > > CONFIG_WLAN_VENDOR_ATMEL=y
> > > CONFIG_ATMEL=m
> > > CONFIG_PCI_ATMEL=m
> > > CONFIG_PCMCIA_ATMEL=m
> > > CONFIG_AT76C50X_USB=m
> > > CONFIG_WLAN_VENDOR_BROADCOM=y
> > > CONFIG_B43=m
> > > CONFIG_B43_BCMA=y
> > > CONFIG_B43_SSB=y
> > > CONFIG_B43_BUSES_BCMA_AND_SSB=y
> > > # CONFIG_B43_BUSES_BCMA is not set
> > > # CONFIG_B43_BUSES_SSB is not set
> > > CONFIG_B43_PCI_AUTOSELECT=y
> > > CONFIG_B43_PCICORE_AUTOSELECT=y
> > > # CONFIG_B43_SDIO is not set
> > > CONFIG_B43_BCMA_PIO=y
> > > CONFIG_B43_PIO=y
> > > CONFIG_B43_PHY_G=y
> > > CONFIG_B43_PHY_N=y
> > > CONFIG_B43_PHY_LP=y
> > > CONFIG_B43_PHY_HT=y
> > > CONFIG_B43_LEDS=y
> > > CONFIG_B43_HWRNG=y
> > > # CONFIG_B43_DEBUG is not set
> > > CONFIG_B43LEGACY=m
> > > CONFIG_B43LEGACY_PCI_AUTOSELECT=y
> > > CONFIG_B43LEGACY_PCICORE_AUTOSELECT=y
> > > CONFIG_B43LEGACY_LEDS=y
> > > CONFIG_B43LEGACY_HWRNG=y
> > > # CONFIG_B43LEGACY_DEBUG is not set
> > > CONFIG_B43LEGACY_DMA=y
> > > CONFIG_B43LEGACY_PIO=y
> > > CONFIG_B43LEGACY_DMA_AND_PIO_MODE=y
> > > # CONFIG_B43LEGACY_DMA_MODE is not set
> > > # CONFIG_B43LEGACY_PIO_MODE is not set
> > > CONFIG_BRCMUTIL=m
> > > CONFIG_BRCMSMAC=m
> > > CONFIG_BRCMFMAC=m
> > > CONFIG_BRCMFMAC_PROTO_BCDC=y
> > > CONFIG_BRCMFMAC_PROTO_MSGBUF=y
> > > CONFIG_BRCMFMAC_SDIO=y
> > > CONFIG_BRCMFMAC_USB=y
> > > CONFIG_BRCMFMAC_PCIE=y
> > > CONFIG_BRCM_TRACING=y
> > > # CONFIG_BRCMDBG is not set
> > > CONFIG_WLAN_VENDOR_CISCO=y
> > > CONFIG_AIRO=m
> > > CONFIG_AIRO_CS=m
> > > CONFIG_WLAN_VENDOR_INTEL=y
> > > CONFIG_IPW2100=m
> > > CONFIG_IPW2100_MONITOR=y
> > > # CONFIG_IPW2100_DEBUG is not set
> > > CONFIG_IPW2200=m
> > > CONFIG_IPW2200_MONITOR=y
> > > CONFIG_IPW2200_RADIOTAP=y
> > > CONFIG_IPW2200_PROMISCUOUS=y
> > > CONFIG_IPW2200_QOS=y
> > > # CONFIG_IPW2200_DEBUG is not set
> > > CONFIG_LIBIPW=m
> > > # CONFIG_LIBIPW_DEBUG is not set
> > > CONFIG_IWLEGACY=m
> > > CONFIG_IWL4965=m
> > > CONFIG_IWL3945=m
> > > 
> > > #
> > > # iwl3945 / iwl4965 Debugging Options
> > > #
> > > # CONFIG_IWLEGACY_DEBUG is not set
> > > CONFIG_IWLEGACY_DEBUGFS=y
> > > # end of iwl3945 / iwl4965 Debugging Options
> > > 
> > > CONFIG_IWLWIFI=m
> > > CONFIG_IWLWIFI_LEDS=y
> > > CONFIG_IWLDVM=m
> > > CONFIG_IWLMVM=m
> > > CONFIG_IWLWIFI_OPMODE_MODULAR=y
> > > # CONFIG_IWLWIFI_BCAST_FILTERING is not set
> > > 
> > > #
> > > # Debugging Options
> > > #
> > > # CONFIG_IWLWIFI_DEBUG is not set
> > > CONFIG_IWLWIFI_DEBUGFS=y
> > > CONFIG_IWLWIFI_DEVICE_TRACING=y
> > > # end of Debugging Options
> > > 
> > > CONFIG_WLAN_VENDOR_INTERSIL=y
> > > CONFIG_HOSTAP=m
> > > CONFIG_HOSTAP_FIRMWARE=y
> > > CONFIG_HOSTAP_FIRMWARE_NVRAM=y
> > > CONFIG_HOSTAP_PLX=m
> > > CONFIG_HOSTAP_PCI=m
> > > CONFIG_HOSTAP_CS=m
> > > CONFIG_HERMES=m
> > > # CONFIG_HERMES_PRISM is not set
> > > CONFIG_HERMES_CACHE_FW_ON_INIT=y
> > > CONFIG_PLX_HERMES=m
> > > CONFIG_TMD_HERMES=m
> > > CONFIG_NORTEL_HERMES=m
> > > CONFIG_PCMCIA_HERMES=m
> > > CONFIG_PCMCIA_SPECTRUM=m
> > > CONFIG_ORINOCO_USB=m
> > > CONFIG_P54_COMMON=m
> > > CONFIG_P54_USB=m
> > > CONFIG_P54_PCI=m
> > > CONFIG_P54_SPI=m
> > > # CONFIG_P54_SPI_DEFAULT_EEPROM is not set
> > > CONFIG_P54_LEDS=y
> > > # CONFIG_PRISM54 is not set
> > > CONFIG_WLAN_VENDOR_MARVELL=y
> > > CONFIG_LIBERTAS=m
> > > CONFIG_LIBERTAS_USB=m
> > > CONFIG_LIBERTAS_CS=m
> > > CONFIG_LIBERTAS_SDIO=m
> > > CONFIG_LIBERTAS_SPI=m
> > > # CONFIG_LIBERTAS_DEBUG is not set
> > > CONFIG_LIBERTAS_MESH=y
> > > CONFIG_LIBERTAS_THINFIRM=m
> > > # CONFIG_LIBERTAS_THINFIRM_DEBUG is not set
> > > CONFIG_LIBERTAS_THINFIRM_USB=m
> > > CONFIG_MWIFIEX=m
> > > CONFIG_MWIFIEX_SDIO=m
> > > CONFIG_MWIFIEX_PCIE=m
> > > CONFIG_MWIFIEX_USB=m
> > > CONFIG_MWL8K=m
> > > CONFIG_WLAN_VENDOR_MEDIATEK=y
> > > CONFIG_MT7601U=m
> > > CONFIG_MT76_CORE=m
> > > CONFIG_MT76_LEDS=y
> > > CONFIG_MT76_USB=m
> > > CONFIG_MT76x02_LIB=m
> > > CONFIG_MT76x02_USB=m
> > > CONFIG_MT76x0_COMMON=m
> > > CONFIG_MT76x0U=m
> > > CONFIG_MT76x0E=m
> > > CONFIG_MT76x2_COMMON=m
> > > CONFIG_MT76x2E=m
> > > CONFIG_MT76x2U=m
> > > CONFIG_MT7603E=m
> > > CONFIG_MT7615E=m
> > > CONFIG_WLAN_VENDOR_RALINK=y
> > > CONFIG_RT2X00=m
> > > CONFIG_RT2400PCI=m
> > > CONFIG_RT2500PCI=m
> > > CONFIG_RT61PCI=m
> > > CONFIG_RT2800PCI=m
> > > CONFIG_RT2800PCI_RT33XX=y
> > > CONFIG_RT2800PCI_RT35XX=y
> > > CONFIG_RT2800PCI_RT53XX=y
> > > CONFIG_RT2800PCI_RT3290=y
> > > CONFIG_RT2500USB=m
> > > CONFIG_RT73USB=m
> > > CONFIG_RT2800USB=m
> > > CONFIG_RT2800USB_RT33XX=y
> > > CONFIG_RT2800USB_RT35XX=y
> > > CONFIG_RT2800USB_RT3573=y
> > > CONFIG_RT2800USB_RT53XX=y
> > > CONFIG_RT2800USB_RT55XX=y
> > > CONFIG_RT2800USB_UNKNOWN=y
> > > CONFIG_RT2800_LIB=m
> > > CONFIG_RT2800_LIB_MMIO=m
> > > CONFIG_RT2X00_LIB_MMIO=m
> > > CONFIG_RT2X00_LIB_PCI=m
> > > CONFIG_RT2X00_LIB_USB=m
> > > CONFIG_RT2X00_LIB=m
> > > CONFIG_RT2X00_LIB_FIRMWARE=y
> > > CONFIG_RT2X00_LIB_CRYPTO=y
> > > CONFIG_RT2X00_LIB_LEDS=y
> > > # CONFIG_RT2X00_LIB_DEBUGFS is not set
> > > # CONFIG_RT2X00_DEBUG is not set
> > > CONFIG_WLAN_VENDOR_REALTEK=y
> > > CONFIG_RTL8180=m
> > > CONFIG_RTL8187=m
> > > CONFIG_RTL8187_LEDS=y
> > > CONFIG_RTL_CARDS=m
> > > CONFIG_RTL8192CE=m
> > > CONFIG_RTL8192SE=m
> > > CONFIG_RTL8192DE=m
> > > CONFIG_RTL8723AE=m
> > > CONFIG_RTL8723BE=m
> > > CONFIG_RTL8188EE=m
> > > CONFIG_RTL8192EE=m
> > > CONFIG_RTL8821AE=m
> > > CONFIG_RTL8192CU=m
> > > CONFIG_RTLWIFI=m
> > > CONFIG_RTLWIFI_PCI=m
> > > CONFIG_RTLWIFI_USB=m
> > > # CONFIG_RTLWIFI_DEBUG is not set
> > > CONFIG_RTL8192C_COMMON=m
> > > CONFIG_RTL8723_COMMON=m
> > > CONFIG_RTLBTCOEXIST=m
> > > CONFIG_RTL8XXXU=m
> > > CONFIG_RTL8XXXU_UNTESTED=y
> > > CONFIG_RTW88=m
> > > CONFIG_RTW88_CORE=m
> > > CONFIG_RTW88_PCI=m
> > > CONFIG_RTW88_8822BE=y
> > > CONFIG_RTW88_8822CE=y
> > > CONFIG_RTW88_DEBUG=y
> > > CONFIG_RTW88_DEBUGFS=y
> > > CONFIG_WLAN_VENDOR_RSI=y
> > > CONFIG_RSI_91X=m
> > > # CONFIG_RSI_DEBUGFS is not set
> > > CONFIG_RSI_SDIO=m
> > > CONFIG_RSI_USB=m
> > > CONFIG_RSI_COEX=y
> > > CONFIG_WLAN_VENDOR_ST=y
> > > CONFIG_CW1200=m
> > > CONFIG_CW1200_WLAN_SDIO=m
> > > CONFIG_CW1200_WLAN_SPI=m
> > > CONFIG_WLAN_VENDOR_TI=y
> > > CONFIG_WL1251=m
> > > CONFIG_WL1251_SPI=m
> > > CONFIG_WL1251_SDIO=m
> > > CONFIG_WL12XX=m
> > > CONFIG_WL18XX=m
> > > CONFIG_WLCORE=m
> > > CONFIG_WLCORE_SDIO=m
> > > CONFIG_WILINK_PLATFORM_DATA=y
> > > CONFIG_WLAN_VENDOR_ZYDAS=y
> > > CONFIG_USB_ZD1201=m
> > > CONFIG_ZD1211RW=m
> > > # CONFIG_ZD1211RW_DEBUG is not set
> > > CONFIG_WLAN_VENDOR_QUANTENNA=y
> > > CONFIG_QTNFMAC=m
> > > CONFIG_QTNFMAC_PCIE=m
> > > CONFIG_PCMCIA_RAYCS=m
> > > CONFIG_PCMCIA_WL3501=m
> > > CONFIG_MAC80211_HWSIM=m
> > > CONFIG_USB_NET_RNDIS_WLAN=m
> > > CONFIG_VIRT_WIFI=m
> > > 
> > > #
> > > # WiMAX Wireless Broadband devices
> > > #
> > > CONFIG_WIMAX_I2400M=m
> > > CONFIG_WIMAX_I2400M_USB=m
> > > CONFIG_WIMAX_I2400M_DEBUG_LEVEL=8
> > > # end of WiMAX Wireless Broadband devices
> > > 
> > > CONFIG_WAN=y
> > > CONFIG_LANMEDIA=m
> > > CONFIG_HDLC=m
> > > CONFIG_HDLC_RAW=m
> > > CONFIG_HDLC_RAW_ETH=m
> > > CONFIG_HDLC_CISCO=m
> > > CONFIG_HDLC_FR=m
> > > CONFIG_HDLC_PPP=m
> > > CONFIG_HDLC_X25=m
> > > CONFIG_PCI200SYN=m
> > > CONFIG_WANXL=m
> > > CONFIG_PC300TOO=m
> > > CONFIG_FARSYNC=m
> > > CONFIG_DLCI=m
> > > CONFIG_DLCI_MAX=8
> > > CONFIG_LAPBETHER=m
> > > CONFIG_X25_ASY=m
> > > CONFIG_SBNI=m
> > > # CONFIG_SBNI_MULTILINE is not set
> > > CONFIG_IEEE802154_DRIVERS=m
> > > CONFIG_IEEE802154_FAKELB=m
> > > CONFIG_IEEE802154_AT86RF230=m
> > > CONFIG_IEEE802154_AT86RF230_DEBUGFS=y
> > > CONFIG_IEEE802154_MRF24J40=m
> > > CONFIG_IEEE802154_CC2520=m
> > > CONFIG_IEEE802154_ATUSB=m
> > > CONFIG_IEEE802154_ADF7242=m
> > > CONFIG_IEEE802154_CA8210=m
> > > CONFIG_IEEE802154_CA8210_DEBUGFS=y
> > > CONFIG_IEEE802154_MCR20A=m
> > > CONFIG_IEEE802154_HWSIM=m
> > > CONFIG_XEN_NETDEV_FRONTEND=y
> > > CONFIG_XEN_NETDEV_BACKEND=m
> > > CONFIG_VMXNET3=m
> > > CONFIG_FUJITSU_ES=m
> > > CONFIG_THUNDERBOLT_NET=m
> > > CONFIG_HYPERV_NET=m
> > > CONFIG_NETDEVSIM=m
> > > CONFIG_NET_FAILOVER=m
> > > CONFIG_ISDN=y
> > > CONFIG_ISDN_CAPI=m
> > > CONFIG_CAPI_TRACE=y
> > > CONFIG_ISDN_CAPI_CAPI20=m
> > > CONFIG_ISDN_CAPI_MIDDLEWARE=y
> > > CONFIG_MISDN=m
> > > CONFIG_MISDN_DSP=m
> > > CONFIG_MISDN_L1OIP=m
> > > 
> > > #
> > > # mISDN hardware drivers
> > > #
> > > CONFIG_MISDN_HFCPCI=m
> > > CONFIG_MISDN_HFCMULTI=m
> > > CONFIG_MISDN_HFCUSB=m
> > > CONFIG_MISDN_AVMFRITZ=m
> > > CONFIG_MISDN_SPEEDFAX=m
> > > CONFIG_MISDN_INFINEON=m
> > > CONFIG_MISDN_W6692=m
> > > CONFIG_MISDN_NETJET=m
> > > CONFIG_MISDN_HDLC=m
> > > CONFIG_MISDN_IPAC=m
> > > CONFIG_MISDN_ISAR=m
> > > CONFIG_NVM=y
> > > CONFIG_NVM_PBLK=m
> > > # CONFIG_NVM_PBLK_DEBUG is not set
> > > 
> > > #
> > > # Input device support
> > > #
> > > CONFIG_INPUT=y
> > > CONFIG_INPUT_LEDS=m
> > > CONFIG_INPUT_FF_MEMLESS=m
> > > CONFIG_INPUT_POLLDEV=m
> > > CONFIG_INPUT_SPARSEKMAP=m
> > > CONFIG_INPUT_MATRIXKMAP=m
> > > 
> > > #
> > > # Userland interfaces
> > > #
> > > CONFIG_INPUT_MOUSEDEV=y
> > > CONFIG_INPUT_MOUSEDEV_PSAUX=y
> > > CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> > > CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> > > CONFIG_INPUT_JOYDEV=m
> > > CONFIG_INPUT_EVDEV=y
> > > CONFIG_INPUT_EVBUG=m
> > > 
> > > #
> > > # Input Device Drivers
> > > #
> > > CONFIG_INPUT_KEYBOARD=y
> > > CONFIG_KEYBOARD_ADC=m
> > > CONFIG_KEYBOARD_ADP5520=m
> > > CONFIG_KEYBOARD_ADP5588=m
> > > CONFIG_KEYBOARD_ADP5589=m
> > > CONFIG_KEYBOARD_APPLESPI=m
> > > CONFIG_KEYBOARD_ATKBD=y
> > > CONFIG_KEYBOARD_QT1050=m
> > > CONFIG_KEYBOARD_QT1070=m
> > > CONFIG_KEYBOARD_QT2160=m
> > > CONFIG_KEYBOARD_DLINK_DIR685=m
> > > CONFIG_KEYBOARD_LKKBD=m
> > > CONFIG_KEYBOARD_GPIO=m
> > > CONFIG_KEYBOARD_GPIO_POLLED=m
> > > CONFIG_KEYBOARD_TCA6416=m
> > > CONFIG_KEYBOARD_TCA8418=m
> > > CONFIG_KEYBOARD_MATRIX=m
> > > CONFIG_KEYBOARD_LM8323=m
> > > CONFIG_KEYBOARD_LM8333=m
> > > CONFIG_KEYBOARD_MAX7359=m
> > > CONFIG_KEYBOARD_MCS=m
> > > CONFIG_KEYBOARD_MPR121=m
> > > CONFIG_KEYBOARD_NEWTON=m
> > > CONFIG_KEYBOARD_OPENCORES=m
> > > CONFIG_KEYBOARD_SAMSUNG=m
> > > CONFIG_KEYBOARD_STOWAWAY=m
> > > CONFIG_KEYBOARD_SUNKBD=m
> > > CONFIG_KEYBOARD_TM2_TOUCHKEY=m
> > > CONFIG_KEYBOARD_TWL4030=m
> > > CONFIG_KEYBOARD_XTKBD=m
> > > CONFIG_KEYBOARD_CROS_EC=m
> > > CONFIG_KEYBOARD_MTK_PMIC=m
> > > CONFIG_INPUT_MOUSE=y
> > > CONFIG_MOUSE_PS2=m
> > > CONFIG_MOUSE_PS2_ALPS=y
> > > CONFIG_MOUSE_PS2_BYD=y
> > > CONFIG_MOUSE_PS2_LOGIPS2PP=y
> > > CONFIG_MOUSE_PS2_SYNAPTICS=y
> > > CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
> > > CONFIG_MOUSE_PS2_CYPRESS=y
> > > CONFIG_MOUSE_PS2_LIFEBOOK=y
> > > CONFIG_MOUSE_PS2_TRACKPOINT=y
> > > CONFIG_MOUSE_PS2_ELANTECH=y
> > > CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
> > > CONFIG_MOUSE_PS2_SENTELIC=y
> > > CONFIG_MOUSE_PS2_TOUCHKIT=y
> > > CONFIG_MOUSE_PS2_FOCALTECH=y
> > > CONFIG_MOUSE_PS2_VMMOUSE=y
> > > CONFIG_MOUSE_PS2_SMBUS=y
> > > CONFIG_MOUSE_SERIAL=m
> > > CONFIG_MOUSE_APPLETOUCH=m
> > > CONFIG_MOUSE_BCM5974=m
> > > CONFIG_MOUSE_CYAPA=m
> > > CONFIG_MOUSE_ELAN_I2C=m
> > > CONFIG_MOUSE_ELAN_I2C_I2C=y
> > > CONFIG_MOUSE_ELAN_I2C_SMBUS=y
> > > CONFIG_MOUSE_VSXXXAA=m
> > > CONFIG_MOUSE_GPIO=m
> > > CONFIG_MOUSE_SYNAPTICS_I2C=m
> > > CONFIG_MOUSE_SYNAPTICS_USB=m
> > > CONFIG_INPUT_JOYSTICK=y
> > > CONFIG_JOYSTICK_ANALOG=m
> > > CONFIG_JOYSTICK_A3D=m
> > > CONFIG_JOYSTICK_ADI=m
> > > CONFIG_JOYSTICK_COBRA=m
> > > CONFIG_JOYSTICK_GF2K=m
> > > CONFIG_JOYSTICK_GRIP=m
> > > CONFIG_JOYSTICK_GRIP_MP=m
> > > CONFIG_JOYSTICK_GUILLEMOT=m
> > > CONFIG_JOYSTICK_INTERACT=m
> > > CONFIG_JOYSTICK_SIDEWINDER=m
> > > CONFIG_JOYSTICK_TMDC=m
> > > CONFIG_JOYSTICK_IFORCE=m
> > > CONFIG_JOYSTICK_IFORCE_USB=m
> > > CONFIG_JOYSTICK_IFORCE_232=m
> > > CONFIG_JOYSTICK_WARRIOR=m
> > > CONFIG_JOYSTICK_MAGELLAN=m
> > > CONFIG_JOYSTICK_SPACEORB=m
> > > CONFIG_JOYSTICK_SPACEBALL=m
> > > CONFIG_JOYSTICK_STINGER=m
> > > CONFIG_JOYSTICK_TWIDJOY=m
> > > CONFIG_JOYSTICK_ZHENHUA=m
> > > CONFIG_JOYSTICK_DB9=m
> > > CONFIG_JOYSTICK_GAMECON=m
> > > CONFIG_JOYSTICK_TURBOGRAFX=m
> > > CONFIG_JOYSTICK_AS5011=m
> > > CONFIG_JOYSTICK_JOYDUMP=m
> > > CONFIG_JOYSTICK_XPAD=m
> > > CONFIG_JOYSTICK_XPAD_FF=y
> > > CONFIG_JOYSTICK_XPAD_LEDS=y
> > > CONFIG_JOYSTICK_WALKERA0701=m
> > > CONFIG_JOYSTICK_PSXPAD_SPI=m
> > > CONFIG_JOYSTICK_PSXPAD_SPI_FF=y
> > > CONFIG_JOYSTICK_PXRC=m
> > > # CONFIG_JOYSTICK_FSIA6B is not set
> > > CONFIG_INPUT_TABLET=y
> > > CONFIG_TABLET_USB_ACECAD=m
> > > CONFIG_TABLET_USB_AIPTEK=m
> > > CONFIG_TABLET_USB_GTCO=m
> > > CONFIG_TABLET_USB_HANWANG=m
> > > CONFIG_TABLET_USB_KBTAB=m
> > > CONFIG_TABLET_USB_PEGASUS=m
> > > CONFIG_TABLET_SERIAL_WACOM4=m
> > > CONFIG_INPUT_TOUCHSCREEN=y
> > > CONFIG_TOUCHSCREEN_PROPERTIES=y
> > > CONFIG_TOUCHSCREEN_88PM860X=m
> > > CONFIG_TOUCHSCREEN_ADS7846=m
> > > CONFIG_TOUCHSCREEN_AD7877=m
> > > CONFIG_TOUCHSCREEN_AD7879=m
> > > CONFIG_TOUCHSCREEN_AD7879_I2C=m
> > > CONFIG_TOUCHSCREEN_AD7879_SPI=m
> > > CONFIG_TOUCHSCREEN_ADC=m
> > > CONFIG_TOUCHSCREEN_ATMEL_MXT=m
> > > CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
> > > CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
> > > CONFIG_TOUCHSCREEN_BU21013=m
> > > CONFIG_TOUCHSCREEN_BU21029=m
> > > CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=m
> > > CONFIG_TOUCHSCREEN_CY8CTMG110=m
> > > CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
> > > CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
> > > CONFIG_TOUCHSCREEN_CYTTSP_SPI=m
> > > CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
> > > CONFIG_TOUCHSCREEN_CYTTSP4_I2C=m
> > > CONFIG_TOUCHSCREEN_CYTTSP4_SPI=m
> > > CONFIG_TOUCHSCREEN_DA9034=m
> > > CONFIG_TOUCHSCREEN_DA9052=m
> > > CONFIG_TOUCHSCREEN_DYNAPRO=m
> > > CONFIG_TOUCHSCREEN_HAMPSHIRE=m
> > > CONFIG_TOUCHSCREEN_EETI=m
> > > CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
> > > CONFIG_TOUCHSCREEN_EXC3000=m
> > > CONFIG_TOUCHSCREEN_FUJITSU=m
> > > CONFIG_TOUCHSCREEN_GOODIX=m
> > > CONFIG_TOUCHSCREEN_HIDEEP=m
> > > CONFIG_TOUCHSCREEN_ILI210X=m
> > > CONFIG_TOUCHSCREEN_S6SY761=m
> > > CONFIG_TOUCHSCREEN_GUNZE=m
> > > CONFIG_TOUCHSCREEN_EKTF2127=m
> > > CONFIG_TOUCHSCREEN_ELAN=y
> > > CONFIG_TOUCHSCREEN_ELO=m
> > > CONFIG_TOUCHSCREEN_WACOM_W8001=m
> > > CONFIG_TOUCHSCREEN_WACOM_I2C=m
> > > CONFIG_TOUCHSCREEN_MAX11801=m
> > > CONFIG_TOUCHSCREEN_MCS5000=m
> > > CONFIG_TOUCHSCREEN_MMS114=m
> > > CONFIG_TOUCHSCREEN_MELFAS_MIP4=m
> > > CONFIG_TOUCHSCREEN_MTOUCH=m
> > > CONFIG_TOUCHSCREEN_INEXIO=m
> > > CONFIG_TOUCHSCREEN_MK712=m
> > > CONFIG_TOUCHSCREEN_PENMOUNT=m
> > > CONFIG_TOUCHSCREEN_EDT_FT5X06=m
> > > CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
> > > CONFIG_TOUCHSCREEN_TOUCHWIN=m
> > > CONFIG_TOUCHSCREEN_TI_AM335X_TSC=m
> > > CONFIG_TOUCHSCREEN_UCB1400=m
> > > CONFIG_TOUCHSCREEN_PIXCIR=m
> > > CONFIG_TOUCHSCREEN_WDT87XX_I2C=m
> > > CONFIG_TOUCHSCREEN_WM831X=m
> > > CONFIG_TOUCHSCREEN_WM97XX=m
> > > CONFIG_TOUCHSCREEN_WM9705=y
> > > CONFIG_TOUCHSCREEN_WM9712=y
> > > CONFIG_TOUCHSCREEN_WM9713=y
> > > CONFIG_TOUCHSCREEN_USB_COMPOSITE=m
> > > CONFIG_TOUCHSCREEN_MC13783=m
> > > CONFIG_TOUCHSCREEN_USB_EGALAX=y
> > > CONFIG_TOUCHSCREEN_USB_PANJIT=y
> > > CONFIG_TOUCHSCREEN_USB_3M=y
> > > CONFIG_TOUCHSCREEN_USB_ITM=y
> > > CONFIG_TOUCHSCREEN_USB_ETURBO=y
> > > CONFIG_TOUCHSCREEN_USB_GUNZE=y
> > > CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
> > > CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
> > > CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
> > > CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
> > > CONFIG_TOUCHSCREEN_USB_GOTOP=y
> > > CONFIG_TOUCHSCREEN_USB_JASTEC=y
> > > CONFIG_TOUCHSCREEN_USB_ELO=y
> > > CONFIG_TOUCHSCREEN_USB_E2I=y
> > > CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
> > > CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
> > > CONFIG_TOUCHSCREEN_USB_NEXIO=y
> > > CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
> > > CONFIG_TOUCHSCREEN_TOUCHIT213=m
> > > CONFIG_TOUCHSCREEN_TSC_SERIO=m
> > > CONFIG_TOUCHSCREEN_TSC200X_CORE=m
> > > CONFIG_TOUCHSCREEN_TSC2004=m
> > > CONFIG_TOUCHSCREEN_TSC2005=m
> > > CONFIG_TOUCHSCREEN_TSC2007=m
> > > CONFIG_TOUCHSCREEN_TSC2007_IIO=y
> > > CONFIG_TOUCHSCREEN_PCAP=m
> > > CONFIG_TOUCHSCREEN_RM_TS=m
> > > CONFIG_TOUCHSCREEN_SILEAD=m
> > > CONFIG_TOUCHSCREEN_SIS_I2C=m
> > > CONFIG_TOUCHSCREEN_ST1232=m
> > > CONFIG_TOUCHSCREEN_STMFTS=m
> > > CONFIG_TOUCHSCREEN_SUR40=m
> > > CONFIG_TOUCHSCREEN_SURFACE3_SPI=m
> > > CONFIG_TOUCHSCREEN_SX8654=m
> > > CONFIG_TOUCHSCREEN_TPS6507X=m
> > > CONFIG_TOUCHSCREEN_ZET6223=m
> > > CONFIG_TOUCHSCREEN_ZFORCE=m
> > > CONFIG_TOUCHSCREEN_ROHM_BU21023=m
> > > CONFIG_TOUCHSCREEN_IQS5XX=m
> > > CONFIG_INPUT_MISC=y
> > > CONFIG_INPUT_88PM860X_ONKEY=m
> > > CONFIG_INPUT_88PM80X_ONKEY=m
> > > CONFIG_INPUT_AD714X=m
> > > CONFIG_INPUT_AD714X_I2C=m
> > > CONFIG_INPUT_AD714X_SPI=m
> > > CONFIG_INPUT_ARIZONA_HAPTICS=m
> > > CONFIG_INPUT_BMA150=m
> > > CONFIG_INPUT_E3X0_BUTTON=m
> > > CONFIG_INPUT_MSM_VIBRATOR=m
> > > CONFIG_INPUT_PCSPKR=m
> > > CONFIG_INPUT_MAX77693_HAPTIC=m
> > > CONFIG_INPUT_MAX8925_ONKEY=m
> > > CONFIG_INPUT_MAX8997_HAPTIC=m
> > > CONFIG_INPUT_MC13783_PWRBUTTON=m
> > > CONFIG_INPUT_MMA8450=m
> > > CONFIG_INPUT_APANEL=m
> > > CONFIG_INPUT_GP2A=m
> > > CONFIG_INPUT_GPIO_BEEPER=m
> > > CONFIG_INPUT_GPIO_DECODER=m
> > > CONFIG_INPUT_GPIO_VIBRA=m
> > > CONFIG_INPUT_ATLAS_BTNS=m
> > > CONFIG_INPUT_ATI_REMOTE2=m
> > > CONFIG_INPUT_KEYSPAN_REMOTE=m
> > > CONFIG_INPUT_KXTJ9=m
> > > CONFIG_INPUT_POWERMATE=m
> > > CONFIG_INPUT_YEALINK=m
> > > CONFIG_INPUT_CM109=m
> > > CONFIG_INPUT_REGULATOR_HAPTIC=m
> > > CONFIG_INPUT_RETU_PWRBUTTON=m
> > > CONFIG_INPUT_AXP20X_PEK=m
> > > CONFIG_INPUT_TWL4030_PWRBUTTON=m
> > > CONFIG_INPUT_TWL4030_VIBRA=m
> > > CONFIG_INPUT_TWL6040_VIBRA=m
> > > CONFIG_INPUT_UINPUT=y
> > > CONFIG_INPUT_PALMAS_PWRBUTTON=m
> > > CONFIG_INPUT_PCF50633_PMU=m
> > > CONFIG_INPUT_PCF8574=m
> > > CONFIG_INPUT_PWM_BEEPER=m
> > > CONFIG_INPUT_PWM_VIBRA=m
> > > CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
> > > CONFIG_INPUT_DA9052_ONKEY=m
> > > CONFIG_INPUT_DA9055_ONKEY=m
> > > CONFIG_INPUT_DA9063_ONKEY=m
> > > CONFIG_INPUT_WM831X_ON=m
> > > CONFIG_INPUT_PCAP=m
> > > CONFIG_INPUT_ADXL34X=m
> > > CONFIG_INPUT_ADXL34X_I2C=m
> > > CONFIG_INPUT_ADXL34X_SPI=m
> > > CONFIG_INPUT_IMS_PCU=m
> > > CONFIG_INPUT_CMA3000=m
> > > CONFIG_INPUT_CMA3000_I2C=m
> > > CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
> > > CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
> > > CONFIG_INPUT_SOC_BUTTON_ARRAY=m
> > > CONFIG_INPUT_DRV260X_HAPTICS=m
> > > CONFIG_INPUT_DRV2665_HAPTICS=m
> > > CONFIG_INPUT_DRV2667_HAPTICS=m
> > > CONFIG_INPUT_RAVE_SP_PWRBUTTON=m
> > > CONFIG_RMI4_CORE=m
> > > CONFIG_RMI4_I2C=m
> > > CONFIG_RMI4_SPI=m
> > > CONFIG_RMI4_SMB=m
> > > CONFIG_RMI4_F03=y
> > > CONFIG_RMI4_F03_SERIO=m
> > > CONFIG_RMI4_2D_SENSOR=y
> > > CONFIG_RMI4_F11=y
> > > CONFIG_RMI4_F12=y
> > > CONFIG_RMI4_F30=y
> > > CONFIG_RMI4_F34=y
> > > CONFIG_RMI4_F54=y
> > > CONFIG_RMI4_F55=y
> > > 
> > > #
> > > # Hardware I/O ports
> > > #
> > > CONFIG_SERIO=y
> > > CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> > > CONFIG_SERIO_I8042=y
> > > CONFIG_SERIO_SERPORT=m
> > > CONFIG_SERIO_CT82C710=m
> > > CONFIG_SERIO_PARKBD=m
> > > CONFIG_SERIO_PCIPS2=m
> > > CONFIG_SERIO_LIBPS2=y
> > > CONFIG_SERIO_RAW=m
> > > CONFIG_SERIO_ALTERA_PS2=m
> > > CONFIG_SERIO_PS2MULT=m
> > > CONFIG_SERIO_ARC_PS2=m
> > > CONFIG_HYPERV_KEYBOARD=m
> > > CONFIG_SERIO_GPIO_PS2=m
> > > CONFIG_USERIO=m
> > > CONFIG_GAMEPORT=m
> > > CONFIG_GAMEPORT_NS558=m
> > > CONFIG_GAMEPORT_L4=m
> > > CONFIG_GAMEPORT_EMU10K1=m
> > > CONFIG_GAMEPORT_FM801=m
> > > # end of Hardware I/O ports
> > > # end of Input device support
> > > 
> > > #
> > > # Character devices
> > > #
> > > CONFIG_TTY=y
> > > CONFIG_VT=y
> > > CONFIG_CONSOLE_TRANSLATIONS=y
> > > CONFIG_VT_CONSOLE=y
> > > CONFIG_VT_CONSOLE_SLEEP=y
> > > CONFIG_HW_CONSOLE=y
> > > CONFIG_VT_HW_CONSOLE_BINDING=y
> > > CONFIG_UNIX98_PTYS=y
> > > CONFIG_LEGACY_PTYS=y
> > > CONFIG_LEGACY_PTY_COUNT=0
> > > CONFIG_SERIAL_NONSTANDARD=y
> > > CONFIG_ROCKETPORT=m
> > > CONFIG_CYCLADES=m
> > > # CONFIG_CYZ_INTR is not set
> > > CONFIG_MOXA_INTELLIO=m
> > > CONFIG_MOXA_SMARTIO=m
> > > CONFIG_SYNCLINK=m
> > > CONFIG_SYNCLINKMP=m
> > > CONFIG_SYNCLINK_GT=m
> > > CONFIG_NOZOMI=m
> > > CONFIG_ISI=m
> > > CONFIG_N_HDLC=m
> > > CONFIG_N_GSM=m
> > > CONFIG_TRACE_ROUTER=m
> > > CONFIG_TRACE_SINK=m
> > > CONFIG_NULL_TTY=m
> > > CONFIG_LDISC_AUTOLOAD=y
> > > CONFIG_DEVMEM=y
> > > # CONFIG_DEVKMEM is not set
> > > 
> > > #
> > > # Serial drivers
> > > #
> > > CONFIG_SERIAL_EARLYCON=y
> > > CONFIG_SERIAL_8250=y
> > > # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> > > CONFIG_SERIAL_8250_PNP=y
> > > CONFIG_SERIAL_8250_FINTEK=y
> > > CONFIG_SERIAL_8250_CONSOLE=y
> > > CONFIG_SERIAL_8250_DMA=y
> > > CONFIG_SERIAL_8250_PCI=y
> > > CONFIG_SERIAL_8250_EXAR=m
> > > CONFIG_SERIAL_8250_CS=m
> > > CONFIG_SERIAL_8250_MEN_MCB=m
> > > CONFIG_SERIAL_8250_NR_UARTS=48
> > > CONFIG_SERIAL_8250_RUNTIME_UARTS=32
> > > CONFIG_SERIAL_8250_EXTENDED=y
> > > CONFIG_SERIAL_8250_MANY_PORTS=y
> > > CONFIG_SERIAL_8250_SHARE_IRQ=y
> > > # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> > > CONFIG_SERIAL_8250_RSA=y
> > > CONFIG_SERIAL_8250_DWLIB=y
> > > CONFIG_SERIAL_8250_DW=m
> > > CONFIG_SERIAL_8250_RT288X=y
> > > CONFIG_SERIAL_8250_LPSS=m
> > > CONFIG_SERIAL_8250_MID=m
> > > 
> > > #
> > > # Non-8250 serial port support
> > > #
> > > CONFIG_SERIAL_KGDB_NMI=y
> > > CONFIG_SERIAL_MAX3100=m
> > > CONFIG_SERIAL_MAX310X=y
> > > CONFIG_SERIAL_UARTLITE=m
> > > CONFIG_SERIAL_UARTLITE_NR_UARTS=1
> > > CONFIG_SERIAL_CORE=y
> > > CONFIG_SERIAL_CORE_CONSOLE=y
> > > CONFIG_CONSOLE_POLL=y
> > > CONFIG_SERIAL_JSM=m
> > > CONFIG_SERIAL_SCCNXP=y
> > > CONFIG_SERIAL_SCCNXP_CONSOLE=y
> > > CONFIG_SERIAL_SC16IS7XX_CORE=m
> > > CONFIG_SERIAL_SC16IS7XX=m
> > > CONFIG_SERIAL_SC16IS7XX_I2C=y
> > > CONFIG_SERIAL_SC16IS7XX_SPI=y
> > > CONFIG_SERIAL_ALTERA_JTAGUART=m
> > > CONFIG_SERIAL_ALTERA_UART=m
> > > CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
> > > CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
> > > # CONFIG_SERIAL_IFX6X60 is not set
> > > CONFIG_SERIAL_ARC=m
> > > CONFIG_SERIAL_ARC_NR_PORTS=1
> > > CONFIG_SERIAL_RP2=m
> > > CONFIG_SERIAL_RP2_NR_UARTS=32
> > > CONFIG_SERIAL_FSL_LPUART=m
> > > # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> > > CONFIG_SERIAL_MEN_Z135=m
> > > # end of Serial drivers
> > > 
> > > CONFIG_SERIAL_MCTRL_GPIO=y
> > > CONFIG_SERIAL_DEV_BUS=y
> > > CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
> > > CONFIG_TTY_PRINTK=y
> > > CONFIG_TTY_PRINTK_LEVEL=6
> > > CONFIG_PRINTER=m
> > > # CONFIG_LP_CONSOLE is not set
> > > CONFIG_PPDEV=m
> > > CONFIG_HVC_DRIVER=y
> > > CONFIG_HVC_IRQ=y
> > > CONFIG_HVC_XEN=y
> > > CONFIG_HVC_XEN_FRONTEND=y
> > > CONFIG_VIRTIO_CONSOLE=y
> > > CONFIG_IPMI_HANDLER=m
> > > CONFIG_IPMI_DMI_DECODE=y
> > > CONFIG_IPMI_PLAT_DATA=y
> > > # CONFIG_IPMI_PANIC_EVENT is not set
> > > CONFIG_IPMI_DEVICE_INTERFACE=m
> > > CONFIG_IPMI_SI=m
> > > CONFIG_IPMI_SSIF=m
> > > CONFIG_IPMI_WATCHDOG=m
> > > CONFIG_IPMI_POWEROFF=m
> > > CONFIG_HW_RANDOM=y
> > > CONFIG_HW_RANDOM_TIMERIOMEM=m
> > > CONFIG_HW_RANDOM_INTEL=m
> > > CONFIG_HW_RANDOM_AMD=m
> > > CONFIG_HW_RANDOM_VIA=m
> > > CONFIG_HW_RANDOM_VIRTIO=m
> > > CONFIG_NVRAM=m
> > > CONFIG_APPLICOM=m
> > > 
> > > #
> > > # PCMCIA character devices
> > > #
> > > CONFIG_SYNCLINK_CS=m
> > > CONFIG_CARDMAN_4000=m
> > > CONFIG_CARDMAN_4040=m
> > > CONFIG_SCR24X=m
> > > CONFIG_IPWIRELESS=m
> > > # end of PCMCIA character devices
> > > 
> > > CONFIG_MWAVE=m
> > > CONFIG_RAW_DRIVER=m
> > > CONFIG_MAX_RAW_DEVS=256
> > > CONFIG_HPET=y
> > > CONFIG_HPET_MMAP=y
> > > CONFIG_HPET_MMAP_DEFAULT=y
> > > CONFIG_HANGCHECK_TIMER=m
> > > CONFIG_TCG_TPM=y
> > > CONFIG_HW_RANDOM_TPM=y
> > > CONFIG_TCG_TIS_CORE=y
> > > CONFIG_TCG_TIS=y
> > > CONFIG_TCG_TIS_SPI=m
> > > # CONFIG_TCG_TIS_SPI_CR50 is not set
> > > CONFIG_TCG_TIS_I2C_ATMEL=m
> > > CONFIG_TCG_TIS_I2C_INFINEON=m
> > > CONFIG_TCG_TIS_I2C_NUVOTON=m
> > > CONFIG_TCG_NSC=m
> > > CONFIG_TCG_ATMEL=m
> > > CONFIG_TCG_INFINEON=m
> > > CONFIG_TCG_XEN=m
> > > CONFIG_TCG_CRB=y
> > > CONFIG_TCG_VTPM_PROXY=m
> > > CONFIG_TCG_TIS_ST33ZP24=m
> > > CONFIG_TCG_TIS_ST33ZP24_I2C=m
> > > CONFIG_TCG_TIS_ST33ZP24_SPI=m
> > > CONFIG_TELCLOCK=m
> > > CONFIG_DEVPORT=y
> > > CONFIG_XILLYBUS=m
> > > CONFIG_XILLYBUS_PCIE=m
> > > # end of Character devices
> > > 
> > > CONFIG_RANDOM_TRUST_CPU=y
> > > # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
> > > 
> > > #
> > > # I2C support
> > > #
> > > CONFIG_I2C=y
> > > CONFIG_ACPI_I2C_OPREGION=y
> > > CONFIG_I2C_BOARDINFO=y
> > > CONFIG_I2C_COMPAT=y
> > > CONFIG_I2C_CHARDEV=y
> > > CONFIG_I2C_MUX=m
> > > 
> > > #
> > > # Multiplexer I2C Chip support
> > > #
> > > CONFIG_I2C_MUX_GPIO=m
> > > CONFIG_I2C_MUX_LTC4306=m
> > > CONFIG_I2C_MUX_PCA9541=m
> > > CONFIG_I2C_MUX_PCA954x=m
> > > CONFIG_I2C_MUX_REG=m
> > > CONFIG_I2C_MUX_MLXCPLD=m
> > > # end of Multiplexer I2C Chip support
> > > 
> > > CONFIG_I2C_HELPER_AUTO=y
> > > CONFIG_I2C_SMBUS=m
> > > CONFIG_I2C_ALGOBIT=m
> > > CONFIG_I2C_ALGOPCA=m
> > > 
> > > #
> > > # I2C Hardware Bus support
> > > #
> > > 
> > > #
> > > # PC SMBus host controller drivers
> > > #
> > > CONFIG_I2C_ALI1535=m
> > > CONFIG_I2C_ALI1563=m
> > > CONFIG_I2C_ALI15X3=m
> > > CONFIG_I2C_AMD756=m
> > > CONFIG_I2C_AMD756_S4882=m
> > > CONFIG_I2C_AMD8111=m
> > > CONFIG_I2C_AMD_MP2=m
> > > CONFIG_I2C_I801=m
> > > CONFIG_I2C_ISCH=m
> > > CONFIG_I2C_ISMT=m
> > > CONFIG_I2C_PIIX4=m
> > > CONFIG_I2C_CHT_WC=m
> > > CONFIG_I2C_NFORCE2=m
> > > CONFIG_I2C_NFORCE2_S4985=m
> > > CONFIG_I2C_NVIDIA_GPU=m
> > > CONFIG_I2C_SIS5595=m
> > > CONFIG_I2C_SIS630=m
> > > CONFIG_I2C_SIS96X=m
> > > CONFIG_I2C_VIA=m
> > > CONFIG_I2C_VIAPRO=m
> > > 
> > > #
> > > # ACPI drivers
> > > #
> > > CONFIG_I2C_SCMI=m
> > > 
> > > #
> > > # I2C system bus drivers (mostly embedded / system-on-chip)
> > > #
> > > CONFIG_I2C_CBUS_GPIO=m
> > > CONFIG_I2C_DESIGNWARE_CORE=y
> > > CONFIG_I2C_DESIGNWARE_PLATFORM=y
> > > # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> > > CONFIG_I2C_DESIGNWARE_PCI=m
> > > CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
> > > # CONFIG_I2C_EMEV2 is not set
> > > CONFIG_I2C_GPIO=m
> > > # CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
> > > CONFIG_I2C_KEMPLD=m
> > > CONFIG_I2C_OCORES=m
> > > CONFIG_I2C_PCA_PLATFORM=m
> > > CONFIG_I2C_SIMTEC=m
> > > CONFIG_I2C_XILINX=m
> > > 
> > > #
> > > # External I2C/SMBus adapter drivers
> > > #
> > > CONFIG_I2C_DIOLAN_U2C=m
> > > CONFIG_I2C_DLN2=m
> > > CONFIG_I2C_PARPORT=m
> > > CONFIG_I2C_PARPORT_LIGHT=m
> > > CONFIG_I2C_ROBOTFUZZ_OSIF=m
> > > CONFIG_I2C_TAOS_EVM=m
> > > CONFIG_I2C_TINY_USB=m
> > > CONFIG_I2C_VIPERBOARD=m
> > > 
> > > #
> > > # Other I2C/SMBus bus drivers
> > > #
> > > CONFIG_I2C_MLXCPLD=m
> > > CONFIG_I2C_CROS_EC_TUNNEL=m
> > > # end of I2C Hardware Bus support
> > > 
> > > CONFIG_I2C_STUB=m
> > > # CONFIG_I2C_SLAVE is not set
> > > # CONFIG_I2C_DEBUG_CORE is not set
> > > # CONFIG_I2C_DEBUG_ALGO is not set
> > > # CONFIG_I2C_DEBUG_BUS is not set
> > > # end of I2C support
> > > 
> > > CONFIG_I3C=m
> > > CONFIG_CDNS_I3C_MASTER=m
> > > CONFIG_DW_I3C_MASTER=m
> > > CONFIG_SPI=y
> > > # CONFIG_SPI_DEBUG is not set
> > > CONFIG_SPI_MASTER=y
> > > CONFIG_SPI_MEM=y
> > > 
> > > #
> > > # SPI Master Controller Drivers
> > > #
> > > CONFIG_SPI_ALTERA=m
> > > CONFIG_SPI_AXI_SPI_ENGINE=m
> > > CONFIG_SPI_BITBANG=m
> > > CONFIG_SPI_BUTTERFLY=m
> > > CONFIG_SPI_CADENCE=m
> > > CONFIG_SPI_DESIGNWARE=m
> > > CONFIG_SPI_DW_PCI=m
> > > CONFIG_SPI_DW_MID_DMA=y
> > > CONFIG_SPI_DW_MMIO=m
> > > CONFIG_SPI_DLN2=m
> > > CONFIG_SPI_NXP_FLEXSPI=m
> > > CONFIG_SPI_GPIO=m
> > > CONFIG_SPI_LM70_LLP=m
> > > CONFIG_SPI_OC_TINY=m
> > > CONFIG_SPI_PXA2XX=m
> > > CONFIG_SPI_PXA2XX_PCI=m
> > > # CONFIG_SPI_ROCKCHIP is not set
> > > CONFIG_SPI_SC18IS602=m
> > > CONFIG_SPI_SIFIVE=m
> > > CONFIG_SPI_MXIC=m
> > > CONFIG_SPI_XCOMM=m
> > > # CONFIG_SPI_XILINX is not set
> > > CONFIG_SPI_ZYNQMP_GQSPI=m
> > > 
> > > #
> > > # SPI Protocol Masters
> > > #
> > > CONFIG_SPI_SPIDEV=m
> > > CONFIG_SPI_LOOPBACK_TEST=m
> > > CONFIG_SPI_TLE62X0=m
> > > CONFIG_SPI_SLAVE=y
> > > CONFIG_SPI_SLAVE_TIME=m
> > > CONFIG_SPI_SLAVE_SYSTEM_CONTROL=m
> > > CONFIG_SPMI=m
> > > CONFIG_HSI=m
> > > CONFIG_HSI_BOARDINFO=y
> > > 
> > > #
> > > # HSI controllers
> > > #
> > > 
> > > #
> > > # HSI clients
> > > #
> > > CONFIG_HSI_CHAR=m
> > > CONFIG_PPS=y
> > > # CONFIG_PPS_DEBUG is not set
> > > 
> > > #
> > > # PPS clients support
> > > #
> > > # CONFIG_PPS_CLIENT_KTIMER is not set
> > > CONFIG_PPS_CLIENT_LDISC=m
> > > CONFIG_PPS_CLIENT_PARPORT=m
> > > CONFIG_PPS_CLIENT_GPIO=m
> > > 
> > > #
> > > # PPS generators support
> > > #
> > > 
> > > #
> > > # PTP clock support
> > > #
> > > CONFIG_PTP_1588_CLOCK=y
> > > CONFIG_DP83640_PHY=m
> > > CONFIG_PTP_1588_CLOCK_KVM=m
> > > # CONFIG_PTP_1588_CLOCK_IDTCM is not set
> > > # end of PTP clock support
> > > 
> > > CONFIG_PINCTRL=y
> > > CONFIG_PINMUX=y
> > > CONFIG_PINCONF=y
> > > CONFIG_GENERIC_PINCONF=y
> > > # CONFIG_DEBUG_PINCTRL is not set
> > > CONFIG_PINCTRL_AMD=y
> > > CONFIG_PINCTRL_MCP23S08=m
> > > CONFIG_PINCTRL_SX150X=y
> > > CONFIG_PINCTRL_BAYTRAIL=y
> > > CONFIG_PINCTRL_CHERRYVIEW=y
> > > CONFIG_PINCTRL_INTEL=m
> > > CONFIG_PINCTRL_BROXTON=m
> > > CONFIG_PINCTRL_CANNONLAKE=m
> > > CONFIG_PINCTRL_CEDARFORK=m
> > > CONFIG_PINCTRL_DENVERTON=m
> > > CONFIG_PINCTRL_GEMINILAKE=m
> > > CONFIG_PINCTRL_ICELAKE=m
> > > CONFIG_PINCTRL_LEWISBURG=m
> > > CONFIG_PINCTRL_SUNRISEPOINT=m
> > > # CONFIG_PINCTRL_TIGERLAKE is not set
> > > CONFIG_PINCTRL_MADERA=m
> > > CONFIG_PINCTRL_CS47L15=y
> > > CONFIG_PINCTRL_CS47L35=y
> > > CONFIG_PINCTRL_CS47L85=y
> > > CONFIG_PINCTRL_CS47L90=y
> > > CONFIG_PINCTRL_CS47L92=y
> > > # CONFIG_PINCTRL_EQUILIBRIUM is not set
> > > CONFIG_GPIOLIB=y
> > > CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> > > CONFIG_GPIO_ACPI=y
> > > CONFIG_GPIOLIB_IRQCHIP=y
> > > # CONFIG_DEBUG_GPIO is not set
> > > CONFIG_GPIO_SYSFS=y
> > > CONFIG_GPIO_GENERIC=m
> > > CONFIG_GPIO_MAX730X=m
> > > 
> > > #
> > > # Memory mapped GPIO drivers
> > > #
> > > CONFIG_GPIO_AMDPT=m
> > > CONFIG_GPIO_DWAPB=m
> > > CONFIG_GPIO_EXAR=m
> > > CONFIG_GPIO_GENERIC_PLATFORM=m
> > > CONFIG_GPIO_ICH=m
> > > CONFIG_GPIO_LYNXPOINT=y
> > > CONFIG_GPIO_MB86S7X=m
> > > CONFIG_GPIO_MENZ127=m
> > > CONFIG_GPIO_SIOX=m
> > > CONFIG_GPIO_VX855=m
> > > CONFIG_GPIO_XILINX=y
> > > CONFIG_GPIO_AMD_FCH=m
> > > # end of Memory mapped GPIO drivers
> > > 
> > > #
> > > # Port-mapped I/O GPIO drivers
> > > #
> > > CONFIG_GPIO_104_DIO_48E=m
> > > CONFIG_GPIO_104_IDIO_16=m
> > > CONFIG_GPIO_104_IDI_48=m
> > > CONFIG_GPIO_F7188X=m
> > > CONFIG_GPIO_GPIO_MM=m
> > > CONFIG_GPIO_IT87=m
> > > CONFIG_GPIO_SCH=m
> > > CONFIG_GPIO_SCH311X=m
> > > CONFIG_GPIO_WINBOND=m
> > > CONFIG_GPIO_WS16C48=m
> > > # end of Port-mapped I/O GPIO drivers
> > > 
> > > #
> > > # I2C GPIO expanders
> > > #
> > > CONFIG_GPIO_ADP5588=m
> > > CONFIG_GPIO_MAX7300=m
> > > CONFIG_GPIO_MAX732X=m
> > > CONFIG_GPIO_PCA953X=m
> > > CONFIG_GPIO_PCF857X=m
> > > CONFIG_GPIO_TPIC2810=m
> > > # end of I2C GPIO expanders
> > > 
> > > #
> > > # MFD GPIO expanders
> > > #
> > > CONFIG_GPIO_ADP5520=m
> > > CONFIG_GPIO_ARIZONA=m
> > > CONFIG_GPIO_BD9571MWV=m
> > > CONFIG_GPIO_CRYSTAL_COVE=m
> > > CONFIG_GPIO_DA9052=m
> > > CONFIG_GPIO_DA9055=m
> > > CONFIG_GPIO_DLN2=m
> > > CONFIG_GPIO_JANZ_TTL=m
> > > CONFIG_GPIO_KEMPLD=m
> > > CONFIG_GPIO_LP3943=m
> > > CONFIG_GPIO_LP873X=m
> > > CONFIG_GPIO_MADERA=m
> > > CONFIG_GPIO_PALMAS=y
> > > CONFIG_GPIO_RC5T583=y
> > > CONFIG_GPIO_TPS65086=m
> > > CONFIG_GPIO_TPS6586X=y
> > > CONFIG_GPIO_TPS65910=y
> > > CONFIG_GPIO_TPS65912=m
> > > CONFIG_GPIO_TPS68470=y
> > > CONFIG_GPIO_TQMX86=m
> > > CONFIG_GPIO_TWL4030=m
> > > CONFIG_GPIO_TWL6040=m
> > > CONFIG_GPIO_UCB1400=m
> > > CONFIG_GPIO_WHISKEY_COVE=m
> > > CONFIG_GPIO_WM831X=m
> > > CONFIG_GPIO_WM8350=m
> > > CONFIG_GPIO_WM8994=m
> > > # end of MFD GPIO expanders
> > > 
> > > #
> > > # PCI GPIO expanders
> > > #
> > > CONFIG_GPIO_AMD8111=m
> > > CONFIG_GPIO_ML_IOH=m
> > > CONFIG_GPIO_PCI_IDIO_16=m
> > > CONFIG_GPIO_PCIE_IDIO_24=m
> > > CONFIG_GPIO_RDC321X=m
> > > # end of PCI GPIO expanders
> > > 
> > > #
> > > # SPI GPIO expanders
> > > #
> > > CONFIG_GPIO_MAX3191X=m
> > > CONFIG_GPIO_MAX7301=m
> > > CONFIG_GPIO_MC33880=m
> > > CONFIG_GPIO_PISOSR=m
> > > CONFIG_GPIO_XRA1403=m
> > > # end of SPI GPIO expanders
> > > 
> > > #
> > > # USB GPIO expanders
> > > #
> > > CONFIG_GPIO_VIPERBOARD=m
> > > # end of USB GPIO expanders
> > > 
> > > # CONFIG_GPIO_MOCKUP is not set
> > > CONFIG_W1=m
> > > CONFIG_W1_CON=y
> > > 
> > > #
> > > # 1-wire Bus Masters
> > > #
> > > CONFIG_W1_MASTER_MATROX=m
> > > CONFIG_W1_MASTER_DS2490=m
> > > CONFIG_W1_MASTER_DS2482=m
> > > CONFIG_W1_MASTER_DS1WM=m
> > > CONFIG_W1_MASTER_GPIO=m
> > > # CONFIG_W1_MASTER_SGI is not set
> > > # end of 1-wire Bus Masters
> > > 
> > > #
> > > # 1-wire Slaves
> > > #
> > > CONFIG_W1_SLAVE_THERM=m
> > > CONFIG_W1_SLAVE_SMEM=m
> > > CONFIG_W1_SLAVE_DS2405=m
> > > CONFIG_W1_SLAVE_DS2408=m
> > > CONFIG_W1_SLAVE_DS2408_READBACK=y
> > > CONFIG_W1_SLAVE_DS2413=m
> > > CONFIG_W1_SLAVE_DS2406=m
> > > CONFIG_W1_SLAVE_DS2423=m
> > > CONFIG_W1_SLAVE_DS2805=m
> > > # CONFIG_W1_SLAVE_DS2430 is not set
> > > CONFIG_W1_SLAVE_DS2431=m
> > > CONFIG_W1_SLAVE_DS2433=m
> > > # CONFIG_W1_SLAVE_DS2433_CRC is not set
> > > CONFIG_W1_SLAVE_DS2438=m
> > > # CONFIG_W1_SLAVE_DS250X is not set
> > > CONFIG_W1_SLAVE_DS2780=m
> > > CONFIG_W1_SLAVE_DS2781=m
> > > CONFIG_W1_SLAVE_DS28E04=m
> > > CONFIG_W1_SLAVE_DS28E17=m
> > > # end of 1-wire Slaves
> > > 
> > > CONFIG_POWER_AVS=y
> > > CONFIG_POWER_RESET=y
> > > # CONFIG_POWER_RESET_MT6323 is not set
> > > CONFIG_POWER_RESET_RESTART=y
> > > CONFIG_POWER_SUPPLY=y
> > > # CONFIG_POWER_SUPPLY_DEBUG is not set
> > > CONFIG_POWER_SUPPLY_HWMON=y
> > > CONFIG_PDA_POWER=m
> > > CONFIG_GENERIC_ADC_BATTERY=m
> > > CONFIG_MAX8925_POWER=m
> > > CONFIG_WM831X_BACKUP=m
> > > CONFIG_WM831X_POWER=m
> > > CONFIG_WM8350_POWER=m
> > > CONFIG_TEST_POWER=m
> > > CONFIG_BATTERY_88PM860X=m
> > > CONFIG_CHARGER_ADP5061=m
> > > CONFIG_BATTERY_DS2760=m
> > > CONFIG_BATTERY_DS2780=m
> > > CONFIG_BATTERY_DS2781=m
> > > CONFIG_BATTERY_DS2782=m
> > > CONFIG_BATTERY_SBS=m
> > > CONFIG_CHARGER_SBS=m
> > > CONFIG_MANAGER_SBS=m
> > > CONFIG_BATTERY_BQ27XXX=m
> > > CONFIG_BATTERY_BQ27XXX_I2C=m
> > > CONFIG_BATTERY_BQ27XXX_HDQ=m
> > > # CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
> > > CONFIG_BATTERY_DA9030=m
> > > CONFIG_BATTERY_DA9052=m
> > > CONFIG_CHARGER_DA9150=m
> > > CONFIG_BATTERY_DA9150=m
> > > CONFIG_CHARGER_AXP20X=m
> > > CONFIG_BATTERY_AXP20X=m
> > > CONFIG_AXP20X_POWER=m
> > > CONFIG_AXP288_CHARGER=m
> > > CONFIG_AXP288_FUEL_GAUGE=m
> > > CONFIG_BATTERY_MAX17040=m
> > > CONFIG_BATTERY_MAX17042=m
> > > CONFIG_BATTERY_MAX1721X=m
> > > CONFIG_BATTERY_TWL4030_MADC=m
> > > CONFIG_CHARGER_88PM860X=m
> > > CONFIG_CHARGER_PCF50633=m
> > > CONFIG_BATTERY_RX51=m
> > > CONFIG_CHARGER_ISP1704=m
> > > CONFIG_CHARGER_MAX8903=m
> > > CONFIG_CHARGER_TWL4030=m
> > > CONFIG_CHARGER_LP8727=m
> > > CONFIG_CHARGER_LP8788=m
> > > CONFIG_CHARGER_GPIO=m
> > > CONFIG_CHARGER_MANAGER=y
> > > CONFIG_CHARGER_LT3651=m
> > > CONFIG_CHARGER_MAX14577=m
> > > CONFIG_CHARGER_MAX77693=m
> > > CONFIG_CHARGER_MAX8997=m
> > > CONFIG_CHARGER_MAX8998=m
> > > CONFIG_CHARGER_BQ2415X=m
> > > CONFIG_CHARGER_BQ24190=m
> > > CONFIG_CHARGER_BQ24257=m
> > > CONFIG_CHARGER_BQ24735=m
> > > CONFIG_CHARGER_BQ25890=m
> > > CONFIG_CHARGER_SMB347=m
> > > CONFIG_CHARGER_TPS65090=m
> > > CONFIG_BATTERY_GAUGE_LTC2941=m
> > > CONFIG_BATTERY_RT5033=m
> > > CONFIG_CHARGER_RT9455=m
> > > CONFIG_CHARGER_CROS_USBPD=m
> > > CONFIG_CHARGER_WILCO=m
> > > CONFIG_HWMON=y
> > > CONFIG_HWMON_VID=m
> > > # CONFIG_HWMON_DEBUG_CHIP is not set
> > > 
> > > #
> > > # Native drivers
> > > #
> > > CONFIG_SENSORS_ABITUGURU=m
> > > CONFIG_SENSORS_ABITUGURU3=m
> > > CONFIG_SENSORS_AD7314=m
> > > CONFIG_SENSORS_AD7414=m
> > > CONFIG_SENSORS_AD7418=m
> > > CONFIG_SENSORS_ADM1021=m
> > > CONFIG_SENSORS_ADM1025=m
> > > CONFIG_SENSORS_ADM1026=m
> > > CONFIG_SENSORS_ADM1029=m
> > > CONFIG_SENSORS_ADM1031=m
> > > CONFIG_SENSORS_ADM9240=m
> > > CONFIG_SENSORS_ADT7X10=m
> > > CONFIG_SENSORS_ADT7310=m
> > > CONFIG_SENSORS_ADT7410=m
> > > CONFIG_SENSORS_ADT7411=m
> > > CONFIG_SENSORS_ADT7462=m
> > > CONFIG_SENSORS_ADT7470=m
> > > CONFIG_SENSORS_ADT7475=m
> > > # CONFIG_SENSORS_AS370 is not set
> > > CONFIG_SENSORS_ASC7621=m
> > > CONFIG_SENSORS_K8TEMP=m
> > > CONFIG_SENSORS_K10TEMP=m
> > > CONFIG_SENSORS_FAM15H_POWER=m
> > > CONFIG_SENSORS_APPLESMC=m
> > > CONFIG_SENSORS_ASB100=m
> > > CONFIG_SENSORS_ASPEED=m
> > > CONFIG_SENSORS_ATXP1=m
> > > CONFIG_SENSORS_DS620=m
> > > CONFIG_SENSORS_DS1621=m
> > > CONFIG_SENSORS_DELL_SMM=m
> > > CONFIG_SENSORS_DA9052_ADC=m
> > > CONFIG_SENSORS_DA9055=m
> > > CONFIG_SENSORS_I5K_AMB=m
> > > CONFIG_SENSORS_F71805F=m
> > > CONFIG_SENSORS_F71882FG=m
> > > CONFIG_SENSORS_F75375S=m
> > > CONFIG_SENSORS_MC13783_ADC=m
> > > CONFIG_SENSORS_FSCHMD=m
> > > CONFIG_SENSORS_FTSTEUTATES=m
> > > CONFIG_SENSORS_GL518SM=m
> > > CONFIG_SENSORS_GL520SM=m
> > > CONFIG_SENSORS_G760A=m
> > > CONFIG_SENSORS_G762=m
> > > CONFIG_SENSORS_HIH6130=m
> > > CONFIG_SENSORS_IBMAEM=m
> > > CONFIG_SENSORS_IBMPEX=m
> > > CONFIG_SENSORS_IIO_HWMON=m
> > > CONFIG_SENSORS_I5500=m
> > > CONFIG_SENSORS_CORETEMP=m
> > > CONFIG_SENSORS_IT87=m
> > > CONFIG_SENSORS_JC42=m
> > > CONFIG_SENSORS_POWR1220=m
> > > CONFIG_SENSORS_LINEAGE=m
> > > CONFIG_SENSORS_LTC2945=m
> > > # CONFIG_SENSORS_LTC2947_I2C is not set
> > > # CONFIG_SENSORS_LTC2947_SPI is not set
> > > CONFIG_SENSORS_LTC2990=m
> > > CONFIG_SENSORS_LTC4151=m
> > > CONFIG_SENSORS_LTC4215=m
> > > CONFIG_SENSORS_LTC4222=m
> > > CONFIG_SENSORS_LTC4245=m
> > > CONFIG_SENSORS_LTC4260=m
> > > CONFIG_SENSORS_LTC4261=m
> > > CONFIG_SENSORS_MAX1111=m
> > > CONFIG_SENSORS_MAX16065=m
> > > CONFIG_SENSORS_MAX1619=m
> > > CONFIG_SENSORS_MAX1668=m
> > > CONFIG_SENSORS_MAX197=m
> > > CONFIG_SENSORS_MAX31722=m
> > > CONFIG_SENSORS_MAX6621=m
> > > CONFIG_SENSORS_MAX6639=m
> > > CONFIG_SENSORS_MAX6642=m
> > > CONFIG_SENSORS_MAX6650=m
> > > CONFIG_SENSORS_MAX6697=m
> > > CONFIG_SENSORS_MAX31790=m
> > > CONFIG_SENSORS_MCP3021=m
> > > CONFIG_SENSORS_MLXREG_FAN=m
> > > CONFIG_SENSORS_TC654=m
> > > CONFIG_SENSORS_MENF21BMC_HWMON=m
> > > CONFIG_SENSORS_ADCXX=m
> > > CONFIG_SENSORS_LM63=m
> > > CONFIG_SENSORS_LM70=m
> > > CONFIG_SENSORS_LM73=m
> > > CONFIG_SENSORS_LM75=m
> > > CONFIG_SENSORS_LM77=m
> > > CONFIG_SENSORS_LM78=m
> > > CONFIG_SENSORS_LM80=m
> > > CONFIG_SENSORS_LM83=m
> > > CONFIG_SENSORS_LM85=m
> > > CONFIG_SENSORS_LM87=m
> > > CONFIG_SENSORS_LM90=m
> > > CONFIG_SENSORS_LM92=m
> > > CONFIG_SENSORS_LM93=m
> > > CONFIG_SENSORS_LM95234=m
> > > CONFIG_SENSORS_LM95241=m
> > > CONFIG_SENSORS_LM95245=m
> > > CONFIG_SENSORS_PC87360=m
> > > CONFIG_SENSORS_PC87427=m
> > > CONFIG_SENSORS_NTC_THERMISTOR=m
> > > CONFIG_SENSORS_NCT6683=m
> > > CONFIG_SENSORS_NCT6775=m
> > > CONFIG_SENSORS_NCT7802=m
> > > CONFIG_SENSORS_NCT7904=m
> > > CONFIG_SENSORS_NPCM7XX=m
> > > CONFIG_SENSORS_PCF8591=m
> > > CONFIG_PMBUS=m
> > > CONFIG_SENSORS_PMBUS=m
> > > CONFIG_SENSORS_ADM1275=m
> > > # CONFIG_SENSORS_BEL_PFE is not set
> > > CONFIG_SENSORS_IBM_CFFPS=m
> > > # CONFIG_SENSORS_INSPUR_IPSPS is not set
> > > CONFIG_SENSORS_IR35221=m
> > > CONFIG_SENSORS_IR38064=m
> > > CONFIG_SENSORS_IRPS5401=m
> > > CONFIG_SENSORS_ISL68137=m
> > > CONFIG_SENSORS_LM25066=m
> > > CONFIG_SENSORS_LTC2978=m
> > > CONFIG_SENSORS_LTC2978_REGULATOR=y
> > > CONFIG_SENSORS_LTC3815=m
> > > CONFIG_SENSORS_MAX16064=m
> > > CONFIG_SENSORS_MAX20751=m
> > > CONFIG_SENSORS_MAX31785=m
> > > CONFIG_SENSORS_MAX34440=m
> > > CONFIG_SENSORS_MAX8688=m
> > > CONFIG_SENSORS_PXE1610=m
> > > CONFIG_SENSORS_TPS40422=m
> > > CONFIG_SENSORS_TPS53679=m
> > > CONFIG_SENSORS_UCD9000=m
> > > CONFIG_SENSORS_UCD9200=m
> > > CONFIG_SENSORS_ZL6100=m
> > > CONFIG_SENSORS_SHT15=m
> > > CONFIG_SENSORS_SHT21=m
> > > CONFIG_SENSORS_SHT3x=m
> > > CONFIG_SENSORS_SHTC1=m
> > > CONFIG_SENSORS_SIS5595=m
> > > CONFIG_SENSORS_DME1737=m
> > > CONFIG_SENSORS_EMC1403=m
> > > CONFIG_SENSORS_EMC2103=m
> > > CONFIG_SENSORS_EMC6W201=m
> > > CONFIG_SENSORS_SMSC47M1=m
> > > CONFIG_SENSORS_SMSC47M192=m
> > > CONFIG_SENSORS_SMSC47B397=m
> > > CONFIG_SENSORS_SCH56XX_COMMON=m
> > > CONFIG_SENSORS_SCH5627=m
> > > CONFIG_SENSORS_SCH5636=m
> > > CONFIG_SENSORS_STTS751=m
> > > CONFIG_SENSORS_SMM665=m
> > > CONFIG_SENSORS_ADC128D818=m
> > > CONFIG_SENSORS_ADS7828=m
> > > CONFIG_SENSORS_ADS7871=m
> > > CONFIG_SENSORS_AMC6821=m
> > > CONFIG_SENSORS_INA209=m
> > > CONFIG_SENSORS_INA2XX=m
> > > CONFIG_SENSORS_INA3221=m
> > > CONFIG_SENSORS_TC74=m
> > > CONFIG_SENSORS_THMC50=m
> > > CONFIG_SENSORS_TMP102=m
> > > CONFIG_SENSORS_TMP103=m
> > > CONFIG_SENSORS_TMP108=m
> > > CONFIG_SENSORS_TMP401=m
> > > CONFIG_SENSORS_TMP421=m
> > > # CONFIG_SENSORS_TMP513 is not set
> > > CONFIG_SENSORS_VIA_CPUTEMP=m
> > > CONFIG_SENSORS_VIA686A=m
> > > CONFIG_SENSORS_VT1211=m
> > > CONFIG_SENSORS_VT8231=m
> > > CONFIG_SENSORS_W83773G=m
> > > CONFIG_SENSORS_W83781D=m
> > > CONFIG_SENSORS_W83791D=m
> > > CONFIG_SENSORS_W83792D=m
> > > CONFIG_SENSORS_W83793=m
> > > CONFIG_SENSORS_W83795=m
> > > # CONFIG_SENSORS_W83795_FANCTRL is not set
> > > CONFIG_SENSORS_W83L785TS=m
> > > CONFIG_SENSORS_W83L786NG=m
> > > CONFIG_SENSORS_W83627HF=m
> > > CONFIG_SENSORS_W83627EHF=m
> > > CONFIG_SENSORS_WM831X=m
> > > CONFIG_SENSORS_WM8350=m
> > > CONFIG_SENSORS_XGENE=m
> > > 
> > > #
> > > # ACPI drivers
> > > #
> > > CONFIG_SENSORS_ACPI_POWER=m
> > > CONFIG_SENSORS_ATK0110=m
> > > CONFIG_THERMAL=y
> > > CONFIG_THERMAL_STATISTICS=y
> > > CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> > > CONFIG_THERMAL_HWMON=y
> > > CONFIG_THERMAL_WRITABLE_TRIPS=y
> > > CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> > > # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> > > # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> > > # CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
> > > CONFIG_THERMAL_GOV_FAIR_SHARE=y
> > > CONFIG_THERMAL_GOV_STEP_WISE=y
> > > CONFIG_THERMAL_GOV_BANG_BANG=y
> > > CONFIG_THERMAL_GOV_USER_SPACE=y
> > > CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
> > > # CONFIG_CLOCK_THERMAL is not set
> > > CONFIG_DEVFREQ_THERMAL=y
> > > CONFIG_THERMAL_EMULATION=y
> > > 
> > > #
> > > # Intel thermal drivers
> > > #
> > > CONFIG_INTEL_POWERCLAMP=m
> > > CONFIG_X86_PKG_TEMP_THERMAL=m
> > > CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
> > > CONFIG_INTEL_SOC_DTS_THERMAL=m
> > > 
> > > #
> > > # ACPI INT340X thermal drivers
> > > #
> > > CONFIG_INT340X_THERMAL=m
> > > CONFIG_ACPI_THERMAL_REL=m
> > > CONFIG_INT3406_THERMAL=m
> > > CONFIG_PROC_THERMAL_MMIO_RAPL=y
> > > # end of ACPI INT340X thermal drivers
> > > 
> > > CONFIG_INTEL_BXT_PMIC_THERMAL=m
> > > CONFIG_INTEL_PCH_THERMAL=m
> > > # end of Intel thermal drivers
> > > 
> > > CONFIG_GENERIC_ADC_THERMAL=m
> > > CONFIG_WATCHDOG=y
> > > CONFIG_WATCHDOG_CORE=y
> > > # CONFIG_WATCHDOG_NOWAYOUT is not set
> > > CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
> > > CONFIG_WATCHDOG_OPEN_TIMEOUT=0
> > > CONFIG_WATCHDOG_SYSFS=y
> > > 
> > > #
> > > # Watchdog Pretimeout Governors
> > > #
> > > CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
> > > CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
> > > CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
> > > CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=m
> > > CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
> > > # CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set
> > > 
> > > #
> > > # Watchdog Device Drivers
> > > #
> > > CONFIG_SOFT_WATCHDOG=m
> > > CONFIG_SOFT_WATCHDOG_PRETIMEOUT=y
> > > CONFIG_DA9052_WATCHDOG=m
> > > CONFIG_DA9055_WATCHDOG=m
> > > CONFIG_DA9063_WATCHDOG=m
> > > CONFIG_DA9062_WATCHDOG=m
> > > CONFIG_MENF21BMC_WATCHDOG=m
> > > CONFIG_MENZ069_WATCHDOG=m
> > > CONFIG_WDAT_WDT=m
> > > CONFIG_WM831X_WATCHDOG=m
> > > CONFIG_WM8350_WATCHDOG=m
> > > CONFIG_XILINX_WATCHDOG=m
> > > CONFIG_ZIIRAVE_WATCHDOG=m
> > > CONFIG_RAVE_SP_WATCHDOG=m
> > > CONFIG_MLX_WDT=m
> > > CONFIG_CADENCE_WATCHDOG=m
> > > CONFIG_DW_WATCHDOG=m
> > > CONFIG_TWL4030_WATCHDOG=m
> > > CONFIG_MAX63XX_WATCHDOG=m
> > > CONFIG_RETU_WATCHDOG=m
> > > CONFIG_ACQUIRE_WDT=m
> > > CONFIG_ADVANTECH_WDT=m
> > > CONFIG_ALIM1535_WDT=m
> > > CONFIG_ALIM7101_WDT=m
> > > CONFIG_EBC_C384_WDT=m
> > > CONFIG_F71808E_WDT=m
> > > CONFIG_SP5100_TCO=m
> > > CONFIG_SBC_FITPC2_WATCHDOG=m
> > > CONFIG_EUROTECH_WDT=m
> > > CONFIG_IB700_WDT=m
> > > CONFIG_IBMASR=m
> > > CONFIG_WAFER_WDT=m
> > > CONFIG_I6300ESB_WDT=m
> > > CONFIG_IE6XX_WDT=m
> > > CONFIG_ITCO_WDT=m
> > > CONFIG_ITCO_VENDOR_SUPPORT=y
> > > CONFIG_IT8712F_WDT=m
> > > CONFIG_IT87_WDT=m
> > > CONFIG_HP_WATCHDOG=m
> > > CONFIG_HPWDT_NMI_DECODING=y
> > > CONFIG_KEMPLD_WDT=m
> > > CONFIG_SC1200_WDT=m
> > > CONFIG_PC87413_WDT=m
> > > CONFIG_NV_TCO=m
> > > CONFIG_60XX_WDT=m
> > > CONFIG_CPU5_WDT=m
> > > CONFIG_SMSC_SCH311X_WDT=m
> > > CONFIG_SMSC37B787_WDT=m
> > > CONFIG_TQMX86_WDT=m
> > > CONFIG_VIA_WDT=m
> > > CONFIG_W83627HF_WDT=m
> > > CONFIG_W83877F_WDT=m
> > > CONFIG_W83977F_WDT=m
> > > CONFIG_MACHZ_WDT=m
> > > CONFIG_SBC_EPX_C3_WATCHDOG=m
> > > CONFIG_INTEL_MEI_WDT=m
> > > CONFIG_NI903X_WDT=m
> > > CONFIG_NIC7018_WDT=m
> > > CONFIG_MEN_A21_WDT=m
> > > CONFIG_XEN_WDT=m
> > > 
> > > #
> > > # PCI-based Watchdog Cards
> > > #
> > > CONFIG_PCIPCWATCHDOG=m
> > > CONFIG_WDTPCI=m
> > > 
> > > #
> > > # USB-based Watchdog Cards
> > > #
> > > CONFIG_USBPCWATCHDOG=m
> > > CONFIG_SSB_POSSIBLE=y
> > > CONFIG_SSB=m
> > > CONFIG_SSB_SPROM=y
> > > CONFIG_SSB_BLOCKIO=y
> > > CONFIG_SSB_PCIHOST_POSSIBLE=y
> > > CONFIG_SSB_PCIHOST=y
> > > CONFIG_SSB_B43_PCI_BRIDGE=y
> > > CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
> > > # CONFIG_SSB_PCMCIAHOST is not set
> > > CONFIG_SSB_SDIOHOST_POSSIBLE=y
> > > CONFIG_SSB_SDIOHOST=y
> > > CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
> > > CONFIG_SSB_DRIVER_PCICORE=y
> > > CONFIG_SSB_DRIVER_GPIO=y
> > > CONFIG_BCMA_POSSIBLE=y
> > > CONFIG_BCMA=m
> > > CONFIG_BCMA_BLOCKIO=y
> > > CONFIG_BCMA_HOST_PCI_POSSIBLE=y
> > > CONFIG_BCMA_HOST_PCI=y
> > > CONFIG_BCMA_HOST_SOC=y
> > > CONFIG_BCMA_DRIVER_PCI=y
> > > CONFIG_BCMA_SFLASH=y
> > > CONFIG_BCMA_DRIVER_GMAC_CMN=y
> > > CONFIG_BCMA_DRIVER_GPIO=y
> > > # CONFIG_BCMA_DEBUG is not set
> > > 
> > > #
> > > # Multifunction device drivers
> > > #
> > > CONFIG_MFD_CORE=y
> > > CONFIG_MFD_AS3711=y
> > > CONFIG_PMIC_ADP5520=y
> > > CONFIG_MFD_AAT2870_CORE=y
> > > CONFIG_MFD_BCM590XX=m
> > > CONFIG_MFD_BD9571MWV=m
> > > CONFIG_MFD_AXP20X=m
> > > CONFIG_MFD_AXP20X_I2C=m
> > > CONFIG_MFD_CROS_EC_DEV=m
> > > CONFIG_MFD_MADERA=m
> > > CONFIG_MFD_MADERA_I2C=m
> > > CONFIG_MFD_MADERA_SPI=m
> > > CONFIG_MFD_CS47L15=y
> > > CONFIG_MFD_CS47L35=y
> > > CONFIG_MFD_CS47L85=y
> > > CONFIG_MFD_CS47L90=y
> > > CONFIG_MFD_CS47L92=y
> > > CONFIG_PMIC_DA903X=y
> > > CONFIG_PMIC_DA9052=y
> > > CONFIG_MFD_DA9052_SPI=y
> > > CONFIG_MFD_DA9052_I2C=y
> > > CONFIG_MFD_DA9055=y
> > > CONFIG_MFD_DA9062=m
> > > CONFIG_MFD_DA9063=y
> > > CONFIG_MFD_DA9150=m
> > > CONFIG_MFD_DLN2=m
> > > CONFIG_MFD_MC13XXX=m
> > > CONFIG_MFD_MC13XXX_SPI=m
> > > CONFIG_MFD_MC13XXX_I2C=m
> > > CONFIG_HTC_PASIC3=m
> > > CONFIG_HTC_I2CPLD=y
> > > CONFIG_MFD_INTEL_QUARK_I2C_GPIO=m
> > > CONFIG_LPC_ICH=m
> > > CONFIG_LPC_SCH=m
> > > CONFIG_INTEL_SOC_PMIC=y
> > > CONFIG_INTEL_SOC_PMIC_BXTWC=m
> > > CONFIG_INTEL_SOC_PMIC_CHTWC=y
> > > CONFIG_INTEL_SOC_PMIC_CHTDC_TI=m
> > > CONFIG_MFD_INTEL_LPSS=m
> > > CONFIG_MFD_INTEL_LPSS_ACPI=m
> > > CONFIG_MFD_INTEL_LPSS_PCI=m
> > > CONFIG_MFD_JANZ_CMODIO=m
> > > CONFIG_MFD_KEMPLD=m
> > > CONFIG_MFD_88PM800=m
> > > CONFIG_MFD_88PM805=m
> > > CONFIG_MFD_88PM860X=y
> > > CONFIG_MFD_MAX14577=y
> > > CONFIG_MFD_MAX77693=y
> > > CONFIG_MFD_MAX77843=y
> > > CONFIG_MFD_MAX8907=m
> > > CONFIG_MFD_MAX8925=y
> > > CONFIG_MFD_MAX8997=y
> > > CONFIG_MFD_MAX8998=y
> > > CONFIG_MFD_MT6397=m
> > > CONFIG_MFD_MENF21BMC=m
> > > CONFIG_EZX_PCAP=y
> > > CONFIG_MFD_VIPERBOARD=m
> > > CONFIG_MFD_RETU=m
> > > CONFIG_MFD_PCF50633=m
> > > CONFIG_PCF50633_ADC=m
> > > CONFIG_PCF50633_GPIO=m
> > > CONFIG_UCB1400_CORE=m
> > > CONFIG_MFD_RDC321X=m
> > > CONFIG_MFD_RT5033=m
> > > CONFIG_MFD_RC5T583=y
> > > CONFIG_MFD_SEC_CORE=y
> > > CONFIG_MFD_SI476X_CORE=m
> > > CONFIG_MFD_SM501=m
> > > CONFIG_MFD_SM501_GPIO=y
> > > CONFIG_MFD_SKY81452=m
> > > CONFIG_MFD_SMSC=y
> > > CONFIG_ABX500_CORE=y
> > > CONFIG_AB3100_CORE=y
> > > CONFIG_AB3100_OTP=m
> > > CONFIG_MFD_SYSCON=y
> > > CONFIG_MFD_TI_AM335X_TSCADC=m
> > > CONFIG_MFD_LP3943=m
> > > CONFIG_MFD_LP8788=y
> > > CONFIG_MFD_TI_LMU=m
> > > CONFIG_MFD_PALMAS=y
> > > CONFIG_TPS6105X=m
> > > CONFIG_TPS65010=m
> > > CONFIG_TPS6507X=m
> > > CONFIG_MFD_TPS65086=m
> > > CONFIG_MFD_TPS65090=y
> > > CONFIG_MFD_TPS68470=y
> > > CONFIG_MFD_TI_LP873X=m
> > > CONFIG_MFD_TPS6586X=y
> > > CONFIG_MFD_TPS65910=y
> > > CONFIG_MFD_TPS65912=y
> > > CONFIG_MFD_TPS65912_I2C=y
> > > CONFIG_MFD_TPS65912_SPI=y
> > > CONFIG_MFD_TPS80031=y
> > > CONFIG_TWL4030_CORE=y
> > > CONFIG_MFD_TWL4030_AUDIO=y
> > > CONFIG_TWL6040_CORE=y
> > > CONFIG_MFD_WL1273_CORE=m
> > > CONFIG_MFD_LM3533=m
> > > CONFIG_MFD_TQMX86=m
> > > CONFIG_MFD_VX855=m
> > > CONFIG_MFD_ARIZONA=y
> > > CONFIG_MFD_ARIZONA_I2C=m
> > > CONFIG_MFD_ARIZONA_SPI=m
> > > CONFIG_MFD_CS47L24=y
> > > CONFIG_MFD_WM5102=y
> > > CONFIG_MFD_WM5110=y
> > > CONFIG_MFD_WM8997=y
> > > CONFIG_MFD_WM8998=y
> > > CONFIG_MFD_WM8400=y
> > > CONFIG_MFD_WM831X=y
> > > CONFIG_MFD_WM831X_I2C=y
> > > CONFIG_MFD_WM831X_SPI=y
> > > CONFIG_MFD_WM8350=y
> > > CONFIG_MFD_WM8350_I2C=y
> > > CONFIG_MFD_WM8994=m
> > > CONFIG_RAVE_SP_CORE=m
> > > # end of Multifunction device drivers
> > > 
> > > CONFIG_REGULATOR=y
> > > # CONFIG_REGULATOR_DEBUG is not set
> > > CONFIG_REGULATOR_FIXED_VOLTAGE=m
> > > CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
> > > CONFIG_REGULATOR_USERSPACE_CONSUMER=m
> > > CONFIG_REGULATOR_88PG86X=m
> > > CONFIG_REGULATOR_88PM800=m
> > > CONFIG_REGULATOR_88PM8607=m
> > > CONFIG_REGULATOR_ACT8865=m
> > > CONFIG_REGULATOR_AD5398=m
> > > CONFIG_REGULATOR_ANATOP=m
> > > CONFIG_REGULATOR_AAT2870=m
> > > CONFIG_REGULATOR_AB3100=m
> > > CONFIG_REGULATOR_ARIZONA_LDO1=m
> > > CONFIG_REGULATOR_ARIZONA_MICSUPP=m
> > > CONFIG_REGULATOR_AS3711=m
> > > CONFIG_REGULATOR_AXP20X=m
> > > CONFIG_REGULATOR_BCM590XX=m
> > > CONFIG_REGULATOR_BD9571MWV=m
> > > CONFIG_REGULATOR_DA903X=m
> > > CONFIG_REGULATOR_DA9052=m
> > > CONFIG_REGULATOR_DA9055=m
> > > CONFIG_REGULATOR_DA9062=m
> > > CONFIG_REGULATOR_DA9210=m
> > > CONFIG_REGULATOR_DA9211=m
> > > CONFIG_REGULATOR_FAN53555=m
> > > CONFIG_REGULATOR_GPIO=m
> > > CONFIG_REGULATOR_ISL9305=m
> > > CONFIG_REGULATOR_ISL6271A=m
> > > CONFIG_REGULATOR_LM363X=m
> > > CONFIG_REGULATOR_LP3971=m
> > > CONFIG_REGULATOR_LP3972=m
> > > CONFIG_REGULATOR_LP872X=m
> > > CONFIG_REGULATOR_LP8755=m
> > > CONFIG_REGULATOR_LP8788=m
> > > CONFIG_REGULATOR_LTC3589=m
> > > CONFIG_REGULATOR_LTC3676=m
> > > CONFIG_REGULATOR_MAX14577=m
> > > CONFIG_REGULATOR_MAX1586=m
> > > CONFIG_REGULATOR_MAX8649=m
> > > CONFIG_REGULATOR_MAX8660=m
> > > CONFIG_REGULATOR_MAX8907=m
> > > CONFIG_REGULATOR_MAX8925=m
> > > CONFIG_REGULATOR_MAX8952=m
> > > CONFIG_REGULATOR_MAX8997=m
> > > CONFIG_REGULATOR_MAX8998=m
> > > CONFIG_REGULATOR_MAX77693=m
> > > CONFIG_REGULATOR_MC13XXX_CORE=m
> > > CONFIG_REGULATOR_MC13783=m
> > > CONFIG_REGULATOR_MC13892=m
> > > CONFIG_REGULATOR_MT6311=m
> > > CONFIG_REGULATOR_MT6323=m
> > > CONFIG_REGULATOR_MT6397=m
> > > CONFIG_REGULATOR_PALMAS=m
> > > CONFIG_REGULATOR_PCAP=m
> > > CONFIG_REGULATOR_PCF50633=m
> > > CONFIG_REGULATOR_PFUZE100=m
> > > CONFIG_REGULATOR_PV88060=m
> > > CONFIG_REGULATOR_PV88080=m
> > > CONFIG_REGULATOR_PV88090=m
> > > CONFIG_REGULATOR_PWM=m
> > > CONFIG_REGULATOR_QCOM_SPMI=m
> > > CONFIG_REGULATOR_RC5T583=m
> > > CONFIG_REGULATOR_RT5033=m
> > > CONFIG_REGULATOR_S2MPA01=m
> > > CONFIG_REGULATOR_S2MPS11=m
> > > CONFIG_REGULATOR_S5M8767=m
> > > CONFIG_REGULATOR_SKY81452=m
> > > CONFIG_REGULATOR_SLG51000=m
> > > CONFIG_REGULATOR_TPS51632=m
> > > CONFIG_REGULATOR_TPS6105X=m
> > > CONFIG_REGULATOR_TPS62360=m
> > > CONFIG_REGULATOR_TPS65023=m
> > > CONFIG_REGULATOR_TPS6507X=m
> > > CONFIG_REGULATOR_TPS65086=m
> > > CONFIG_REGULATOR_TPS65090=m
> > > CONFIG_REGULATOR_TPS65132=m
> > > CONFIG_REGULATOR_TPS6524X=m
> > > CONFIG_REGULATOR_TPS6586X=m
> > > CONFIG_REGULATOR_TPS65910=m
> > > CONFIG_REGULATOR_TPS65912=m
> > > CONFIG_REGULATOR_TPS80031=m
> > > CONFIG_REGULATOR_TWL4030=m
> > > CONFIG_REGULATOR_WM831X=m
> > > CONFIG_REGULATOR_WM8350=m
> > > CONFIG_REGULATOR_WM8400=m
> > > CONFIG_REGULATOR_WM8994=m
> > > CONFIG_CEC_CORE=y
> > > CONFIG_CEC_NOTIFIER=y
> > > CONFIG_RC_CORE=m
> > > CONFIG_RC_MAP=m
> > > CONFIG_LIRC=y
> > > CONFIG_RC_DECODERS=y
> > > CONFIG_IR_NEC_DECODER=m
> > > CONFIG_IR_RC5_DECODER=m
> > > CONFIG_IR_RC6_DECODER=m
> > > CONFIG_IR_JVC_DECODER=m
> > > CONFIG_IR_SONY_DECODER=m
> > > CONFIG_IR_SANYO_DECODER=m
> > > CONFIG_IR_SHARP_DECODER=m
> > > CONFIG_IR_MCE_KBD_DECODER=m
> > > CONFIG_IR_XMP_DECODER=m
> > > CONFIG_IR_IMON_DECODER=m
> > > CONFIG_IR_RCMM_DECODER=m
> > > CONFIG_RC_DEVICES=y
> > > CONFIG_RC_ATI_REMOTE=m
> > > CONFIG_IR_ENE=m
> > > CONFIG_IR_IMON=m
> > > CONFIG_IR_IMON_RAW=m
> > > CONFIG_IR_MCEUSB=m
> > > CONFIG_IR_ITE_CIR=m
> > > CONFIG_IR_FINTEK=m
> > > CONFIG_IR_NUVOTON=m
> > > CONFIG_IR_REDRAT3=m
> > > CONFIG_IR_STREAMZAP=m
> > > CONFIG_IR_WINBOND_CIR=m
> > > CONFIG_IR_IGORPLUGUSB=m
> > > CONFIG_IR_IGUANA=m
> > > CONFIG_IR_TTUSBIR=m
> > > CONFIG_RC_LOOPBACK=m
> > > CONFIG_IR_SERIAL=m
> > > CONFIG_IR_SERIAL_TRANSMITTER=y
> > > CONFIG_IR_SIR=m
> > > CONFIG_RC_XBOX_DVD=m
> > > CONFIG_MEDIA_SUPPORT=m
> > > 
> > > #
> > > # Multimedia core support
> > > #
> > > CONFIG_MEDIA_CAMERA_SUPPORT=y
> > > CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
> > > CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
> > > CONFIG_MEDIA_RADIO_SUPPORT=y
> > > CONFIG_MEDIA_SDR_SUPPORT=y
> > > CONFIG_MEDIA_CEC_SUPPORT=y
> > > CONFIG_MEDIA_CONTROLLER=y
> > > CONFIG_MEDIA_CONTROLLER_DVB=y
> > > # CONFIG_MEDIA_CONTROLLER_REQUEST_API is not set
> > > CONFIG_VIDEO_DEV=m
> > > CONFIG_VIDEO_V4L2_SUBDEV_API=y
> > > CONFIG_VIDEO_V4L2=m
> > > CONFIG_VIDEO_V4L2_I2C=y
> > > # CONFIG_VIDEO_ADV_DEBUG is not set
> > > # CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
> > > # CONFIG_VIDEO_PCI_SKELETON is not set
> > > CONFIG_VIDEO_TUNER=m
> > > CONFIG_V4L2_MEM2MEM_DEV=m
> > > CONFIG_V4L2_FLASH_LED_CLASS=m
> > > CONFIG_V4L2_FWNODE=m
> > > CONFIG_VIDEOBUF_GEN=m
> > > CONFIG_VIDEOBUF_DMA_SG=m
> > > CONFIG_VIDEOBUF_VMALLOC=m
> > > CONFIG_DVB_CORE=m
> > > # CONFIG_DVB_MMAP is not set
> > > CONFIG_DVB_NET=y
> > > CONFIG_TTPCI_EEPROM=m
> > > CONFIG_DVB_MAX_ADAPTERS=8
> > > CONFIG_DVB_DYNAMIC_MINORS=y
> > > # CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
> > > # CONFIG_DVB_ULE_DEBUG is not set
> > > 
> > > #
> > > # Media drivers
> > > #
> > > CONFIG_MEDIA_USB_SUPPORT=y
> > > 
> > > #
> > > # Webcam devices
> > > #
> > > CONFIG_USB_VIDEO_CLASS=m
> > > CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
> > > CONFIG_USB_GSPCA=m
> > > CONFIG_USB_M5602=m
> > > CONFIG_USB_STV06XX=m
> > > CONFIG_USB_GL860=m
> > > CONFIG_USB_GSPCA_BENQ=m
> > > CONFIG_USB_GSPCA_CONEX=m
> > > CONFIG_USB_GSPCA_CPIA1=m
> > > CONFIG_USB_GSPCA_DTCS033=m
> > > CONFIG_USB_GSPCA_ETOMS=m
> > > CONFIG_USB_GSPCA_FINEPIX=m
> > > CONFIG_USB_GSPCA_JEILINJ=m
> > > CONFIG_USB_GSPCA_JL2005BCD=m
> > > CONFIG_USB_GSPCA_KINECT=m
> > > CONFIG_USB_GSPCA_KONICA=m
> > > CONFIG_USB_GSPCA_MARS=m
> > > CONFIG_USB_GSPCA_MR97310A=m
> > > CONFIG_USB_GSPCA_NW80X=m
> > > CONFIG_USB_GSPCA_OV519=m
> > > CONFIG_USB_GSPCA_OV534=m
> > > CONFIG_USB_GSPCA_OV534_9=m
> > > CONFIG_USB_GSPCA_PAC207=m
> > > CONFIG_USB_GSPCA_PAC7302=m
> > > CONFIG_USB_GSPCA_PAC7311=m
> > > CONFIG_USB_GSPCA_SE401=m
> > > CONFIG_USB_GSPCA_SN9C2028=m
> > > CONFIG_USB_GSPCA_SN9C20X=m
> > > CONFIG_USB_GSPCA_SONIXB=m
> > > CONFIG_USB_GSPCA_SONIXJ=m
> > > CONFIG_USB_GSPCA_SPCA500=m
> > > CONFIG_USB_GSPCA_SPCA501=m
> > > CONFIG_USB_GSPCA_SPCA505=m
> > > CONFIG_USB_GSPCA_SPCA506=m
> > > CONFIG_USB_GSPCA_SPCA508=m
> > > CONFIG_USB_GSPCA_SPCA561=m
> > > CONFIG_USB_GSPCA_SPCA1528=m
> > > CONFIG_USB_GSPCA_SQ905=m
> > > CONFIG_USB_GSPCA_SQ905C=m
> > > CONFIG_USB_GSPCA_SQ930X=m
> > > CONFIG_USB_GSPCA_STK014=m
> > > CONFIG_USB_GSPCA_STK1135=m
> > > CONFIG_USB_GSPCA_STV0680=m
> > > CONFIG_USB_GSPCA_SUNPLUS=m
> > > CONFIG_USB_GSPCA_T613=m
> > > CONFIG_USB_GSPCA_TOPRO=m
> > > CONFIG_USB_GSPCA_TOUPTEK=m
> > > CONFIG_USB_GSPCA_TV8532=m
> > > CONFIG_USB_GSPCA_VC032X=m
> > > CONFIG_USB_GSPCA_VICAM=m
> > > CONFIG_USB_GSPCA_XIRLINK_CIT=m
> > > CONFIG_USB_GSPCA_ZC3XX=m
> > > CONFIG_USB_PWC=m
> > > # CONFIG_USB_PWC_DEBUG is not set
> > > CONFIG_USB_PWC_INPUT_EVDEV=y
> > > CONFIG_VIDEO_CPIA2=m
> > > CONFIG_USB_ZR364XX=m
> > > CONFIG_USB_STKWEBCAM=m
> > > CONFIG_USB_S2255=m
> > > CONFIG_VIDEO_USBTV=m
> > > 
> > > #
> > > # Analog TV USB devices
> > > #
> > > CONFIG_VIDEO_PVRUSB2=m
> > > CONFIG_VIDEO_PVRUSB2_SYSFS=y
> > > CONFIG_VIDEO_PVRUSB2_DVB=y
> > > # CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
> > > CONFIG_VIDEO_HDPVR=m
> > > CONFIG_VIDEO_USBVISION=m
> > > CONFIG_VIDEO_STK1160_COMMON=m
> > > CONFIG_VIDEO_STK1160=m
> > > CONFIG_VIDEO_GO7007=m
> > > CONFIG_VIDEO_GO7007_USB=m
> > > CONFIG_VIDEO_GO7007_LOADER=m
> > > CONFIG_VIDEO_GO7007_USB_S2250_BOARD=m
> > > 
> > > #
> > > # Analog/digital TV USB devices
> > > #
> > > CONFIG_VIDEO_AU0828=m
> > > CONFIG_VIDEO_AU0828_V4L2=y
> > > CONFIG_VIDEO_AU0828_RC=y
> > > CONFIG_VIDEO_CX231XX=m
> > > CONFIG_VIDEO_CX231XX_RC=y
> > > CONFIG_VIDEO_CX231XX_ALSA=m
> > > CONFIG_VIDEO_CX231XX_DVB=m
> > > CONFIG_VIDEO_TM6000=m
> > > CONFIG_VIDEO_TM6000_ALSA=m
> > > CONFIG_VIDEO_TM6000_DVB=m
> > > 
> > > #
> > > # Digital TV USB devices
> > > #
> > > CONFIG_DVB_USB=m
> > > # CONFIG_DVB_USB_DEBUG is not set
> > > CONFIG_DVB_USB_DIB3000MC=m
> > > CONFIG_DVB_USB_A800=m
> > > CONFIG_DVB_USB_DIBUSB_MB=m
> > > # CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
> > > CONFIG_DVB_USB_DIBUSB_MC=m
> > > CONFIG_DVB_USB_DIB0700=m
> > > CONFIG_DVB_USB_UMT_010=m
> > > CONFIG_DVB_USB_CXUSB=m
> > > CONFIG_DVB_USB_CXUSB_ANALOG=y
> > > CONFIG_DVB_USB_M920X=m
> > > CONFIG_DVB_USB_DIGITV=m
> > > CONFIG_DVB_USB_VP7045=m
> > > CONFIG_DVB_USB_VP702X=m
> > > CONFIG_DVB_USB_GP8PSK=m
> > > CONFIG_DVB_USB_NOVA_T_USB2=m
> > > CONFIG_DVB_USB_TTUSB2=m
> > > CONFIG_DVB_USB_DTT200U=m
> > > CONFIG_DVB_USB_OPERA1=m
> > > CONFIG_DVB_USB_AF9005=m
> > > CONFIG_DVB_USB_AF9005_REMOTE=m
> > > CONFIG_DVB_USB_PCTV452E=m
> > > CONFIG_DVB_USB_DW2102=m
> > > CONFIG_DVB_USB_CINERGY_T2=m
> > > CONFIG_DVB_USB_DTV5100=m
> > > CONFIG_DVB_USB_AZ6027=m
> > > CONFIG_DVB_USB_TECHNISAT_USB2=m
> > > CONFIG_DVB_USB_V2=m
> > > CONFIG_DVB_USB_AF9015=m
> > > CONFIG_DVB_USB_AF9035=m
> > > CONFIG_DVB_USB_ANYSEE=m
> > > CONFIG_DVB_USB_AU6610=m
> > > CONFIG_DVB_USB_AZ6007=m
> > > CONFIG_DVB_USB_CE6230=m
> > > CONFIG_DVB_USB_EC168=m
> > > CONFIG_DVB_USB_GL861=m
> > > CONFIG_DVB_USB_LME2510=m
> > > CONFIG_DVB_USB_MXL111SF=m
> > > CONFIG_DVB_USB_RTL28XXU=m
> > > CONFIG_DVB_USB_DVBSKY=m
> > > CONFIG_DVB_USB_ZD1301=m
> > > CONFIG_DVB_TTUSB_BUDGET=m
> > > CONFIG_DVB_TTUSB_DEC=m
> > > CONFIG_SMS_USB_DRV=m
> > > CONFIG_DVB_B2C2_FLEXCOP_USB=m
> > > # CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
> > > CONFIG_DVB_AS102=m
> > > 
> > > #
> > > # Webcam, TV (analog/digital) USB devices
> > > #
> > > CONFIG_VIDEO_EM28XX=m
> > > CONFIG_VIDEO_EM28XX_V4L2=m
> > > CONFIG_VIDEO_EM28XX_ALSA=m
> > > CONFIG_VIDEO_EM28XX_DVB=m
> > > CONFIG_VIDEO_EM28XX_RC=m
> > > 
> > > #
> > > # Software defined radio USB devices
> > > #
> > > CONFIG_USB_AIRSPY=m
> > > CONFIG_USB_HACKRF=m
> > > CONFIG_USB_MSI2500=m
> > > 
> > > #
> > > # USB HDMI CEC adapters
> > > #
> > > CONFIG_USB_PULSE8_CEC=m
> > > CONFIG_USB_RAINSHADOW_CEC=m
> > > CONFIG_MEDIA_PCI_SUPPORT=y
> > > 
> > > #
> > > # Media capture support
> > > #
> > > CONFIG_VIDEO_MEYE=m
> > > CONFIG_VIDEO_SOLO6X10=m
> > > CONFIG_VIDEO_TW5864=m
> > > CONFIG_VIDEO_TW68=m
> > > CONFIG_VIDEO_TW686X=m
> > > 
> > > #
> > > # Media capture/analog TV support
> > > #
> > > CONFIG_VIDEO_IVTV=m
> > > # CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
> > > CONFIG_VIDEO_IVTV_ALSA=m
> > > CONFIG_VIDEO_FB_IVTV=m
> > > CONFIG_VIDEO_FB_IVTV_FORCE_PAT=y
> > > CONFIG_VIDEO_HEXIUM_GEMINI=m
> > > CONFIG_VIDEO_HEXIUM_ORION=m
> > > CONFIG_VIDEO_MXB=m
> > > CONFIG_VIDEO_DT3155=m
> > > 
> > > #
> > > # Media capture/analog/hybrid TV support
> > > #
> > > CONFIG_VIDEO_CX18=m
> > > CONFIG_VIDEO_CX18_ALSA=m
> > > CONFIG_VIDEO_CX23885=m
> > > CONFIG_MEDIA_ALTERA_CI=m
> > > CONFIG_VIDEO_CX25821=m
> > > CONFIG_VIDEO_CX25821_ALSA=m
> > > CONFIG_VIDEO_CX88=m
> > > CONFIG_VIDEO_CX88_ALSA=m
> > > CONFIG_VIDEO_CX88_BLACKBIRD=m
> > > CONFIG_VIDEO_CX88_DVB=m
> > > CONFIG_VIDEO_CX88_ENABLE_VP3054=y
> > > CONFIG_VIDEO_CX88_VP3054=m
> > > CONFIG_VIDEO_CX88_MPEG=m
> > > CONFIG_VIDEO_BT848=m
> > > CONFIG_DVB_BT8XX=m
> > > CONFIG_VIDEO_SAA7134=m
> > > CONFIG_VIDEO_SAA7134_ALSA=m
> > > CONFIG_VIDEO_SAA7134_RC=y
> > > CONFIG_VIDEO_SAA7134_DVB=m
> > > CONFIG_VIDEO_SAA7134_GO7007=m
> > > CONFIG_VIDEO_SAA7164=m
> > > CONFIG_VIDEO_COBALT=m
> > > 
> > > #
> > > # Media digital TV PCI Adapters
> > > #
> > > CONFIG_DVB_AV7110_IR=y
> > > CONFIG_DVB_AV7110=m
> > > CONFIG_DVB_AV7110_OSD=y
> > > CONFIG_DVB_BUDGET_CORE=m
> > > CONFIG_DVB_BUDGET=m
> > > CONFIG_DVB_BUDGET_CI=m
> > > CONFIG_DVB_BUDGET_AV=m
> > > CONFIG_DVB_BUDGET_PATCH=m
> > > CONFIG_DVB_B2C2_FLEXCOP_PCI=m
> > > # CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
> > > CONFIG_DVB_PLUTO2=m
> > > CONFIG_DVB_DM1105=m
> > > CONFIG_DVB_PT1=m
> > > CONFIG_DVB_PT3=m
> > > CONFIG_MANTIS_CORE=m
> > > CONFIG_DVB_MANTIS=m
> > > CONFIG_DVB_HOPPER=m
> > > CONFIG_DVB_NGENE=m
> > > CONFIG_DVB_DDBRIDGE=m
> > > # CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
> > > CONFIG_DVB_SMIPCIE=m
> > > CONFIG_DVB_NETUP_UNIDVB=m
> > > CONFIG_VIDEO_IPU3_CIO2=m
> > > CONFIG_V4L_PLATFORM_DRIVERS=y
> > > CONFIG_VIDEO_CAFE_CCIC=m
> > > CONFIG_VIDEO_VIA_CAMERA=m
> > > CONFIG_VIDEO_CADENCE=y
> > > CONFIG_VIDEO_CADENCE_CSI2RX=m
> > > CONFIG_VIDEO_CADENCE_CSI2TX=m
> > > CONFIG_VIDEO_ASPEED=m
> > > CONFIG_V4L_MEM2MEM_DRIVERS=y
> > > CONFIG_VIDEO_MEM2MEM_DEINTERLACE=m
> > > CONFIG_VIDEO_SH_VEU=m
> > > CONFIG_V4L_TEST_DRIVERS=y
> > > CONFIG_VIDEO_VIMC=m
> > > CONFIG_VIDEO_VIVID=m
> > > CONFIG_VIDEO_VIVID_CEC=y
> > > CONFIG_VIDEO_VIVID_MAX_DEVS=64
> > > CONFIG_VIDEO_VIM2M=m
> > > CONFIG_VIDEO_VICODEC=m
> > > CONFIG_DVB_PLATFORM_DRIVERS=y
> > > CONFIG_CEC_PLATFORM_DRIVERS=y
> > > CONFIG_VIDEO_CROS_EC_CEC=m
> > > CONFIG_VIDEO_SECO_CEC=m
> > > CONFIG_VIDEO_SECO_RC=y
> > > CONFIG_SDR_PLATFORM_DRIVERS=y
> > > 
> > > #
> > > # Supported MMC/SDIO adapters
> > > #
> > > CONFIG_SMS_SDIO_DRV=m
> > > CONFIG_RADIO_ADAPTERS=y
> > > CONFIG_RADIO_TEA575X=m
> > > CONFIG_RADIO_SI470X=m
> > > CONFIG_USB_SI470X=m
> > > CONFIG_I2C_SI470X=m
> > > CONFIG_RADIO_SI4713=m
> > > CONFIG_USB_SI4713=m
> > > CONFIG_PLATFORM_SI4713=m
> > > CONFIG_I2C_SI4713=m
> > > CONFIG_RADIO_SI476X=m
> > > CONFIG_USB_MR800=m
> > > CONFIG_USB_DSBR=m
> > > CONFIG_RADIO_MAXIRADIO=m
> > > CONFIG_RADIO_SHARK=m
> > > CONFIG_RADIO_SHARK2=m
> > > CONFIG_USB_KEENE=m
> > > CONFIG_USB_RAREMONO=m
> > > CONFIG_USB_MA901=m
> > > CONFIG_RADIO_TEA5764=m
> > > CONFIG_RADIO_SAA7706H=m
> > > CONFIG_RADIO_TEF6862=m
> > > CONFIG_RADIO_WL1273=m
> > > 
> > > #
> > > # Texas Instruments WL128x FM driver (ST based)
> > > #
> > > CONFIG_RADIO_WL128X=m
> > > # end of Texas Instruments WL128x FM driver (ST based)
> > > 
> > > #
> > > # Supported FireWire (IEEE 1394) Adapters
> > > #
> > > CONFIG_DVB_FIREDTV=m
> > > CONFIG_DVB_FIREDTV_INPUT=y
> > > CONFIG_MEDIA_COMMON_OPTIONS=y
> > > 
> > > #
> > > # common driver options
> > > #
> > > CONFIG_VIDEO_CX2341X=m
> > > CONFIG_VIDEO_TVEEPROM=m
> > > CONFIG_CYPRESS_FIRMWARE=m
> > > CONFIG_VIDEOBUF2_CORE=m
> > > CONFIG_VIDEOBUF2_V4L2=m
> > > CONFIG_VIDEOBUF2_MEMOPS=m
> > > CONFIG_VIDEOBUF2_DMA_CONTIG=m
> > > CONFIG_VIDEOBUF2_VMALLOC=m
> > > CONFIG_VIDEOBUF2_DMA_SG=m
> > > CONFIG_VIDEOBUF2_DVB=m
> > > CONFIG_DVB_B2C2_FLEXCOP=m
> > > CONFIG_VIDEO_SAA7146=m
> > > CONFIG_VIDEO_SAA7146_VV=m
> > > CONFIG_SMS_SIANO_MDTV=m
> > > CONFIG_SMS_SIANO_RC=y
> > > CONFIG_SMS_SIANO_DEBUGFS=y
> > > CONFIG_VIDEO_V4L2_TPG=m
> > > 
> > > #
> > > # Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
> > > #
> > > CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
> > > CONFIG_MEDIA_ATTACH=y
> > > CONFIG_VIDEO_IR_I2C=m
> > > 
> > > #
> > > # I2C Encoders, decoders, sensors and other helper chips
> > > #
> > > 
> > > #
> > > # Audio decoders, processors and mixers
> > > #
> > > CONFIG_VIDEO_TVAUDIO=m
> > > CONFIG_VIDEO_TDA7432=m
> > > CONFIG_VIDEO_TDA9840=m
> > > CONFIG_VIDEO_TDA1997X=m
> > > CONFIG_VIDEO_TEA6415C=m
> > > CONFIG_VIDEO_TEA6420=m
> > > CONFIG_VIDEO_MSP3400=m
> > > CONFIG_VIDEO_CS3308=m
> > > CONFIG_VIDEO_CS5345=m
> > > CONFIG_VIDEO_CS53L32A=m
> > > CONFIG_VIDEO_TLV320AIC23B=m
> > > CONFIG_VIDEO_UDA1342=m
> > > CONFIG_VIDEO_WM8775=m
> > > CONFIG_VIDEO_WM8739=m
> > > CONFIG_VIDEO_VP27SMPX=m
> > > CONFIG_VIDEO_SONY_BTF_MPX=m
> > > 
> > > #
> > > # RDS decoders
> > > #
> > > CONFIG_VIDEO_SAA6588=m
> > > 
> > > #
> > > # Video decoders
> > > #
> > > CONFIG_VIDEO_ADV7180=m
> > > CONFIG_VIDEO_ADV7183=m
> > > CONFIG_VIDEO_ADV7604=m
> > > CONFIG_VIDEO_ADV7604_CEC=y
> > > CONFIG_VIDEO_ADV7842=m
> > > CONFIG_VIDEO_ADV7842_CEC=y
> > > CONFIG_VIDEO_BT819=m
> > > CONFIG_VIDEO_BT856=m
> > > CONFIG_VIDEO_BT866=m
> > > CONFIG_VIDEO_KS0127=m
> > > CONFIG_VIDEO_ML86V7667=m
> > > CONFIG_VIDEO_SAA7110=m
> > > CONFIG_VIDEO_SAA711X=m
> > > CONFIG_VIDEO_TC358743=m
> > > CONFIG_VIDEO_TC358743_CEC=y
> > > CONFIG_VIDEO_TVP514X=m
> > > CONFIG_VIDEO_TVP5150=m
> > > CONFIG_VIDEO_TVP7002=m
> > > CONFIG_VIDEO_TW2804=m
> > > CONFIG_VIDEO_TW9903=m
> > > CONFIG_VIDEO_TW9906=m
> > > CONFIG_VIDEO_TW9910=m
> > > CONFIG_VIDEO_VPX3220=m
> > > 
> > > #
> > > # Video and audio decoders
> > > #
> > > CONFIG_VIDEO_SAA717X=m
> > > CONFIG_VIDEO_CX25840=m
> > > 
> > > #
> > > # Video encoders
> > > #
> > > CONFIG_VIDEO_SAA7127=m
> > > CONFIG_VIDEO_SAA7185=m
> > > CONFIG_VIDEO_ADV7170=m
> > > CONFIG_VIDEO_ADV7175=m
> > > CONFIG_VIDEO_ADV7343=m
> > > CONFIG_VIDEO_ADV7393=m
> > > CONFIG_VIDEO_ADV7511=m
> > > CONFIG_VIDEO_ADV7511_CEC=y
> > > CONFIG_VIDEO_AD9389B=m
> > > CONFIG_VIDEO_AK881X=m
> > > CONFIG_VIDEO_THS8200=m
> > > 
> > > #
> > > # Camera sensor devices
> > > #
> > > CONFIG_VIDEO_APTINA_PLL=m
> > > CONFIG_VIDEO_SMIAPP_PLL=m
> > > # CONFIG_VIDEO_HI556 is not set
> > > CONFIG_VIDEO_IMX214=m
> > > CONFIG_VIDEO_IMX258=m
> > > CONFIG_VIDEO_IMX274=m
> > > # CONFIG_VIDEO_IMX290 is not set
> > > CONFIG_VIDEO_IMX319=m
> > > CONFIG_VIDEO_IMX355=m
> > > CONFIG_VIDEO_OV2640=m
> > > CONFIG_VIDEO_OV2659=m
> > > CONFIG_VIDEO_OV2680=m
> > > CONFIG_VIDEO_OV2685=m
> > > CONFIG_VIDEO_OV5647=m
> > > CONFIG_VIDEO_OV6650=m
> > > CONFIG_VIDEO_OV5670=m
> > > # CONFIG_VIDEO_OV5675 is not set
> > > CONFIG_VIDEO_OV5695=m
> > > CONFIG_VIDEO_OV7251=m
> > > CONFIG_VIDEO_OV772X=m
> > > CONFIG_VIDEO_OV7640=m
> > > CONFIG_VIDEO_OV7670=m
> > > CONFIG_VIDEO_OV7740=m
> > > CONFIG_VIDEO_OV8856=m
> > > CONFIG_VIDEO_OV9640=m
> > > CONFIG_VIDEO_OV9650=m
> > > CONFIG_VIDEO_OV13858=m
> > > CONFIG_VIDEO_VS6624=m
> > > CONFIG_VIDEO_MT9M001=m
> > > CONFIG_VIDEO_MT9M032=m
> > > CONFIG_VIDEO_MT9M111=m
> > > CONFIG_VIDEO_MT9P031=m
> > > CONFIG_VIDEO_MT9T001=m
> > > CONFIG_VIDEO_MT9T112=m
> > > CONFIG_VIDEO_MT9V011=m
> > > CONFIG_VIDEO_MT9V032=m
> > > CONFIG_VIDEO_MT9V111=m
> > > CONFIG_VIDEO_SR030PC30=m
> > > CONFIG_VIDEO_NOON010PC30=m
> > > CONFIG_VIDEO_M5MOLS=m
> > > CONFIG_VIDEO_RJ54N1=m
> > > CONFIG_VIDEO_S5K6AA=m
> > > CONFIG_VIDEO_S5K6A3=m
> > > CONFIG_VIDEO_S5K4ECGX=m
> > > CONFIG_VIDEO_S5K5BAF=m
> > > CONFIG_VIDEO_SMIAPP=m
> > > CONFIG_VIDEO_ET8EK8=m
> > > CONFIG_VIDEO_S5C73M3=m
> > > 
> > > #
> > > # Lens drivers
> > > #
> > > CONFIG_VIDEO_AD5820=m
> > > CONFIG_VIDEO_AK7375=m
> > > CONFIG_VIDEO_DW9714=m
> > > CONFIG_VIDEO_DW9807_VCM=m
> > > 
> > > #
> > > # Flash devices
> > > #
> > > CONFIG_VIDEO_ADP1653=m
> > > CONFIG_VIDEO_LM3560=m
> > > CONFIG_VIDEO_LM3646=m
> > > 
> > > #
> > > # Video improvement chips
> > > #
> > > CONFIG_VIDEO_UPD64031A=m
> > > CONFIG_VIDEO_UPD64083=m
> > > 
> > > #
> > > # Audio/Video compression chips
> > > #
> > > CONFIG_VIDEO_SAA6752HS=m
> > > 
> > > #
> > > # SDR tuner chips
> > > #
> > > CONFIG_SDR_MAX2175=m
> > > 
> > > #
> > > # Miscellaneous helper chips
> > > #
> > > CONFIG_VIDEO_THS7303=m
> > > CONFIG_VIDEO_M52790=m
> > > CONFIG_VIDEO_I2C=m
> > > CONFIG_VIDEO_ST_MIPID02=m
> > > # end of I2C Encoders, decoders, sensors and other helper chips
> > > 
> > > #
> > > # SPI helper chips
> > > #
> > > CONFIG_VIDEO_GS1662=m
> > > # end of SPI helper chips
> > > 
> > > #
> > > # Media SPI Adapters
> > > #
> > > CONFIG_CXD2880_SPI_DRV=m
> > > # end of Media SPI Adapters
> > > 
> > > CONFIG_MEDIA_TUNER=m
> > > 
> > > #
> > > # Customize TV tuners
> > > #
> > > CONFIG_MEDIA_TUNER_SIMPLE=m
> > > CONFIG_MEDIA_TUNER_TDA18250=m
> > > CONFIG_MEDIA_TUNER_TDA8290=m
> > > CONFIG_MEDIA_TUNER_TDA827X=m
> > > CONFIG_MEDIA_TUNER_TDA18271=m
> > > CONFIG_MEDIA_TUNER_TDA9887=m
> > > CONFIG_MEDIA_TUNER_TEA5761=m
> > > CONFIG_MEDIA_TUNER_TEA5767=m
> > > CONFIG_MEDIA_TUNER_MSI001=m
> > > CONFIG_MEDIA_TUNER_MT20XX=m
> > > CONFIG_MEDIA_TUNER_MT2060=m
> > > CONFIG_MEDIA_TUNER_MT2063=m
> > > CONFIG_MEDIA_TUNER_MT2266=m
> > > CONFIG_MEDIA_TUNER_MT2131=m
> > > CONFIG_MEDIA_TUNER_QT1010=m
> > > CONFIG_MEDIA_TUNER_XC2028=m
> > > CONFIG_MEDIA_TUNER_XC5000=m
> > > CONFIG_MEDIA_TUNER_XC4000=m
> > > CONFIG_MEDIA_TUNER_MXL5005S=m
> > > CONFIG_MEDIA_TUNER_MXL5007T=m
> > > CONFIG_MEDIA_TUNER_MC44S803=m
> > > CONFIG_MEDIA_TUNER_MAX2165=m
> > > CONFIG_MEDIA_TUNER_TDA18218=m
> > > CONFIG_MEDIA_TUNER_FC0011=m
> > > CONFIG_MEDIA_TUNER_FC0012=m
> > > CONFIG_MEDIA_TUNER_FC0013=m
> > > CONFIG_MEDIA_TUNER_TDA18212=m
> > > CONFIG_MEDIA_TUNER_E4000=m
> > > CONFIG_MEDIA_TUNER_FC2580=m
> > > CONFIG_MEDIA_TUNER_M88RS6000T=m
> > > CONFIG_MEDIA_TUNER_TUA9001=m
> > > CONFIG_MEDIA_TUNER_SI2157=m
> > > CONFIG_MEDIA_TUNER_IT913X=m
> > > CONFIG_MEDIA_TUNER_R820T=m
> > > CONFIG_MEDIA_TUNER_MXL301RF=m
> > > CONFIG_MEDIA_TUNER_QM1D1C0042=m
> > > CONFIG_MEDIA_TUNER_QM1D1B0004=m
> > > # end of Customize TV tuners
> > > 
> > > #
> > > # Customise DVB Frontends
> > > #
> > > 
> > > #
> > > # Multistandard (satellite) frontends
> > > #
> > > CONFIG_DVB_STB0899=m
> > > CONFIG_DVB_STB6100=m
> > > CONFIG_DVB_STV090x=m
> > > CONFIG_DVB_STV0910=m
> > > CONFIG_DVB_STV6110x=m
> > > CONFIG_DVB_STV6111=m
> > > CONFIG_DVB_MXL5XX=m
> > > CONFIG_DVB_M88DS3103=m
> > > 
> > > #
> > > # Multistandard (cable + terrestrial) frontends
> > > #
> > > CONFIG_DVB_DRXK=m
> > > CONFIG_DVB_TDA18271C2DD=m
> > > CONFIG_DVB_SI2165=m
> > > CONFIG_DVB_MN88472=m
> > > CONFIG_DVB_MN88473=m
> > > 
> > > #
> > > # DVB-S (satellite) frontends
> > > #
> > > CONFIG_DVB_CX24110=m
> > > CONFIG_DVB_CX24123=m
> > > CONFIG_DVB_MT312=m
> > > CONFIG_DVB_ZL10036=m
> > > CONFIG_DVB_ZL10039=m
> > > CONFIG_DVB_S5H1420=m
> > > CONFIG_DVB_STV0288=m
> > > CONFIG_DVB_STB6000=m
> > > CONFIG_DVB_STV0299=m
> > > CONFIG_DVB_STV6110=m
> > > CONFIG_DVB_STV0900=m
> > > CONFIG_DVB_TDA8083=m
> > > CONFIG_DVB_TDA10086=m
> > > CONFIG_DVB_TDA8261=m
> > > CONFIG_DVB_VES1X93=m
> > > CONFIG_DVB_TUNER_ITD1000=m
> > > CONFIG_DVB_TUNER_CX24113=m
> > > CONFIG_DVB_TDA826X=m
> > > CONFIG_DVB_TUA6100=m
> > > CONFIG_DVB_CX24116=m
> > > CONFIG_DVB_CX24117=m
> > > CONFIG_DVB_CX24120=m
> > > CONFIG_DVB_SI21XX=m
> > > CONFIG_DVB_TS2020=m
> > > CONFIG_DVB_DS3000=m
> > > CONFIG_DVB_MB86A16=m
> > > CONFIG_DVB_TDA10071=m
> > > 
> > > #
> > > # DVB-T (terrestrial) frontends
> > > #
> > > CONFIG_DVB_SP8870=m
> > > CONFIG_DVB_SP887X=m
> > > CONFIG_DVB_CX22700=m
> > > CONFIG_DVB_CX22702=m
> > > CONFIG_DVB_S5H1432=m
> > > CONFIG_DVB_DRXD=m
> > > CONFIG_DVB_L64781=m
> > > CONFIG_DVB_TDA1004X=m
> > > CONFIG_DVB_NXT6000=m
> > > CONFIG_DVB_MT352=m
> > > CONFIG_DVB_ZL10353=m
> > > CONFIG_DVB_DIB3000MB=m
> > > CONFIG_DVB_DIB3000MC=m
> > > CONFIG_DVB_DIB7000M=m
> > > CONFIG_DVB_DIB7000P=m
> > > CONFIG_DVB_DIB9000=m
> > > CONFIG_DVB_TDA10048=m
> > > CONFIG_DVB_AF9013=m
> > > CONFIG_DVB_EC100=m
> > > CONFIG_DVB_STV0367=m
> > > CONFIG_DVB_CXD2820R=m
> > > CONFIG_DVB_CXD2841ER=m
> > > CONFIG_DVB_RTL2830=m
> > > CONFIG_DVB_RTL2832=m
> > > CONFIG_DVB_RTL2832_SDR=m
> > > CONFIG_DVB_SI2168=m
> > > CONFIG_DVB_AS102_FE=m
> > > CONFIG_DVB_ZD1301_DEMOD=m
> > > CONFIG_DVB_GP8PSK_FE=m
> > > CONFIG_DVB_CXD2880=m
> > > 
> > > #
> > > # DVB-C (cable) frontends
> > > #
> > > CONFIG_DVB_VES1820=m
> > > CONFIG_DVB_TDA10021=m
> > > CONFIG_DVB_TDA10023=m
> > > CONFIG_DVB_STV0297=m
> > > 
> > > #
> > > # ATSC (North American/Korean Terrestrial/Cable DTV) frontends
> > > #
> > > CONFIG_DVB_NXT200X=m
> > > CONFIG_DVB_OR51211=m
> > > CONFIG_DVB_OR51132=m
> > > CONFIG_DVB_BCM3510=m
> > > CONFIG_DVB_LGDT330X=m
> > > CONFIG_DVB_LGDT3305=m
> > > CONFIG_DVB_LGDT3306A=m
> > > CONFIG_DVB_LG2160=m
> > > CONFIG_DVB_S5H1409=m
> > > CONFIG_DVB_AU8522=m
> > > CONFIG_DVB_AU8522_DTV=m
> > > CONFIG_DVB_AU8522_V4L=m
> > > CONFIG_DVB_S5H1411=m
> > > 
> > > #
> > > # ISDB-T (terrestrial) frontends
> > > #
> > > CONFIG_DVB_S921=m
> > > CONFIG_DVB_DIB8000=m
> > > CONFIG_DVB_MB86A20S=m
> > > 
> > > #
> > > # ISDB-S (satellite) & ISDB-T (terrestrial) frontends
> > > #
> > > CONFIG_DVB_TC90522=m
> > > CONFIG_DVB_MN88443X=m
> > > 
> > > #
> > > # Digital terrestrial only tuners/PLL
> > > #
> > > CONFIG_DVB_PLL=m
> > > CONFIG_DVB_TUNER_DIB0070=m
> > > CONFIG_DVB_TUNER_DIB0090=m
> > > 
> > > #
> > > # SEC control devices for DVB-S
> > > #
> > > CONFIG_DVB_DRX39XYJ=m
> > > CONFIG_DVB_LNBH25=m
> > > CONFIG_DVB_LNBH29=m
> > > CONFIG_DVB_LNBP21=m
> > > CONFIG_DVB_LNBP22=m
> > > CONFIG_DVB_ISL6405=m
> > > CONFIG_DVB_ISL6421=m
> > > CONFIG_DVB_ISL6423=m
> > > CONFIG_DVB_A8293=m
> > > CONFIG_DVB_LGS8GL5=m
> > > CONFIG_DVB_LGS8GXX=m
> > > CONFIG_DVB_ATBM8830=m
> > > CONFIG_DVB_TDA665x=m
> > > CONFIG_DVB_IX2505V=m
> > > CONFIG_DVB_M88RS2000=m
> > > CONFIG_DVB_AF9033=m
> > > CONFIG_DVB_HORUS3A=m
> > > CONFIG_DVB_ASCOT2E=m
> > > CONFIG_DVB_HELENE=m
> > > 
> > > #
> > > # Common Interface (EN50221) controller drivers
> > > #
> > > CONFIG_DVB_CXD2099=m
> > > CONFIG_DVB_SP2=m
> > > 
> > > #
> > > # Tools to develop new frontends
> > > #
> > > CONFIG_DVB_DUMMY_FE=m
> > > # end of Customise DVB Frontends
> > > 
> > > #
> > > # Graphics support
> > > #
> > > CONFIG_AGP=y
> > > CONFIG_AGP_AMD64=y
> > > CONFIG_AGP_INTEL=y
> > > CONFIG_AGP_SIS=m
> > > CONFIG_AGP_VIA=y
> > > CONFIG_INTEL_GTT=y
> > > CONFIG_VGA_ARB=y
> > > CONFIG_VGA_ARB_MAX_GPUS=16
> > > CONFIG_VGA_SWITCHEROO=y
> > > CONFIG_DRM=m
> > > CONFIG_DRM_MIPI_DBI=m
> > > CONFIG_DRM_MIPI_DSI=y
> > > CONFIG_DRM_DP_AUX_CHARDEV=y
> > > # CONFIG_DRM_DEBUG_SELFTEST is not set
> > > CONFIG_DRM_KMS_HELPER=m
> > > CONFIG_DRM_KMS_FB_HELPER=y
> > > # CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
> > > CONFIG_DRM_FBDEV_EMULATION=y
> > > CONFIG_DRM_FBDEV_OVERALLOC=100
> > > # CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
> > > CONFIG_DRM_LOAD_EDID_FIRMWARE=y
> > > CONFIG_DRM_DP_CEC=y
> > > CONFIG_DRM_TTM=m
> > > CONFIG_DRM_TTM_DMA_PAGE_POOL=y
> > > CONFIG_DRM_VRAM_HELPER=m
> > > CONFIG_DRM_TTM_HELPER=m
> > > CONFIG_DRM_GEM_CMA_HELPER=y
> > > CONFIG_DRM_KMS_CMA_HELPER=y
> > > CONFIG_DRM_GEM_SHMEM_HELPER=y
> > > CONFIG_DRM_SCHED=m
> > > 
> > > #
> > > # I2C encoder or helper chips
> > > #
> > > CONFIG_DRM_I2C_CH7006=m
> > > CONFIG_DRM_I2C_SIL164=m
> > > CONFIG_DRM_I2C_NXP_TDA998X=m
> > > CONFIG_DRM_I2C_NXP_TDA9950=m
> > > # end of I2C encoder or helper chips
> > > 
> > > #
> > > # ARM devices
> > > #
> > > # end of ARM devices
> > > 
> > > CONFIG_DRM_RADEON=m
> > > # CONFIG_DRM_RADEON_USERPTR is not set
> > > CONFIG_DRM_AMDGPU=m
> > > CONFIG_DRM_AMDGPU_SI=y
> > > CONFIG_DRM_AMDGPU_CIK=y
> > > CONFIG_DRM_AMDGPU_USERPTR=y
> > > # CONFIG_DRM_AMDGPU_GART_DEBUGFS is not set
> > > 
> > > #
> > > # ACP (Audio CoProcessor) Configuration
> > > #
> > > CONFIG_DRM_AMD_ACP=y
> > > # end of ACP (Audio CoProcessor) Configuration
> > > 
> > > #
> > > # Display Engine Configuration
> > > #
> > > CONFIG_DRM_AMD_DC=y
> > > CONFIG_DRM_AMD_DC_DCN1_0=y
> > > CONFIG_DRM_AMD_DC_DCN2_0=y
> > > # CONFIG_DRM_AMD_DC_DCN2_1 is not set
> > > CONFIG_DRM_AMD_DC_DSC_SUPPORT=y
> > > # CONFIG_DRM_AMD_DC_HDCP is not set
> > > # CONFIG_DEBUG_KERNEL_DC is not set
> > > # end of Display Engine Configuration
> > > 
> > > CONFIG_HSA_AMD=y
> > > CONFIG_DRM_NOUVEAU=m
> > > # CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT is not set
> > > CONFIG_NOUVEAU_DEBUG=5
> > > CONFIG_NOUVEAU_DEBUG_DEFAULT=3
> > > # CONFIG_NOUVEAU_DEBUG_MMU is not set
> > > CONFIG_DRM_NOUVEAU_BACKLIGHT=y
> > > # CONFIG_DRM_NOUVEAU_SVM is not set
> > > CONFIG_DRM_I915=m
> > > # CONFIG_DRM_I915_ALPHA_SUPPORT is not set
> > > CONFIG_DRM_I915_FORCE_PROBE=""
> > > CONFIG_DRM_I915_CAPTURE_ERROR=y
> > > CONFIG_DRM_I915_COMPRESS_ERROR=y
> > > CONFIG_DRM_I915_USERPTR=y
> > > CONFIG_DRM_I915_GVT=y
> > > CONFIG_DRM_I915_GVT_KVMGT=m
> > > 
> > > #
> > > # drm/i915 Debugging
> > > #
> > > # CONFIG_DRM_I915_WERROR is not set
> > > # CONFIG_DRM_I915_DEBUG is not set
> > > # CONFIG_DRM_I915_DEBUG_MMIO is not set
> > > # CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
> > > # CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
> > > # CONFIG_DRM_I915_DEBUG_GUC is not set
> > > # CONFIG_DRM_I915_SELFTEST is not set
> > > # CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
> > > # CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
> > > # CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
> > > # end of drm/i915 Debugging
> > > 
> > > #
> > > # drm/i915 Profile Guided Optimisation
> > > #
> > > CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
> > > CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
> > > CONFIG_DRM_I915_PREEMPT_TIMEOUT=100
> > > CONFIG_DRM_I915_SPIN_REQUEST=5
> > > CONFIG_DRM_I915_STOP_TIMEOUT=100
> > > CONFIG_DRM_I915_TIMESLICE_DURATION=1
> > > # end of drm/i915 Profile Guided Optimisation
> > > 
> > > CONFIG_DRM_VGEM=m
> > > CONFIG_DRM_VKMS=m
> > > CONFIG_DRM_VMWGFX=m
> > > CONFIG_DRM_VMWGFX_FBCON=y
> > > CONFIG_DRM_GMA500=m
> > > CONFIG_DRM_GMA600=y
> > > CONFIG_DRM_GMA3600=y
> > > CONFIG_DRM_UDL=m
> > > CONFIG_DRM_AST=m
> > > CONFIG_DRM_MGAG200=m
> > > CONFIG_DRM_CIRRUS_QEMU=m
> > > CONFIG_DRM_QXL=m
> > > CONFIG_DRM_BOCHS=m
> > > CONFIG_DRM_VIRTIO_GPU=m
> > > CONFIG_DRM_PANEL=y
> > > 
> > > #
> > > # Display Panels
> > > #
> > > CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
> > > # end of Display Panels
> > > 
> > > CONFIG_DRM_BRIDGE=y
> > > CONFIG_DRM_PANEL_BRIDGE=y
> > > 
> > > #
> > > # Display Interface Bridges
> > > #
> > > CONFIG_DRM_ANALOGIX_ANX78XX=m
> > > # end of Display Interface Bridges
> > > 
> > > # CONFIG_DRM_ETNAVIV is not set
> > > # CONFIG_DRM_GM12U320 is not set
> > > CONFIG_TINYDRM_HX8357D=m
> > > CONFIG_TINYDRM_ILI9225=m
> > > CONFIG_TINYDRM_ILI9341=m
> > > CONFIG_TINYDRM_MI0283QT=m
> > > CONFIG_TINYDRM_REPAPER=m
> > > CONFIG_TINYDRM_ST7586=m
> > > CONFIG_TINYDRM_ST7735R=m
> > > CONFIG_DRM_XEN=y
> > > CONFIG_DRM_XEN_FRONTEND=m
> > > CONFIG_DRM_VBOXVIDEO=m
> > > # CONFIG_DRM_LEGACY is not set
> > > CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
> > > 
> > > #
> > > # Frame buffer Devices
> > > #
> > > CONFIG_FB_CMDLINE=y
> > > CONFIG_FB_NOTIFY=y
> > > CONFIG_FB=y
> > > CONFIG_FIRMWARE_EDID=y
> > > CONFIG_FB_DDC=m
> > > CONFIG_FB_BOOT_VESA_SUPPORT=y
> > > CONFIG_FB_CFB_FILLRECT=y
> > > CONFIG_FB_CFB_COPYAREA=y
> > > CONFIG_FB_CFB_IMAGEBLIT=y
> > > CONFIG_FB_SYS_FILLRECT=m
> > > CONFIG_FB_SYS_COPYAREA=m
> > > CONFIG_FB_SYS_IMAGEBLIT=m
> > > # CONFIG_FB_FOREIGN_ENDIAN is not set
> > > CONFIG_FB_SYS_FOPS=m
> > > CONFIG_FB_DEFERRED_IO=y
> > > CONFIG_FB_HECUBA=m
> > > CONFIG_FB_SVGALIB=m
> > > CONFIG_FB_BACKLIGHT=m
> > > CONFIG_FB_MODE_HELPERS=y
> > > CONFIG_FB_TILEBLITTING=y
> > > 
> > > #
> > > # Frame buffer hardware drivers
> > > #
> > > CONFIG_FB_CIRRUS=m
> > > CONFIG_FB_PM2=m
> > > CONFIG_FB_PM2_FIFO_DISCONNECT=y
> > > CONFIG_FB_CYBER2000=m
> > > CONFIG_FB_CYBER2000_DDC=y
> > > CONFIG_FB_ARC=m
> > > CONFIG_FB_ASILIANT=y
> > > CONFIG_FB_IMSTT=y
> > > CONFIG_FB_VGA16=m
> > > CONFIG_FB_UVESA=m
> > > CONFIG_FB_VESA=y
> > > CONFIG_FB_EFI=y
> > > CONFIG_FB_N411=m
> > > CONFIG_FB_HGA=m
> > > CONFIG_FB_OPENCORES=m
> > > CONFIG_FB_S1D13XXX=m
> > > CONFIG_FB_NVIDIA=m
> > > CONFIG_FB_NVIDIA_I2C=y
> > > # CONFIG_FB_NVIDIA_DEBUG is not set
> > > CONFIG_FB_NVIDIA_BACKLIGHT=y
> > > CONFIG_FB_RIVA=m
> > > CONFIG_FB_RIVA_I2C=y
> > > # CONFIG_FB_RIVA_DEBUG is not set
> > > CONFIG_FB_RIVA_BACKLIGHT=y
> > > CONFIG_FB_I740=m
> > > CONFIG_FB_LE80578=m
> > > CONFIG_FB_CARILLO_RANCH=m
> > > CONFIG_FB_INTEL=m
> > > # CONFIG_FB_INTEL_DEBUG is not set
> > > CONFIG_FB_INTEL_I2C=y
> > > CONFIG_FB_MATROX=m
> > > CONFIG_FB_MATROX_MILLENIUM=y
> > > CONFIG_FB_MATROX_MYSTIQUE=y
> > > CONFIG_FB_MATROX_G=y
> > > CONFIG_FB_MATROX_I2C=m
> > > CONFIG_FB_MATROX_MAVEN=m
> > > CONFIG_FB_RADEON=m
> > > CONFIG_FB_RADEON_I2C=y
> > > CONFIG_FB_RADEON_BACKLIGHT=y
> > > # CONFIG_FB_RADEON_DEBUG is not set
> > > CONFIG_FB_ATY128=m
> > > CONFIG_FB_ATY128_BACKLIGHT=y
> > > CONFIG_FB_ATY=m
> > > CONFIG_FB_ATY_CT=y
> > > # CONFIG_FB_ATY_GENERIC_LCD is not set
> > > CONFIG_FB_ATY_GX=y
> > > CONFIG_FB_ATY_BACKLIGHT=y
> > > CONFIG_FB_S3=m
> > > CONFIG_FB_S3_DDC=y
> > > CONFIG_FB_SAVAGE=m
> > > CONFIG_FB_SAVAGE_I2C=y
> > > # CONFIG_FB_SAVAGE_ACCEL is not set
> > > CONFIG_FB_SIS=m
> > > CONFIG_FB_SIS_300=y
> > > CONFIG_FB_SIS_315=y
> > > CONFIG_FB_VIA=m
> > > # CONFIG_FB_VIA_DIRECT_PROCFS is not set
> > > CONFIG_FB_VIA_X_COMPATIBILITY=y
> > > CONFIG_FB_NEOMAGIC=m
> > > CONFIG_FB_KYRO=m
> > > CONFIG_FB_3DFX=m
> > > # CONFIG_FB_3DFX_ACCEL is not set
> > > # CONFIG_FB_3DFX_I2C is not set
> > > CONFIG_FB_VOODOO1=m
> > > CONFIG_FB_VT8623=m
> > > CONFIG_FB_TRIDENT=m
> > > CONFIG_FB_ARK=m
> > > CONFIG_FB_PM3=m
> > > CONFIG_FB_CARMINE=m
> > > CONFIG_FB_CARMINE_DRAM_EVAL=y
> > > # CONFIG_CARMINE_DRAM_CUSTOM is not set
> > > CONFIG_FB_SM501=m
> > > CONFIG_FB_SMSCUFX=m
> > > CONFIG_FB_UDL=m
> > > # CONFIG_FB_IBM_GXT4500 is not set
> > > # CONFIG_FB_VIRTUAL is not set
> > > CONFIG_XEN_FBDEV_FRONTEND=m
> > > CONFIG_FB_METRONOME=m
> > > CONFIG_FB_MB862XX=m
> > > CONFIG_FB_MB862XX_PCI_GDC=y
> > > CONFIG_FB_MB862XX_I2C=y
> > > CONFIG_FB_HYPERV=m
> > > CONFIG_FB_SIMPLE=y
> > > CONFIG_FB_SM712=m
> > > # end of Frame buffer Devices
> > > 
> > > #
> > > # Backlight & LCD device support
> > > #
> > > CONFIG_LCD_CLASS_DEVICE=m
> > > CONFIG_LCD_L4F00242T03=m
> > > CONFIG_LCD_LMS283GF05=m
> > > CONFIG_LCD_LTV350QV=m
> > > CONFIG_LCD_ILI922X=m
> > > CONFIG_LCD_ILI9320=m
> > > CONFIG_LCD_TDO24M=m
> > > CONFIG_LCD_VGG2432A4=m
> > > CONFIG_LCD_PLATFORM=m
> > > CONFIG_LCD_AMS369FG06=m
> > > CONFIG_LCD_LMS501KF03=m
> > > CONFIG_LCD_HX8357=m
> > > CONFIG_LCD_OTM3225A=m
> > > CONFIG_BACKLIGHT_CLASS_DEVICE=y
> > > CONFIG_BACKLIGHT_GENERIC=m
> > > CONFIG_BACKLIGHT_LM3533=m
> > > CONFIG_BACKLIGHT_CARILLO_RANCH=m
> > > CONFIG_BACKLIGHT_PWM=m
> > > CONFIG_BACKLIGHT_DA903X=m
> > > CONFIG_BACKLIGHT_DA9052=m
> > > CONFIG_BACKLIGHT_MAX8925=m
> > > CONFIG_BACKLIGHT_APPLE=m
> > > # CONFIG_BACKLIGHT_QCOM_WLED is not set
> > > CONFIG_BACKLIGHT_SAHARA=m
> > > CONFIG_BACKLIGHT_WM831X=m
> > > CONFIG_BACKLIGHT_ADP5520=m
> > > CONFIG_BACKLIGHT_ADP8860=m
> > > CONFIG_BACKLIGHT_ADP8870=m
> > > CONFIG_BACKLIGHT_88PM860X=m
> > > CONFIG_BACKLIGHT_PCF50633=m
> > > CONFIG_BACKLIGHT_AAT2870=m
> > > CONFIG_BACKLIGHT_LM3630A=m
> > > CONFIG_BACKLIGHT_LM3639=m
> > > CONFIG_BACKLIGHT_LP855X=m
> > > CONFIG_BACKLIGHT_LP8788=m
> > > CONFIG_BACKLIGHT_PANDORA=m
> > > CONFIG_BACKLIGHT_SKY81452=m
> > > CONFIG_BACKLIGHT_AS3711=m
> > > CONFIG_BACKLIGHT_GPIO=m
> > > CONFIG_BACKLIGHT_LV5207LP=m
> > > CONFIG_BACKLIGHT_BD6107=m
> > > CONFIG_BACKLIGHT_ARCXCNN=m
> > > CONFIG_BACKLIGHT_RAVE_SP=m
> > > # end of Backlight & LCD device support
> > > 
> > > CONFIG_VGASTATE=m
> > > CONFIG_VIDEOMODE_HELPERS=y
> > > CONFIG_HDMI=y
> > > 
> > > #
> > > # Console display driver support
> > > #
> > > CONFIG_VGA_CONSOLE=y
> > > # CONFIG_VGACON_SOFT_SCROLLBACK is not set
> > > CONFIG_DUMMY_CONSOLE=y
> > > CONFIG_DUMMY_CONSOLE_COLUMNS=80
> > > CONFIG_DUMMY_CONSOLE_ROWS=25
> > > CONFIG_FRAMEBUFFER_CONSOLE=y
> > > CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
> > > CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
> > > # CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
> > > # end of Console display driver support
> > > 
> > > # CONFIG_LOGO is not set
> > > # end of Graphics support
> > > 
> > > CONFIG_SOUND=m
> > > CONFIG_SOUND_OSS_CORE=y
> > > # CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
> > > CONFIG_SND=m
> > > CONFIG_SND_TIMER=m
> > > CONFIG_SND_PCM=m
> > > CONFIG_SND_PCM_ELD=y
> > > CONFIG_SND_PCM_IEC958=y
> > > CONFIG_SND_DMAENGINE_PCM=m
> > > CONFIG_SND_HWDEP=m
> > > CONFIG_SND_SEQ_DEVICE=m
> > > CONFIG_SND_RAWMIDI=m
> > > CONFIG_SND_COMPRESS_OFFLOAD=m
> > > CONFIG_SND_JACK=y
> > > CONFIG_SND_JACK_INPUT_DEV=y
> > > CONFIG_SND_OSSEMUL=y
> > > CONFIG_SND_MIXER_OSS=m
> > > # CONFIG_SND_PCM_OSS is not set
> > > CONFIG_SND_PCM_TIMER=y
> > > CONFIG_SND_HRTIMER=m
> > > CONFIG_SND_DYNAMIC_MINORS=y
> > > CONFIG_SND_MAX_CARDS=32
> > > CONFIG_SND_SUPPORT_OLD_API=y
> > > CONFIG_SND_PROC_FS=y
> > > CONFIG_SND_VERBOSE_PROCFS=y
> > > # CONFIG_SND_VERBOSE_PRINTK is not set
> > > # CONFIG_SND_DEBUG is not set
> > > CONFIG_SND_VMASTER=y
> > > CONFIG_SND_DMA_SGBUF=y
> > > CONFIG_SND_SEQUENCER=m
> > > CONFIG_SND_SEQ_DUMMY=m
> > > # CONFIG_SND_SEQUENCER_OSS is not set
> > > CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
> > > CONFIG_SND_SEQ_MIDI_EVENT=m
> > > CONFIG_SND_SEQ_MIDI=m
> > > CONFIG_SND_SEQ_MIDI_EMUL=m
> > > CONFIG_SND_SEQ_VIRMIDI=m
> > > CONFIG_SND_MPU401_UART=m
> > > CONFIG_SND_OPL3_LIB=m
> > > CONFIG_SND_OPL3_LIB_SEQ=m
> > > CONFIG_SND_VX_LIB=m
> > > CONFIG_SND_AC97_CODEC=m
> > > CONFIG_SND_DRIVERS=y
> > > CONFIG_SND_PCSP=m
> > > CONFIG_SND_DUMMY=m
> > > CONFIG_SND_ALOOP=m
> > > CONFIG_SND_VIRMIDI=m
> > > CONFIG_SND_MTPAV=m
> > > CONFIG_SND_MTS64=m
> > > CONFIG_SND_SERIAL_U16550=m
> > > CONFIG_SND_MPU401=m
> > > CONFIG_SND_PORTMAN2X4=m
> > > CONFIG_SND_AC97_POWER_SAVE=y
> > > CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
> > > CONFIG_SND_SB_COMMON=m
> > > CONFIG_SND_PCI=y
> > > CONFIG_SND_AD1889=m
> > > CONFIG_SND_ALS300=m
> > > CONFIG_SND_ALS4000=m
> > > CONFIG_SND_ALI5451=m
> > > CONFIG_SND_ASIHPI=m
> > > CONFIG_SND_ATIIXP=m
> > > CONFIG_SND_ATIIXP_MODEM=m
> > > CONFIG_SND_AU8810=m
> > > CONFIG_SND_AU8820=m
> > > CONFIG_SND_AU8830=m
> > > CONFIG_SND_AW2=m
> > > CONFIG_SND_AZT3328=m
> > > CONFIG_SND_BT87X=m
> > > # CONFIG_SND_BT87X_OVERCLOCK is not set
> > > CONFIG_SND_CA0106=m
> > > CONFIG_SND_CMIPCI=m
> > > CONFIG_SND_OXYGEN_LIB=m
> > > CONFIG_SND_OXYGEN=m
> > > CONFIG_SND_CS4281=m
> > > CONFIG_SND_CS46XX=m
> > > CONFIG_SND_CS46XX_NEW_DSP=y
> > > CONFIG_SND_CTXFI=m
> > > CONFIG_SND_DARLA20=m
> > > CONFIG_SND_GINA20=m
> > > CONFIG_SND_LAYLA20=m
> > > CONFIG_SND_DARLA24=m
> > > CONFIG_SND_GINA24=m
> > > CONFIG_SND_LAYLA24=m
> > > CONFIG_SND_MONA=m
> > > CONFIG_SND_MIA=m
> > > CONFIG_SND_ECHO3G=m
> > > CONFIG_SND_INDIGO=m
> > > CONFIG_SND_INDIGOIO=m
> > > CONFIG_SND_INDIGODJ=m
> > > CONFIG_SND_INDIGOIOX=m
> > > CONFIG_SND_INDIGODJX=m
> > > CONFIG_SND_EMU10K1=m
> > > CONFIG_SND_EMU10K1_SEQ=m
> > > CONFIG_SND_EMU10K1X=m
> > > CONFIG_SND_ENS1370=m
> > > CONFIG_SND_ENS1371=m
> > > CONFIG_SND_ES1938=m
> > > CONFIG_SND_ES1968=m
> > > CONFIG_SND_ES1968_INPUT=y
> > > CONFIG_SND_ES1968_RADIO=y
> > > CONFIG_SND_FM801=m
> > > CONFIG_SND_FM801_TEA575X_BOOL=y
> > > CONFIG_SND_HDSP=m
> > > CONFIG_SND_HDSPM=m
> > > CONFIG_SND_ICE1712=m
> > > CONFIG_SND_ICE1724=m
> > > CONFIG_SND_INTEL8X0=m
> > > CONFIG_SND_INTEL8X0M=m
> > > CONFIG_SND_KORG1212=m
> > > CONFIG_SND_LOLA=m
> > > CONFIG_SND_LX6464ES=m
> > > CONFIG_SND_MAESTRO3=m
> > > CONFIG_SND_MAESTRO3_INPUT=y
> > > CONFIG_SND_MIXART=m
> > > CONFIG_SND_NM256=m
> > > CONFIG_SND_PCXHR=m
> > > CONFIG_SND_RIPTIDE=m
> > > CONFIG_SND_RME32=m
> > > CONFIG_SND_RME96=m
> > > CONFIG_SND_RME9652=m
> > > CONFIG_SND_SONICVIBES=m
> > > CONFIG_SND_TRIDENT=m
> > > CONFIG_SND_VIA82XX=m
> > > CONFIG_SND_VIA82XX_MODEM=m
> > > CONFIG_SND_VIRTUOSO=m
> > > CONFIG_SND_VX222=m
> > > CONFIG_SND_YMFPCI=m
> > > 
> > > #
> > > # HD-Audio
> > > #
> > > CONFIG_SND_HDA=m
> > > CONFIG_SND_HDA_INTEL=m
> > > CONFIG_SND_HDA_HWDEP=y
> > > CONFIG_SND_HDA_RECONFIG=y
> > > CONFIG_SND_HDA_INPUT_BEEP=y
> > > CONFIG_SND_HDA_INPUT_BEEP_MODE=0
> > > CONFIG_SND_HDA_PATCH_LOADER=y
> > > CONFIG_SND_HDA_CODEC_REALTEK=m
> > > CONFIG_SND_HDA_CODEC_ANALOG=m
> > > CONFIG_SND_HDA_CODEC_SIGMATEL=m
> > > CONFIG_SND_HDA_CODEC_VIA=m
> > > CONFIG_SND_HDA_CODEC_HDMI=m
> > > CONFIG_SND_HDA_CODEC_CIRRUS=m
> > > CONFIG_SND_HDA_CODEC_CONEXANT=m
> > > CONFIG_SND_HDA_CODEC_CA0110=m
> > > CONFIG_SND_HDA_CODEC_CA0132=m
> > > CONFIG_SND_HDA_CODEC_CA0132_DSP=y
> > > CONFIG_SND_HDA_CODEC_CMEDIA=m
> > > CONFIG_SND_HDA_CODEC_SI3054=m
> > > CONFIG_SND_HDA_GENERIC=m
> > > CONFIG_SND_HDA_POWER_SAVE_DEFAULT=1
> > > # end of HD-Audio
> > > 
> > > CONFIG_SND_HDA_CORE=m
> > > CONFIG_SND_HDA_DSP_LOADER=y
> > > CONFIG_SND_HDA_COMPONENT=y
> > > CONFIG_SND_HDA_I915=y
> > > CONFIG_SND_HDA_EXT_CORE=m
> > > CONFIG_SND_HDA_PREALLOC_SIZE=64
> > > CONFIG_SND_INTEL_NHLT=y
> > > CONFIG_SND_INTEL_DSP_CONFIG=m
> > > CONFIG_SND_SPI=y
> > > CONFIG_SND_USB=y
> > > CONFIG_SND_USB_AUDIO=m
> > > CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
> > > CONFIG_SND_USB_UA101=m
> > > CONFIG_SND_USB_USX2Y=m
> > > CONFIG_SND_USB_CAIAQ=m
> > > CONFIG_SND_USB_CAIAQ_INPUT=y
> > > CONFIG_SND_USB_US122L=m
> > > CONFIG_SND_USB_6FIRE=m
> > > CONFIG_SND_USB_HIFACE=m
> > > CONFIG_SND_BCD2000=m
> > > CONFIG_SND_USB_LINE6=m
> > > CONFIG_SND_USB_POD=m
> > > CONFIG_SND_USB_PODHD=m
> > > CONFIG_SND_USB_TONEPORT=m
> > > CONFIG_SND_USB_VARIAX=m
> > > CONFIG_SND_FIREWIRE=y
> > > CONFIG_SND_FIREWIRE_LIB=m
> > > CONFIG_SND_DICE=m
> > > CONFIG_SND_OXFW=m
> > > CONFIG_SND_ISIGHT=m
> > > CONFIG_SND_FIREWORKS=m
> > > CONFIG_SND_BEBOB=m
> > > CONFIG_SND_FIREWIRE_DIGI00X=m
> > > CONFIG_SND_FIREWIRE_TASCAM=m
> > > CONFIG_SND_FIREWIRE_MOTU=m
> > > CONFIG_SND_FIREFACE=m
> > > CONFIG_SND_PCMCIA=y
> > > CONFIG_SND_VXPOCKET=m
> > > CONFIG_SND_PDAUDIOCF=m
> > > CONFIG_SND_SOC=m
> > > CONFIG_SND_SOC_AC97_BUS=y
> > > CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
> > > CONFIG_SND_SOC_COMPRESS=y
> > > CONFIG_SND_SOC_TOPOLOGY=y
> > > CONFIG_SND_SOC_ACPI=m
> > > CONFIG_SND_SOC_AMD_ACP=m
> > > CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH=m
> > > CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=m
> > > CONFIG_SND_SOC_AMD_ACP3x=m
> > > CONFIG_SND_ATMEL_SOC=m
> > > CONFIG_SND_DESIGNWARE_I2S=m
> > > CONFIG_SND_DESIGNWARE_PCM=y
> > > 
> > > #
> > > # SoC Audio for Freescale CPUs
> > > #
> > > 
> > > #
> > > # Common SoC Audio options for Freescale CPUs:
> > > #
> > > CONFIG_SND_SOC_FSL_ASRC=m
> > > CONFIG_SND_SOC_FSL_SAI=m
> > > # CONFIG_SND_SOC_FSL_MQS is not set
> > > CONFIG_SND_SOC_FSL_AUDMIX=m
> > > CONFIG_SND_SOC_FSL_SSI=m
> > > CONFIG_SND_SOC_FSL_SPDIF=m
> > > CONFIG_SND_SOC_FSL_ESAI=m
> > > CONFIG_SND_SOC_FSL_MICFIL=m
> > > CONFIG_SND_SOC_IMX_AUDMUX=m
> > > # end of SoC Audio for Freescale CPUs
> > > 
> > > CONFIG_SND_I2S_HI6210_I2S=m
> > > CONFIG_SND_SOC_IMG=y
> > > CONFIG_SND_SOC_IMG_I2S_IN=m
> > > CONFIG_SND_SOC_IMG_I2S_OUT=m
> > > CONFIG_SND_SOC_IMG_PARALLEL_OUT=m
> > > CONFIG_SND_SOC_IMG_SPDIF_IN=m
> > > CONFIG_SND_SOC_IMG_SPDIF_OUT=m
> > > CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=m
> > > CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
> > > CONFIG_SND_SST_IPC=m
> > > CONFIG_SND_SST_IPC_PCI=m
> > > CONFIG_SND_SST_IPC_ACPI=m
> > > CONFIG_SND_SOC_INTEL_SST_ACPI=m
> > > CONFIG_SND_SOC_INTEL_SST=m
> > > CONFIG_SND_SOC_INTEL_SST_FIRMWARE=m
> > > CONFIG_SND_SOC_INTEL_HASWELL=m
> > > CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
> > > CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI=m
> > > CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
> > > CONFIG_SND_SOC_INTEL_SKYLAKE=m
> > > CONFIG_SND_SOC_INTEL_SKL=m
> > > CONFIG_SND_SOC_INTEL_APL=m
> > > CONFIG_SND_SOC_INTEL_KBL=m
> > > CONFIG_SND_SOC_INTEL_GLK=m
> > > CONFIG_SND_SOC_INTEL_CNL=m
> > > CONFIG_SND_SOC_INTEL_CFL=m
> > > CONFIG_SND_SOC_INTEL_CML_H=m
> > > CONFIG_SND_SOC_INTEL_CML_LP=m
> > > CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
> > > CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
> > > CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC=y
> > > CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
> > > CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
> > > CONFIG_SND_SOC_INTEL_MACH=y
> > > CONFIG_SND_SOC_INTEL_HASWELL_MACH=m
> > > CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=m
> > > CONFIG_SND_SOC_INTEL_BROADWELL_MACH=m
> > > CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
> > > CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
> > > CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
> > > CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
> > > CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
> > > CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH=m
> > > CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH=m
> > > CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
> > > CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
> > > # CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH is not set
> > > CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
> > > CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
> > > CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
> > > CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=m
> > > CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON=m
> > > CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
> > > CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
> > > CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
> > > CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
> > > CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH=m
> > > CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH=m
> > > CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH=m
> > > # CONFIG_SND_SOC_INTEL_GLK_DA7219_MAX98357A_MACH is not set
> > > CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH=m
> > > CONFIG_SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=m
> > > CONFIG_SND_SOC_INTEL_SOF_RT5682_MACH=m
> > > # CONFIG_SND_SOC_INTEL_CML_LP_DA7219_MAX98357A_MACH is not set
> > > # CONFIG_SND_SOC_INTEL_SOF_CML_RT1011_RT5682_MACH is not set
> > > CONFIG_SND_SOC_MTK_BTCVSD=m
> > > CONFIG_SND_SOC_SOF_TOPLEVEL=y
> > > CONFIG_SND_SOC_SOF_PCI=m
> > > CONFIG_SND_SOC_SOF_ACPI=m
> > > # CONFIG_SND_SOC_SOF_DEVELOPER_SUPPORT is not set
> > > CONFIG_SND_SOC_SOF=m
> > > CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE=y
> > > CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=y
> > > CONFIG_SND_SOC_SOF_INTEL_ACPI=m
> > > CONFIG_SND_SOC_SOF_INTEL_PCI=m
> > > CONFIG_SND_SOC_SOF_INTEL_HIFI_EP_IPC=m
> > > CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP=m
> > > CONFIG_SND_SOC_SOF_INTEL_COMMON=m
> > > CONFIG_SND_SOC_SOF_MERRIFIELD_SUPPORT=y
> > > CONFIG_SND_SOC_SOF_MERRIFIELD=m
> > > CONFIG_SND_SOC_SOF_APOLLOLAKE_SUPPORT=y
> > > CONFIG_SND_SOC_SOF_APOLLOLAKE=m
> > > CONFIG_SND_SOC_SOF_GEMINILAKE_SUPPORT=y
> > > CONFIG_SND_SOC_SOF_GEMINILAKE=m
> > > CONFIG_SND_SOC_SOF_CANNONLAKE_SUPPORT=y
> > > CONFIG_SND_SOC_SOF_CANNONLAKE=m
> > > CONFIG_SND_SOC_SOF_COFFEELAKE_SUPPORT=y
> > > CONFIG_SND_SOC_SOF_COFFEELAKE=m
> > > CONFIG_SND_SOC_SOF_ICELAKE_SUPPORT=y
> > > CONFIG_SND_SOC_SOF_ICELAKE=m
> > > CONFIG_SND_SOC_SOF_COMETLAKE_LP=m
> > > CONFIG_SND_SOC_SOF_COMETLAKE_LP_SUPPORT=y
> > > CONFIG_SND_SOC_SOF_COMETLAKE_H=m
> > > CONFIG_SND_SOC_SOF_COMETLAKE_H_SUPPORT=y
> > > # CONFIG_SND_SOC_SOF_TIGERLAKE_SUPPORT is not set
> > > # CONFIG_SND_SOC_SOF_ELKHARTLAKE_SUPPORT is not set
> > > # CONFIG_SND_SOC_SOF_JASPERLAKE_SUPPORT is not set
> > > CONFIG_SND_SOC_SOF_HDA_COMMON=m
> > > CONFIG_SND_SOC_SOF_HDA_LINK=y
> > > CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC=y
> > > # CONFIG_SND_SOC_SOF_HDA_ALWAYS_ENABLE_DMI_L1 is not set
> > > # CONFIG_SND_SOC_SOF_HDA_COMMON_HDMI_CODEC is not set
> > > CONFIG_SND_SOC_SOF_HDA_LINK_BASELINE=m
> > > CONFIG_SND_SOC_SOF_HDA=m
> > > CONFIG_SND_SOC_SOF_XTENSA=m
> > > 
> > > #
> > > # STMicroelectronics STM32 SOC audio support
> > > #
> > > # end of STMicroelectronics STM32 SOC audio support
> > > 
> > > CONFIG_SND_SOC_XILINX_I2S=m
> > > CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=m
> > > CONFIG_SND_SOC_XILINX_SPDIF=m
> > > CONFIG_SND_SOC_XTFPGA_I2S=m
> > > CONFIG_ZX_TDM=m
> > > CONFIG_SND_SOC_I2C_AND_SPI=m
> > > 
> > > #
> > > # CODEC drivers
> > > #
> > > CONFIG_SND_SOC_AC97_CODEC=m
> > > CONFIG_SND_SOC_ADAU_UTILS=m
> > > CONFIG_SND_SOC_ADAU1701=m
> > > CONFIG_SND_SOC_ADAU17X1=m
> > > CONFIG_SND_SOC_ADAU1761=m
> > > CONFIG_SND_SOC_ADAU1761_I2C=m
> > > CONFIG_SND_SOC_ADAU1761_SPI=m
> > > CONFIG_SND_SOC_ADAU7002=m
> > > # CONFIG_SND_SOC_ADAU7118_HW is not set
> > > # CONFIG_SND_SOC_ADAU7118_I2C is not set
> > > CONFIG_SND_SOC_AK4104=m
> > > CONFIG_SND_SOC_AK4118=m
> > > CONFIG_SND_SOC_AK4458=m
> > > CONFIG_SND_SOC_AK4554=m
> > > CONFIG_SND_SOC_AK4613=m
> > > CONFIG_SND_SOC_AK4642=m
> > > CONFIG_SND_SOC_AK5386=m
> > > CONFIG_SND_SOC_AK5558=m
> > > CONFIG_SND_SOC_ALC5623=m
> > > CONFIG_SND_SOC_BD28623=m
> > > CONFIG_SND_SOC_BT_SCO=m
> > > CONFIG_SND_SOC_CROS_EC_CODEC=m
> > > CONFIG_SND_SOC_CS35L32=m
> > > CONFIG_SND_SOC_CS35L33=m
> > > CONFIG_SND_SOC_CS35L34=m
> > > CONFIG_SND_SOC_CS35L35=m
> > > CONFIG_SND_SOC_CS35L36=m
> > > CONFIG_SND_SOC_CS42L42=m
> > > CONFIG_SND_SOC_CS42L51=m
> > > CONFIG_SND_SOC_CS42L51_I2C=m
> > > CONFIG_SND_SOC_CS42L52=m
> > > CONFIG_SND_SOC_CS42L56=m
> > > CONFIG_SND_SOC_CS42L73=m
> > > CONFIG_SND_SOC_CS4265=m
> > > CONFIG_SND_SOC_CS4270=m
> > > CONFIG_SND_SOC_CS4271=m
> > > CONFIG_SND_SOC_CS4271_I2C=m
> > > CONFIG_SND_SOC_CS4271_SPI=m
> > > CONFIG_SND_SOC_CS42XX8=m
> > > CONFIG_SND_SOC_CS42XX8_I2C=m
> > > CONFIG_SND_SOC_CS43130=m
> > > CONFIG_SND_SOC_CS4341=m
> > > CONFIG_SND_SOC_CS4349=m
> > > CONFIG_SND_SOC_CS53L30=m
> > > CONFIG_SND_SOC_CX2072X=m
> > > CONFIG_SND_SOC_DA7213=m
> > > CONFIG_SND_SOC_DA7219=m
> > > CONFIG_SND_SOC_DMIC=m
> > > CONFIG_SND_SOC_HDMI_CODEC=m
> > > CONFIG_SND_SOC_ES7134=m
> > > CONFIG_SND_SOC_ES7241=m
> > > CONFIG_SND_SOC_ES8316=m
> > > CONFIG_SND_SOC_ES8328=m
> > > CONFIG_SND_SOC_ES8328_I2C=m
> > > CONFIG_SND_SOC_ES8328_SPI=m
> > > CONFIG_SND_SOC_GTM601=m
> > > CONFIG_SND_SOC_HDAC_HDMI=m
> > > CONFIG_SND_SOC_HDAC_HDA=m
> > > CONFIG_SND_SOC_INNO_RK3036=m
> > > CONFIG_SND_SOC_MAX98088=m
> > > CONFIG_SND_SOC_MAX98090=m
> > > CONFIG_SND_SOC_MAX98357A=m
> > > CONFIG_SND_SOC_MAX98504=m
> > > CONFIG_SND_SOC_MAX9867=m
> > > CONFIG_SND_SOC_MAX98927=m
> > > CONFIG_SND_SOC_MAX98373=m
> > > CONFIG_SND_SOC_MAX9860=m
> > > CONFIG_SND_SOC_MSM8916_WCD_ANALOG=m
> > > CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
> > > CONFIG_SND_SOC_PCM1681=m
> > > CONFIG_SND_SOC_PCM1789=m
> > > CONFIG_SND_SOC_PCM1789_I2C=m
> > > CONFIG_SND_SOC_PCM179X=m
> > > CONFIG_SND_SOC_PCM179X_I2C=m
> > > CONFIG_SND_SOC_PCM179X_SPI=m
> > > CONFIG_SND_SOC_PCM186X=m
> > > CONFIG_SND_SOC_PCM186X_I2C=m
> > > CONFIG_SND_SOC_PCM186X_SPI=m
> > > CONFIG_SND_SOC_PCM3060=m
> > > CONFIG_SND_SOC_PCM3060_I2C=m
> > > CONFIG_SND_SOC_PCM3060_SPI=m
> > > CONFIG_SND_SOC_PCM3168A=m
> > > CONFIG_SND_SOC_PCM3168A_I2C=m
> > > CONFIG_SND_SOC_PCM3168A_SPI=m
> > > CONFIG_SND_SOC_PCM512x=m
> > > CONFIG_SND_SOC_PCM512x_I2C=m
> > > CONFIG_SND_SOC_PCM512x_SPI=m
> > > CONFIG_SND_SOC_RK3328=m
> > > CONFIG_SND_SOC_RL6231=m
> > > CONFIG_SND_SOC_RL6347A=m
> > > CONFIG_SND_SOC_RT286=m
> > > CONFIG_SND_SOC_RT298=m
> > > CONFIG_SND_SOC_RT5514=m
> > > CONFIG_SND_SOC_RT5514_SPI=m
> > > CONFIG_SND_SOC_RT5616=m
> > > CONFIG_SND_SOC_RT5631=m
> > > CONFIG_SND_SOC_RT5640=m
> > > CONFIG_SND_SOC_RT5645=m
> > > CONFIG_SND_SOC_RT5651=m
> > > CONFIG_SND_SOC_RT5660=m
> > > CONFIG_SND_SOC_RT5663=m
> > > CONFIG_SND_SOC_RT5670=m
> > > CONFIG_SND_SOC_RT5677=m
> > > CONFIG_SND_SOC_RT5677_SPI=m
> > > CONFIG_SND_SOC_RT5682=m
> > > CONFIG_SND_SOC_SGTL5000=m
> > > CONFIG_SND_SOC_SI476X=m
> > > CONFIG_SND_SOC_SIGMADSP=m
> > > CONFIG_SND_SOC_SIGMADSP_I2C=m
> > > CONFIG_SND_SOC_SIGMADSP_REGMAP=m
> > > CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
> > > CONFIG_SND_SOC_SIRF_AUDIO_CODEC=m
> > > CONFIG_SND_SOC_SPDIF=m
> > > CONFIG_SND_SOC_SSM2305=m
> > > CONFIG_SND_SOC_SSM2602=m
> > > CONFIG_SND_SOC_SSM2602_SPI=m
> > > CONFIG_SND_SOC_SSM2602_I2C=m
> > > CONFIG_SND_SOC_SSM4567=m
> > > CONFIG_SND_SOC_STA32X=m
> > > CONFIG_SND_SOC_STA350=m
> > > CONFIG_SND_SOC_STI_SAS=m
> > > CONFIG_SND_SOC_TAS2552=m
> > > # CONFIG_SND_SOC_TAS2562 is not set
> > > # CONFIG_SND_SOC_TAS2770 is not set
> > > CONFIG_SND_SOC_TAS5086=m
> > > CONFIG_SND_SOC_TAS571X=m
> > > CONFIG_SND_SOC_TAS5720=m
> > > CONFIG_SND_SOC_TAS6424=m
> > > CONFIG_SND_SOC_TDA7419=m
> > > CONFIG_SND_SOC_TFA9879=m
> > > CONFIG_SND_SOC_TLV320AIC23=m
> > > CONFIG_SND_SOC_TLV320AIC23_I2C=m
> > > CONFIG_SND_SOC_TLV320AIC23_SPI=m
> > > CONFIG_SND_SOC_TLV320AIC31XX=m
> > > CONFIG_SND_SOC_TLV320AIC32X4=m
> > > CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
> > > CONFIG_SND_SOC_TLV320AIC32X4_SPI=m
> > > CONFIG_SND_SOC_TLV320AIC3X=m
> > > CONFIG_SND_SOC_TS3A227E=m
> > > CONFIG_SND_SOC_TSCS42XX=m
> > > CONFIG_SND_SOC_TSCS454=m
> > > # CONFIG_SND_SOC_UDA1334 is not set
> > > CONFIG_SND_SOC_WCD9335=m
> > > CONFIG_SND_SOC_WM8510=m
> > > CONFIG_SND_SOC_WM8523=m
> > > CONFIG_SND_SOC_WM8524=m
> > > CONFIG_SND_SOC_WM8580=m
> > > CONFIG_SND_SOC_WM8711=m
> > > CONFIG_SND_SOC_WM8728=m
> > > CONFIG_SND_SOC_WM8731=m
> > > CONFIG_SND_SOC_WM8737=m
> > > CONFIG_SND_SOC_WM8741=m
> > > CONFIG_SND_SOC_WM8750=m
> > > CONFIG_SND_SOC_WM8753=m
> > > CONFIG_SND_SOC_WM8770=m
> > > CONFIG_SND_SOC_WM8776=m
> > > CONFIG_SND_SOC_WM8782=m
> > > CONFIG_SND_SOC_WM8804=m
> > > CONFIG_SND_SOC_WM8804_I2C=m
> > > CONFIG_SND_SOC_WM8804_SPI=m
> > > CONFIG_SND_SOC_WM8903=m
> > > CONFIG_SND_SOC_WM8904=m
> > > CONFIG_SND_SOC_WM8960=m
> > > CONFIG_SND_SOC_WM8962=m
> > > CONFIG_SND_SOC_WM8974=m
> > > CONFIG_SND_SOC_WM8978=m
> > > CONFIG_SND_SOC_WM8985=m
> > > CONFIG_SND_SOC_ZX_AUD96P22=m
> > > CONFIG_SND_SOC_MAX9759=m
> > > CONFIG_SND_SOC_MT6351=m
> > > CONFIG_SND_SOC_MT6358=m
> > > CONFIG_SND_SOC_NAU8540=m
> > > CONFIG_SND_SOC_NAU8810=m
> > > CONFIG_SND_SOC_NAU8822=m
> > > CONFIG_SND_SOC_NAU8824=m
> > > CONFIG_SND_SOC_NAU8825=m
> > > CONFIG_SND_SOC_TPA6130A2=m
> > > # end of CODEC drivers
> > > 
> > > CONFIG_SND_SIMPLE_CARD_UTILS=m
> > > CONFIG_SND_SIMPLE_CARD=m
> > > CONFIG_SND_X86=y
> > > CONFIG_HDMI_LPE_AUDIO=m
> > > CONFIG_SND_SYNTH_EMUX=m
> > > CONFIG_SND_XEN_FRONTEND=m
> > > CONFIG_AC97_BUS=m
> > > 
> > > #
> > > # HID support
> > > #
> > > CONFIG_HID=m
> > > CONFIG_HID_BATTERY_STRENGTH=y
> > > CONFIG_HIDRAW=y
> > > CONFIG_UHID=m
> > > CONFIG_HID_GENERIC=m
> > > 
> > > #
> > > # Special HID drivers
> > > #
> > > CONFIG_HID_A4TECH=m
> > > CONFIG_HID_ACCUTOUCH=m
> > > CONFIG_HID_ACRUX=m
> > > CONFIG_HID_ACRUX_FF=y
> > > CONFIG_HID_APPLE=m
> > > CONFIG_HID_APPLEIR=m
> > > CONFIG_HID_ASUS=m
> > > CONFIG_HID_AUREAL=m
> > > CONFIG_HID_BELKIN=m
> > > CONFIG_HID_BETOP_FF=m
> > > CONFIG_HID_BIGBEN_FF=m
> > > CONFIG_HID_CHERRY=m
> > > CONFIG_HID_CHICONY=m
> > > CONFIG_HID_CORSAIR=m
> > > CONFIG_HID_COUGAR=m
> > > CONFIG_HID_MACALLY=m
> > > CONFIG_HID_PRODIKEYS=m
> > > CONFIG_HID_CMEDIA=m
> > > CONFIG_HID_CP2112=m
> > > # CONFIG_HID_CREATIVE_SB0540 is not set
> > > CONFIG_HID_CYPRESS=m
> > > CONFIG_HID_DRAGONRISE=m
> > > CONFIG_DRAGONRISE_FF=y
> > > CONFIG_HID_EMS_FF=m
> > > CONFIG_HID_ELAN=m
> > > CONFIG_HID_ELECOM=m
> > > CONFIG_HID_ELO=m
> > > CONFIG_HID_EZKEY=m
> > > CONFIG_HID_GEMBIRD=m
> > > CONFIG_HID_GFRM=m
> > > CONFIG_HID_HOLTEK=m
> > > CONFIG_HOLTEK_FF=y
> > > CONFIG_HID_GOOGLE_HAMMER=m
> > > CONFIG_HID_GT683R=m
> > > CONFIG_HID_KEYTOUCH=m
> > > CONFIG_HID_KYE=m
> > > CONFIG_HID_UCLOGIC=m
> > > CONFIG_HID_WALTOP=m
> > > CONFIG_HID_VIEWSONIC=m
> > > CONFIG_HID_GYRATION=m
> > > CONFIG_HID_ICADE=m
> > > CONFIG_HID_ITE=m
> > > CONFIG_HID_JABRA=m
> > > CONFIG_HID_TWINHAN=m
> > > CONFIG_HID_KENSINGTON=m
> > > CONFIG_HID_LCPOWER=m
> > > CONFIG_HID_LED=m
> > > CONFIG_HID_LENOVO=m
> > > CONFIG_HID_LOGITECH=m
> > > CONFIG_HID_LOGITECH_DJ=m
> > > CONFIG_HID_LOGITECH_HIDPP=m
> > > CONFIG_LOGITECH_FF=y
> > > CONFIG_LOGIRUMBLEPAD2_FF=y
> > > CONFIG_LOGIG940_FF=y
> > > CONFIG_LOGIWHEELS_FF=y
> > > CONFIG_HID_MAGICMOUSE=m
> > > CONFIG_HID_MALTRON=m
> > > CONFIG_HID_MAYFLASH=m
> > > CONFIG_HID_REDRAGON=m
> > > CONFIG_HID_MICROSOFT=m
> > > CONFIG_HID_MONTEREY=m
> > > CONFIG_HID_MULTITOUCH=m
> > > CONFIG_HID_NTI=m
> > > CONFIG_HID_NTRIG=m
> > > CONFIG_HID_ORTEK=m
> > > CONFIG_HID_PANTHERLORD=m
> > > CONFIG_PANTHERLORD_FF=y
> > > CONFIG_HID_PENMOUNT=m
> > > CONFIG_HID_PETALYNX=m
> > > CONFIG_HID_PICOLCD=m
> > > CONFIG_HID_PICOLCD_FB=y
> > > CONFIG_HID_PICOLCD_BACKLIGHT=y
> > > CONFIG_HID_PICOLCD_LCD=y
> > > CONFIG_HID_PICOLCD_LEDS=y
> > > CONFIG_HID_PICOLCD_CIR=y
> > > CONFIG_HID_PLANTRONICS=m
> > > CONFIG_HID_PRIMAX=m
> > > CONFIG_HID_RETRODE=m
> > > CONFIG_HID_ROCCAT=m
> > > CONFIG_HID_SAITEK=m
> > > CONFIG_HID_SAMSUNG=m
> > > CONFIG_HID_SONY=m
> > > CONFIG_SONY_FF=y
> > > CONFIG_HID_SPEEDLINK=m
> > > CONFIG_HID_STEAM=m
> > > CONFIG_HID_STEELSERIES=m
> > > CONFIG_HID_SUNPLUS=m
> > > CONFIG_HID_RMI=m
> > > CONFIG_HID_GREENASIA=m
> > > CONFIG_GREENASIA_FF=y
> > > CONFIG_HID_HYPERV_MOUSE=m
> > > CONFIG_HID_SMARTJOYPLUS=m
> > > CONFIG_SMARTJOYPLUS_FF=y
> > > CONFIG_HID_TIVO=m
> > > CONFIG_HID_TOPSEED=m
> > > CONFIG_HID_THINGM=m
> > > CONFIG_HID_THRUSTMASTER=m
> > > CONFIG_THRUSTMASTER_FF=y
> > > CONFIG_HID_UDRAW_PS3=m
> > > CONFIG_HID_U2FZERO=m
> > > CONFIG_HID_WACOM=m
> > > CONFIG_HID_WIIMOTE=m
> > > CONFIG_HID_XINMO=m
> > > CONFIG_HID_ZEROPLUS=m
> > > CONFIG_ZEROPLUS_FF=y
> > > CONFIG_HID_ZYDACRON=m
> > > CONFIG_HID_SENSOR_HUB=m
> > > CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
> > > CONFIG_HID_ALPS=m
> > > # end of Special HID drivers
> > > 
> > > #
> > > # USB HID support
> > > #
> > > CONFIG_USB_HID=m
> > > CONFIG_HID_PID=y
> > > CONFIG_USB_HIDDEV=y
> > > 
> > > #
> > > # USB HID Boot Protocol drivers
> > > #
> > > CONFIG_USB_KBD=m
> > > CONFIG_USB_MOUSE=m
> > > # end of USB HID Boot Protocol drivers
> > > # end of USB HID support
> > > 
> > > #
> > > # I2C HID support
> > > #
> > > CONFIG_I2C_HID=m
> > > # end of I2C HID support
> > > 
> > > #
> > > # Intel ISH HID support
> > > #
> > > CONFIG_INTEL_ISH_HID=m
> > > CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER=m
> > > # end of Intel ISH HID support
> > > # end of HID support
> > > 
> > > CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> > > CONFIG_USB_SUPPORT=y
> > > CONFIG_USB_COMMON=y
> > > CONFIG_USB_LED_TRIG=y
> > > CONFIG_USB_ULPI_BUS=m
> > > # CONFIG_USB_CONN_GPIO is not set
> > > CONFIG_USB_ARCH_HAS_HCD=y
> > > CONFIG_USB=y
> > > CONFIG_USB_PCI=y
> > > CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> > > 
> > > #
> > > # Miscellaneous USB options
> > > #
> > > CONFIG_USB_DEFAULT_PERSIST=y
> > > CONFIG_USB_DYNAMIC_MINORS=y
> > > # CONFIG_USB_OTG is not set
> > > # CONFIG_USB_OTG_WHITELIST is not set
> > > # CONFIG_USB_OTG_BLACKLIST_HUB is not set
> > > CONFIG_USB_LEDS_TRIGGER_USBPORT=m
> > > CONFIG_USB_AUTOSUSPEND_DELAY=2
> > > CONFIG_USB_MON=m
> > > 
> > > #
> > > # USB Host Controller Drivers
> > > #
> > > CONFIG_USB_C67X00_HCD=m
> > > CONFIG_USB_XHCI_HCD=y
> > > CONFIG_USB_XHCI_DBGCAP=y
> > > CONFIG_USB_XHCI_PCI=y
> > > CONFIG_USB_XHCI_PLATFORM=m
> > > CONFIG_USB_EHCI_HCD=y
> > > CONFIG_USB_EHCI_ROOT_HUB_TT=y
> > > CONFIG_USB_EHCI_TT_NEWSCHED=y
> > > CONFIG_USB_EHCI_PCI=y
> > > CONFIG_USB_EHCI_FSL=m
> > > CONFIG_USB_EHCI_HCD_PLATFORM=y
> > > CONFIG_USB_OXU210HP_HCD=m
> > > CONFIG_USB_ISP116X_HCD=m
> > > CONFIG_USB_FOTG210_HCD=m
> > > CONFIG_USB_MAX3421_HCD=m
> > > CONFIG_USB_OHCI_HCD=y
> > > CONFIG_USB_OHCI_HCD_PCI=y
> > > CONFIG_USB_OHCI_HCD_PLATFORM=y
> > > CONFIG_USB_UHCI_HCD=y
> > > CONFIG_USB_U132_HCD=m
> > > CONFIG_USB_SL811_HCD=m
> > > CONFIG_USB_SL811_HCD_ISO=y
> > > CONFIG_USB_SL811_CS=m
> > > CONFIG_USB_R8A66597_HCD=m
> > > CONFIG_USB_HCD_BCMA=m
> > > CONFIG_USB_HCD_SSB=m
> > > # CONFIG_USB_HCD_TEST_MODE is not set
> > > 
> > > #
> > > # USB Device Class drivers
> > > #
> > > CONFIG_USB_ACM=m
> > > CONFIG_USB_PRINTER=m
> > > CONFIG_USB_WDM=m
> > > CONFIG_USB_TMC=m
> > > 
> > > #
> > > # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> > > #
> > > 
> > > #
> > > # also be needed; see USB_STORAGE Help for more info
> > > #
> > > CONFIG_USB_STORAGE=m
> > > # CONFIG_USB_STORAGE_DEBUG is not set
> > > CONFIG_USB_STORAGE_REALTEK=m
> > > CONFIG_REALTEK_AUTOPM=y
> > > CONFIG_USB_STORAGE_DATAFAB=m
> > > CONFIG_USB_STORAGE_FREECOM=m
> > > CONFIG_USB_STORAGE_ISD200=m
> > > CONFIG_USB_STORAGE_USBAT=m
> > > CONFIG_USB_STORAGE_SDDR09=m
> > > CONFIG_USB_STORAGE_SDDR55=m
> > > CONFIG_USB_STORAGE_JUMPSHOT=m
> > > CONFIG_USB_STORAGE_ALAUDA=m
> > > CONFIG_USB_STORAGE_ONETOUCH=m
> > > CONFIG_USB_STORAGE_KARMA=m
> > > CONFIG_USB_STORAGE_CYPRESS_ATACB=m
> > > CONFIG_USB_STORAGE_ENE_UB6250=m
> > > CONFIG_USB_UAS=m
> > > 
> > > #
> > > # USB Imaging devices
> > > #
> > > CONFIG_USB_MDC800=m
> > > CONFIG_USB_MICROTEK=m
> > > CONFIG_USBIP_CORE=m
> > > CONFIG_USBIP_VHCI_HCD=m
> > > CONFIG_USBIP_VHCI_HC_PORTS=8
> > > CONFIG_USBIP_VHCI_NR_HCS=1
> > > CONFIG_USBIP_HOST=m
> > > CONFIG_USBIP_VUDC=m
> > > # CONFIG_USBIP_DEBUG is not set
> > > # CONFIG_USB_CDNS3 is not set
> > > CONFIG_USB_MUSB_HDRC=m
> > > # CONFIG_USB_MUSB_HOST is not set
> > > # CONFIG_USB_MUSB_GADGET is not set
> > > CONFIG_USB_MUSB_DUAL_ROLE=y
> > > 
> > > #
> > > # Platform Glue Layer
> > > #
> > > 
> > > #
> > > # MUSB DMA mode
> > > #
> > > CONFIG_MUSB_PIO_ONLY=y
> > > CONFIG_USB_DWC3=m
> > > CONFIG_USB_DWC3_ULPI=y
> > > # CONFIG_USB_DWC3_HOST is not set
> > > # CONFIG_USB_DWC3_GADGET is not set
> > > CONFIG_USB_DWC3_DUAL_ROLE=y
> > > 
> > > #
> > > # Platform Glue Driver Support
> > > #
> > > CONFIG_USB_DWC3_PCI=m
> > > CONFIG_USB_DWC3_HAPS=m
> > > CONFIG_USB_DWC2=y
> > > CONFIG_USB_DWC2_HOST=y
> > > 
> > > #
> > > # Gadget/Dual-role mode requires USB Gadget support to be enabled
> > > #
> > > CONFIG_USB_DWC2_PCI=m
> > > # CONFIG_USB_DWC2_DEBUG is not set
> > > # CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
> > > CONFIG_USB_CHIPIDEA=m
> > > CONFIG_USB_CHIPIDEA_PCI=m
> > > CONFIG_USB_CHIPIDEA_UDC=y
> > > CONFIG_USB_CHIPIDEA_HOST=y
> > > CONFIG_USB_ISP1760=m
> > > CONFIG_USB_ISP1760_HCD=y
> > > CONFIG_USB_ISP1761_UDC=y
> > > # CONFIG_USB_ISP1760_HOST_ROLE is not set
> > > # CONFIG_USB_ISP1760_GADGET_ROLE is not set
> > > CONFIG_USB_ISP1760_DUAL_ROLE=y
> > > 
> > > #
> > > # USB port drivers
> > > #
> > > CONFIG_USB_USS720=m
> > > CONFIG_USB_SERIAL=m
> > > CONFIG_USB_SERIAL_GENERIC=y
> > > CONFIG_USB_SERIAL_SIMPLE=m
> > > CONFIG_USB_SERIAL_AIRCABLE=m
> > > CONFIG_USB_SERIAL_ARK3116=m
> > > CONFIG_USB_SERIAL_BELKIN=m
> > > CONFIG_USB_SERIAL_CH341=m
> > > CONFIG_USB_SERIAL_WHITEHEAT=m
> > > CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
> > > CONFIG_USB_SERIAL_CP210X=m
> > > CONFIG_USB_SERIAL_CYPRESS_M8=m
> > > CONFIG_USB_SERIAL_EMPEG=m
> > > CONFIG_USB_SERIAL_FTDI_SIO=m
> > > CONFIG_USB_SERIAL_VISOR=m
> > > CONFIG_USB_SERIAL_IPAQ=m
> > > CONFIG_USB_SERIAL_IR=m
> > > CONFIG_USB_SERIAL_EDGEPORT=m
> > > CONFIG_USB_SERIAL_EDGEPORT_TI=m
> > > CONFIG_USB_SERIAL_F81232=m
> > > CONFIG_USB_SERIAL_F8153X=m
> > > CONFIG_USB_SERIAL_GARMIN=m
> > > CONFIG_USB_SERIAL_IPW=m
> > > CONFIG_USB_SERIAL_IUU=m
> > > CONFIG_USB_SERIAL_KEYSPAN_PDA=m
> > > CONFIG_USB_SERIAL_KEYSPAN=m
> > > CONFIG_USB_SERIAL_KLSI=m
> > > CONFIG_USB_SERIAL_KOBIL_SCT=m
> > > CONFIG_USB_SERIAL_MCT_U232=m
> > > CONFIG_USB_SERIAL_METRO=m
> > > CONFIG_USB_SERIAL_MOS7720=m
> > > CONFIG_USB_SERIAL_MOS7715_PARPORT=y
> > > CONFIG_USB_SERIAL_MOS7840=m
> > > CONFIG_USB_SERIAL_MXUPORT=m
> > > CONFIG_USB_SERIAL_NAVMAN=m
> > > CONFIG_USB_SERIAL_PL2303=m
> > > CONFIG_USB_SERIAL_OTI6858=m
> > > CONFIG_USB_SERIAL_QCAUX=m
> > > CONFIG_USB_SERIAL_QUALCOMM=m
> > > CONFIG_USB_SERIAL_SPCP8X5=m
> > > CONFIG_USB_SERIAL_SAFE=m
> > > # CONFIG_USB_SERIAL_SAFE_PADDED is not set
> > > CONFIG_USB_SERIAL_SIERRAWIRELESS=m
> > > CONFIG_USB_SERIAL_SYMBOL=m
> > > CONFIG_USB_SERIAL_TI=m
> > > CONFIG_USB_SERIAL_CYBERJACK=m
> > > CONFIG_USB_SERIAL_XIRCOM=m
> > > CONFIG_USB_SERIAL_WWAN=m
> > > CONFIG_USB_SERIAL_OPTION=m
> > > CONFIG_USB_SERIAL_OMNINET=m
> > > CONFIG_USB_SERIAL_OPTICON=m
> > > CONFIG_USB_SERIAL_XSENS_MT=m
> > > CONFIG_USB_SERIAL_WISHBONE=m
> > > CONFIG_USB_SERIAL_SSU100=m
> > > CONFIG_USB_SERIAL_QT2=m
> > > CONFIG_USB_SERIAL_UPD78F0730=m
> > > CONFIG_USB_SERIAL_DEBUG=m
> > > 
> > > #
> > > # USB Miscellaneous drivers
> > > #
> > > CONFIG_USB_EMI62=m
> > > CONFIG_USB_EMI26=m
> > > CONFIG_USB_ADUTUX=m
> > > CONFIG_USB_SEVSEG=m
> > > CONFIG_USB_LEGOTOWER=m
> > > CONFIG_USB_LCD=m
> > > CONFIG_USB_CYPRESS_CY7C63=m
> > > CONFIG_USB_CYTHERM=m
> > > CONFIG_USB_IDMOUSE=m
> > > CONFIG_USB_FTDI_ELAN=m
> > > CONFIG_USB_APPLEDISPLAY=m
> > > CONFIG_USB_SISUSBVGA=m
> > > # CONFIG_USB_SISUSBVGA_CON is not set
> > > CONFIG_USB_LD=m
> > > CONFIG_USB_TRANCEVIBRATOR=m
> > > CONFIG_USB_IOWARRIOR=m
> > > CONFIG_USB_TEST=m
> > > CONFIG_USB_EHSET_TEST_FIXTURE=m
> > > CONFIG_USB_ISIGHTFW=m
> > > CONFIG_USB_YUREX=m
> > > CONFIG_USB_EZUSB_FX2=m
> > > CONFIG_USB_HUB_USB251XB=m
> > > CONFIG_USB_HSIC_USB3503=m
> > > CONFIG_USB_HSIC_USB4604=m
> > > CONFIG_USB_LINK_LAYER_TEST=m
> > > CONFIG_USB_CHAOSKEY=m
> > > CONFIG_USB_ATM=m
> > > CONFIG_USB_SPEEDTOUCH=m
> > > CONFIG_USB_CXACRU=m
> > > CONFIG_USB_UEAGLEATM=m
> > > CONFIG_USB_XUSBATM=m
> > > 
> > > #
> > > # USB Physical Layer drivers
> > > #
> > > CONFIG_USB_PHY=y
> > > CONFIG_NOP_USB_XCEIV=m
> > > CONFIG_USB_GPIO_VBUS=m
> > > CONFIG_TAHVO_USB=m
> > > CONFIG_TAHVO_USB_HOST_BY_DEFAULT=y
> > > CONFIG_USB_ISP1301=m
> > > # end of USB Physical Layer drivers
> > > 
> > > CONFIG_USB_GADGET=m
> > > # CONFIG_USB_GADGET_DEBUG is not set
> > > # CONFIG_USB_GADGET_DEBUG_FILES is not set
> > > # CONFIG_USB_GADGET_DEBUG_FS is not set
> > > CONFIG_USB_GADGET_VBUS_DRAW=2
> > > CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
> > > CONFIG_U_SERIAL_CONSOLE=y
> > > 
> > > #
> > > # USB Peripheral Controller
> > > #
> > > CONFIG_USB_FOTG210_UDC=m
> > > CONFIG_USB_GR_UDC=m
> > > CONFIG_USB_R8A66597=m
> > > CONFIG_USB_PXA27X=m
> > > CONFIG_USB_MV_UDC=m
> > > CONFIG_USB_MV_U3D=m
> > > CONFIG_USB_SNP_CORE=m
> > > # CONFIG_USB_M66592 is not set
> > > CONFIG_USB_BDC_UDC=m
> > > 
> > > #
> > > # Platform Support
> > > #
> > > CONFIG_USB_BDC_PCI=m
> > > CONFIG_USB_AMD5536UDC=m
> > > CONFIG_USB_NET2272=m
> > > CONFIG_USB_NET2272_DMA=y
> > > CONFIG_USB_NET2280=m
> > > CONFIG_USB_GOKU=m
> > > CONFIG_USB_EG20T=m
> > > # CONFIG_USB_DUMMY_HCD is not set
> > > # end of USB Peripheral Controller
> > > 
> > > CONFIG_USB_LIBCOMPOSITE=m
> > > CONFIG_USB_F_ACM=m
> > > CONFIG_USB_F_SS_LB=m
> > > CONFIG_USB_U_SERIAL=m
> > > CONFIG_USB_U_ETHER=m
> > > CONFIG_USB_U_AUDIO=m
> > > CONFIG_USB_F_SERIAL=m
> > > CONFIG_USB_F_OBEX=m
> > > CONFIG_USB_F_NCM=m
> > > CONFIG_USB_F_ECM=m
> > > CONFIG_USB_F_PHONET=m
> > > CONFIG_USB_F_EEM=m
> > > CONFIG_USB_F_SUBSET=m
> > > CONFIG_USB_F_RNDIS=m
> > > CONFIG_USB_F_MASS_STORAGE=m
> > > CONFIG_USB_F_FS=m
> > > CONFIG_USB_F_UAC1=m
> > > CONFIG_USB_F_UAC1_LEGACY=m
> > > CONFIG_USB_F_UAC2=m
> > > CONFIG_USB_F_UVC=m
> > > CONFIG_USB_F_MIDI=m
> > > CONFIG_USB_F_HID=m
> > > CONFIG_USB_F_PRINTER=m
> > > CONFIG_USB_F_TCM=m
> > > CONFIG_USB_CONFIGFS=m
> > > CONFIG_USB_CONFIGFS_SERIAL=y
> > > CONFIG_USB_CONFIGFS_ACM=y
> > > CONFIG_USB_CONFIGFS_OBEX=y
> > > CONFIG_USB_CONFIGFS_NCM=y
> > > CONFIG_USB_CONFIGFS_ECM=y
> > > CONFIG_USB_CONFIGFS_ECM_SUBSET=y
> > > CONFIG_USB_CONFIGFS_RNDIS=y
> > > CONFIG_USB_CONFIGFS_EEM=y
> > > CONFIG_USB_CONFIGFS_PHONET=y
> > > CONFIG_USB_CONFIGFS_MASS_STORAGE=y
> > > CONFIG_USB_CONFIGFS_F_LB_SS=y
> > > CONFIG_USB_CONFIGFS_F_FS=y
> > > CONFIG_USB_CONFIGFS_F_UAC1=y
> > > CONFIG_USB_CONFIGFS_F_UAC1_LEGACY=y
> > > CONFIG_USB_CONFIGFS_F_UAC2=y
> > > CONFIG_USB_CONFIGFS_F_MIDI=y
> > > CONFIG_USB_CONFIGFS_F_HID=y
> > > CONFIG_USB_CONFIGFS_F_UVC=y
> > > CONFIG_USB_CONFIGFS_F_PRINTER=y
> > > CONFIG_USB_CONFIGFS_F_TCM=y
> > > CONFIG_USB_ZERO=m
> > > CONFIG_USB_AUDIO=m
> > > CONFIG_GADGET_UAC1=y
> > > # CONFIG_GADGET_UAC1_LEGACY is not set
> > > CONFIG_USB_ETH=m
> > > CONFIG_USB_ETH_RNDIS=y
> > > CONFIG_USB_ETH_EEM=y
> > > CONFIG_USB_G_NCM=m
> > > CONFIG_USB_GADGETFS=m
> > > CONFIG_USB_FUNCTIONFS=m
> > > CONFIG_USB_FUNCTIONFS_ETH=y
> > > CONFIG_USB_FUNCTIONFS_RNDIS=y
> > > CONFIG_USB_FUNCTIONFS_GENERIC=y
> > > CONFIG_USB_MASS_STORAGE=m
> > > CONFIG_USB_GADGET_TARGET=m
> > > CONFIG_USB_G_SERIAL=m
> > > CONFIG_USB_MIDI_GADGET=m
> > > CONFIG_USB_G_PRINTER=m
> > > CONFIG_USB_CDC_COMPOSITE=m
> > > CONFIG_USB_G_NOKIA=m
> > > CONFIG_USB_G_ACM_MS=m
> > > # CONFIG_USB_G_MULTI is not set
> > > CONFIG_USB_G_HID=m
> > > CONFIG_USB_G_DBGP=m
> > > # CONFIG_USB_G_DBGP_PRINTK is not set
> > > CONFIG_USB_G_DBGP_SERIAL=y
> > > CONFIG_USB_G_WEBCAM=m
> > > CONFIG_TYPEC=m
> > > CONFIG_TYPEC_TCPM=m
> > > CONFIG_TYPEC_TCPCI=m
> > > CONFIG_TYPEC_RT1711H=m
> > > CONFIG_TYPEC_FUSB302=m
> > > CONFIG_TYPEC_UCSI=m
> > > CONFIG_UCSI_CCG=m
> > > CONFIG_UCSI_ACPI=m
> > > # CONFIG_TYPEC_HD3SS3220 is not set
> > > CONFIG_TYPEC_TPS6598X=m
> > > 
> > > #
> > > # USB Type-C Multiplexer/DeMultiplexer Switch support
> > > #
> > > CONFIG_TYPEC_MUX_PI3USB30532=m
> > > # end of USB Type-C Multiplexer/DeMultiplexer Switch support
> > > 
> > > #
> > > # USB Type-C Alternate Mode drivers
> > > #
> > > CONFIG_TYPEC_DP_ALTMODE=m
> > > CONFIG_TYPEC_NVIDIA_ALTMODE=m
> > > # end of USB Type-C Alternate Mode drivers
> > > 
> > > CONFIG_USB_ROLE_SWITCH=m
> > > CONFIG_USB_ROLES_INTEL_XHCI=m
> > > CONFIG_MMC=y
> > > CONFIG_MMC_BLOCK=m
> > > CONFIG_MMC_BLOCK_MINORS=8
> > > CONFIG_SDIO_UART=m
> > > # CONFIG_MMC_TEST is not set
> > > 
> > > #
> > > # MMC/SD/SDIO Host Controller Drivers
> > > #
> > > # CONFIG_MMC_DEBUG is not set
> > > CONFIG_MMC_SDHCI=m
> > > CONFIG_MMC_SDHCI_IO_ACCESSORS=y
> > > CONFIG_MMC_SDHCI_PCI=m
> > > CONFIG_MMC_RICOH_MMC=y
> > > CONFIG_MMC_SDHCI_ACPI=m
> > > CONFIG_MMC_SDHCI_PLTFM=m
> > > CONFIG_MMC_SDHCI_F_SDH30=m
> > > CONFIG_MMC_WBSD=m
> > > CONFIG_MMC_ALCOR=m
> > > CONFIG_MMC_TIFM_SD=m
> > > CONFIG_MMC_SPI=m
> > > CONFIG_MMC_SDRICOH_CS=m
> > > CONFIG_MMC_CB710=m
> > > CONFIG_MMC_VIA_SDMMC=m
> > > CONFIG_MMC_VUB300=m
> > > CONFIG_MMC_USHC=m
> > > CONFIG_MMC_USDHI6ROL0=m
> > > CONFIG_MMC_REALTEK_PCI=m
> > > CONFIG_MMC_REALTEK_USB=m
> > > CONFIG_MMC_CQHCI=m
> > > CONFIG_MMC_TOSHIBA_PCI=m
> > > CONFIG_MMC_MTK=m
> > > CONFIG_MMC_SDHCI_XENON=m
> > > CONFIG_MEMSTICK=m
> > > # CONFIG_MEMSTICK_DEBUG is not set
> > > 
> > > #
> > > # MemoryStick drivers
> > > #
> > > # CONFIG_MEMSTICK_UNSAFE_RESUME is not set
> > > CONFIG_MSPRO_BLOCK=m
> > > CONFIG_MS_BLOCK=m
> > > 
> > > #
> > > # MemoryStick Host Controller Drivers
> > > #
> > > CONFIG_MEMSTICK_TIFM_MS=m
> > > CONFIG_MEMSTICK_JMICRON_38X=m
> > > CONFIG_MEMSTICK_R592=m
> > > CONFIG_MEMSTICK_REALTEK_PCI=m
> > > CONFIG_MEMSTICK_REALTEK_USB=m
> > > CONFIG_NEW_LEDS=y
> > > CONFIG_LEDS_CLASS=y
> > > CONFIG_LEDS_CLASS_FLASH=m
> > > CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y
> > > 
> > > #
> > > # LED drivers
> > > #
> > > CONFIG_LEDS_88PM860X=m
> > > CONFIG_LEDS_APU=m
> > > CONFIG_LEDS_AS3645A=m
> > > CONFIG_LEDS_LM3530=m
> > > CONFIG_LEDS_LM3532=m
> > > CONFIG_LEDS_LM3533=m
> > > CONFIG_LEDS_LM3642=m
> > > CONFIG_LEDS_LM3601X=m
> > > CONFIG_LEDS_MT6323=m
> > > CONFIG_LEDS_PCA9532=m
> > > CONFIG_LEDS_PCA9532_GPIO=y
> > > CONFIG_LEDS_GPIO=m
> > > CONFIG_LEDS_LP3944=m
> > > CONFIG_LEDS_LP3952=m
> > > CONFIG_LEDS_LP55XX_COMMON=m
> > > CONFIG_LEDS_LP5521=m
> > > CONFIG_LEDS_LP5523=m
> > > CONFIG_LEDS_LP5562=m
> > > CONFIG_LEDS_LP8501=m
> > > CONFIG_LEDS_LP8788=m
> > > CONFIG_LEDS_CLEVO_MAIL=m
> > > CONFIG_LEDS_PCA955X=m
> > > CONFIG_LEDS_PCA955X_GPIO=y
> > > CONFIG_LEDS_PCA963X=m
> > > CONFIG_LEDS_WM831X_STATUS=m
> > > CONFIG_LEDS_WM8350=m
> > > CONFIG_LEDS_DA903X=m
> > > CONFIG_LEDS_DA9052=m
> > > CONFIG_LEDS_DAC124S085=m
> > > CONFIG_LEDS_PWM=m
> > > CONFIG_LEDS_REGULATOR=m
> > > CONFIG_LEDS_BD2802=m
> > > CONFIG_LEDS_INTEL_SS4200=m
> > > CONFIG_LEDS_ADP5520=m
> > > CONFIG_LEDS_MC13783=m
> > > CONFIG_LEDS_TCA6507=m
> > > CONFIG_LEDS_TLC591XX=m
> > > CONFIG_LEDS_MAX8997=m
> > > CONFIG_LEDS_LM355x=m
> > > CONFIG_LEDS_MENF21BMC=m
> > > 
> > > #
> > > # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> > > #
> > > CONFIG_LEDS_BLINKM=m
> > > CONFIG_LEDS_MLXCPLD=m
> > > CONFIG_LEDS_MLXREG=m
> > > CONFIG_LEDS_USER=m
> > > CONFIG_LEDS_NIC78BX=m
> > > CONFIG_LEDS_TI_LMU_COMMON=m
> > > CONFIG_LEDS_LM36274=m
> > > 
> > > #
> > > # LED Triggers
> > > #
> > > CONFIG_LEDS_TRIGGERS=y
> > > CONFIG_LEDS_TRIGGER_TIMER=m
> > > CONFIG_LEDS_TRIGGER_ONESHOT=m
> > > CONFIG_LEDS_TRIGGER_DISK=y
> > > CONFIG_LEDS_TRIGGER_MTD=y
> > > CONFIG_LEDS_TRIGGER_HEARTBEAT=m
> > > CONFIG_LEDS_TRIGGER_BACKLIGHT=m
> > > CONFIG_LEDS_TRIGGER_CPU=y
> > > CONFIG_LEDS_TRIGGER_ACTIVITY=m
> > > CONFIG_LEDS_TRIGGER_GPIO=m
> > > CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
> > > 
> > > #
> > > # iptables trigger is under Netfilter config (LED target)
> > > #
> > > CONFIG_LEDS_TRIGGER_TRANSIENT=m
> > > CONFIG_LEDS_TRIGGER_CAMERA=m
> > > CONFIG_LEDS_TRIGGER_PANIC=y
> > > CONFIG_LEDS_TRIGGER_NETDEV=m
> > > CONFIG_LEDS_TRIGGER_PATTERN=m
> > > CONFIG_LEDS_TRIGGER_AUDIO=m
> > > # CONFIG_ACCESSIBILITY is not set
> > > CONFIG_INFINIBAND=m
> > > CONFIG_INFINIBAND_USER_MAD=m
> > > CONFIG_INFINIBAND_USER_ACCESS=m
> > > # CONFIG_INFINIBAND_EXP_LEGACY_VERBS_NEW_UAPI is not set
> > > CONFIG_INFINIBAND_USER_MEM=y
> > > CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
> > > CONFIG_INFINIBAND_ADDR_TRANS=y
> > > CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
> > > CONFIG_INFINIBAND_MTHCA=m
> > > # CONFIG_INFINIBAND_MTHCA_DEBUG is not set
> > > CONFIG_INFINIBAND_QIB=m
> > > CONFIG_INFINIBAND_QIB_DCA=y
> > > CONFIG_INFINIBAND_CXGB4=m
> > > CONFIG_INFINIBAND_EFA=m
> > > CONFIG_INFINIBAND_I40IW=m
> > > CONFIG_MLX4_INFINIBAND=m
> > > CONFIG_MLX5_INFINIBAND=m
> > > CONFIG_INFINIBAND_OCRDMA=m
> > > CONFIG_INFINIBAND_VMWARE_PVRDMA=m
> > > CONFIG_INFINIBAND_USNIC=m
> > > CONFIG_INFINIBAND_BNXT_RE=m
> > > CONFIG_INFINIBAND_HFI1=m
> > > # CONFIG_HFI1_DEBUG_SDMA_ORDER is not set
> > > # CONFIG_SDMA_VERBOSITY is not set
> > > CONFIG_INFINIBAND_QEDR=m
> > > CONFIG_INFINIBAND_RDMAVT=m
> > > CONFIG_RDMA_RXE=m
> > > CONFIG_RDMA_SIW=m
> > > CONFIG_INFINIBAND_IPOIB=m
> > > CONFIG_INFINIBAND_IPOIB_CM=y
> > > # CONFIG_INFINIBAND_IPOIB_DEBUG is not set
> > > CONFIG_INFINIBAND_SRP=m
> > > CONFIG_INFINIBAND_SRPT=m
> > > CONFIG_INFINIBAND_ISER=m
> > > CONFIG_INFINIBAND_ISERT=m
> > > CONFIG_INFINIBAND_OPA_VNIC=m
> > > CONFIG_EDAC_ATOMIC_SCRUB=y
> > > CONFIG_EDAC_SUPPORT=y
> > > CONFIG_EDAC=y
> > > # CONFIG_EDAC_LEGACY_SYSFS is not set
> > > # CONFIG_EDAC_DEBUG is not set
> > > CONFIG_EDAC_DECODE_MCE=m
> > > CONFIG_EDAC_GHES=y
> > > CONFIG_EDAC_AMD64=m
> > > # CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
> > > CONFIG_EDAC_E752X=m
> > > CONFIG_EDAC_I82975X=m
> > > CONFIG_EDAC_I3000=m
> > > CONFIG_EDAC_I3200=m
> > > CONFIG_EDAC_IE31200=m
> > > CONFIG_EDAC_X38=m
> > > CONFIG_EDAC_I5400=m
> > > CONFIG_EDAC_I7CORE=m
> > > CONFIG_EDAC_I5000=m
> > > CONFIG_EDAC_I5100=m
> > > CONFIG_EDAC_I7300=m
> > > CONFIG_EDAC_SBRIDGE=m
> > > CONFIG_EDAC_SKX=m
> > > CONFIG_EDAC_I10NM=m
> > > CONFIG_EDAC_PND2=m
> > > CONFIG_RTC_LIB=y
> > > CONFIG_RTC_MC146818_LIB=y
> > > CONFIG_RTC_CLASS=y
> > > CONFIG_RTC_HCTOSYS=y
> > > CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> > > CONFIG_RTC_SYSTOHC=y
> > > CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
> > > # CONFIG_RTC_DEBUG is not set
> > > CONFIG_RTC_NVMEM=y
> > > 
> > > #
> > > # RTC interfaces
> > > #
> > > CONFIG_RTC_INTF_SYSFS=y
> > > CONFIG_RTC_INTF_PROC=y
> > > CONFIG_RTC_INTF_DEV=y
> > > # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> > > # CONFIG_RTC_DRV_TEST is not set
> > > 
> > > #
> > > # I2C RTC drivers
> > > #
> > > CONFIG_RTC_DRV_88PM860X=m
> > > CONFIG_RTC_DRV_88PM80X=m
> > > CONFIG_RTC_DRV_ABB5ZES3=m
> > > CONFIG_RTC_DRV_ABEOZ9=m
> > > CONFIG_RTC_DRV_ABX80X=m
> > > CONFIG_RTC_DRV_DS1307=m
> > > CONFIG_RTC_DRV_DS1307_CENTURY=y
> > > CONFIG_RTC_DRV_DS1374=m
> > > CONFIG_RTC_DRV_DS1374_WDT=y
> > > CONFIG_RTC_DRV_DS1672=m
> > > CONFIG_RTC_DRV_LP8788=m
> > > CONFIG_RTC_DRV_MAX6900=m
> > > CONFIG_RTC_DRV_MAX8907=m
> > > CONFIG_RTC_DRV_MAX8925=m
> > > CONFIG_RTC_DRV_MAX8998=m
> > > CONFIG_RTC_DRV_MAX8997=m
> > > CONFIG_RTC_DRV_RS5C372=m
> > > CONFIG_RTC_DRV_ISL1208=m
> > > CONFIG_RTC_DRV_ISL12022=m
> > > CONFIG_RTC_DRV_X1205=m
> > > CONFIG_RTC_DRV_PCF8523=m
> > > CONFIG_RTC_DRV_PCF85063=m
> > > CONFIG_RTC_DRV_PCF85363=m
> > > CONFIG_RTC_DRV_PCF8563=m
> > > CONFIG_RTC_DRV_PCF8583=m
> > > CONFIG_RTC_DRV_M41T80=m
> > > CONFIG_RTC_DRV_M41T80_WDT=y
> > > CONFIG_RTC_DRV_BQ32K=m
> > > CONFIG_RTC_DRV_PALMAS=m
> > > CONFIG_RTC_DRV_TPS6586X=m
> > > CONFIG_RTC_DRV_TPS65910=m
> > > CONFIG_RTC_DRV_TPS80031=m
> > > CONFIG_RTC_DRV_RC5T583=m
> > > CONFIG_RTC_DRV_S35390A=m
> > > CONFIG_RTC_DRV_FM3130=m
> > > CONFIG_RTC_DRV_RX8010=m
> > > CONFIG_RTC_DRV_RX8581=m
> > > CONFIG_RTC_DRV_RX8025=m
> > > CONFIG_RTC_DRV_EM3027=m
> > > CONFIG_RTC_DRV_RV3028=m
> > > CONFIG_RTC_DRV_RV8803=m
> > > CONFIG_RTC_DRV_S5M=m
> > > CONFIG_RTC_DRV_SD3078=m
> > > 
> > > #
> > > # SPI RTC drivers
> > > #
> > > CONFIG_RTC_DRV_M41T93=m
> > > CONFIG_RTC_DRV_M41T94=m
> > > CONFIG_RTC_DRV_DS1302=m
> > > CONFIG_RTC_DRV_DS1305=m
> > > CONFIG_RTC_DRV_DS1343=m
> > > CONFIG_RTC_DRV_DS1347=m
> > > CONFIG_RTC_DRV_DS1390=m
> > > CONFIG_RTC_DRV_MAX6916=m
> > > CONFIG_RTC_DRV_R9701=m
> > > CONFIG_RTC_DRV_RX4581=m
> > > CONFIG_RTC_DRV_RX6110=m
> > > CONFIG_RTC_DRV_RS5C348=m
> > > CONFIG_RTC_DRV_MAX6902=m
> > > CONFIG_RTC_DRV_PCF2123=m
> > > CONFIG_RTC_DRV_MCP795=m
> > > CONFIG_RTC_I2C_AND_SPI=y
> > > 
> > > #
> > > # SPI and I2C RTC drivers
> > > #
> > > CONFIG_RTC_DRV_DS3232=m
> > > CONFIG_RTC_DRV_DS3232_HWMON=y
> > > CONFIG_RTC_DRV_PCF2127=m
> > > CONFIG_RTC_DRV_RV3029C2=m
> > > CONFIG_RTC_DRV_RV3029_HWMON=y
> > > 
> > > #
> > > # Platform RTC drivers
> > > #
> > > CONFIG_RTC_DRV_CMOS=y
> > > CONFIG_RTC_DRV_DS1286=m
> > > CONFIG_RTC_DRV_DS1511=m
> > > CONFIG_RTC_DRV_DS1553=m
> > > CONFIG_RTC_DRV_DS1685_FAMILY=m
> > > CONFIG_RTC_DRV_DS1685=y
> > > # CONFIG_RTC_DRV_DS1689 is not set
> > > # CONFIG_RTC_DRV_DS17285 is not set
> > > # CONFIG_RTC_DRV_DS17485 is not set
> > > # CONFIG_RTC_DRV_DS17885 is not set
> > > CONFIG_RTC_DRV_DS1742=m
> > > CONFIG_RTC_DRV_DS2404=m
> > > CONFIG_RTC_DRV_DA9052=m
> > > CONFIG_RTC_DRV_DA9055=m
> > > CONFIG_RTC_DRV_DA9063=m
> > > CONFIG_RTC_DRV_STK17TA8=m
> > > CONFIG_RTC_DRV_M48T86=m
> > > CONFIG_RTC_DRV_M48T35=m
> > > CONFIG_RTC_DRV_M48T59=m
> > > CONFIG_RTC_DRV_MSM6242=m
> > > CONFIG_RTC_DRV_BQ4802=m
> > > CONFIG_RTC_DRV_RP5C01=m
> > > CONFIG_RTC_DRV_V3020=m
> > > CONFIG_RTC_DRV_WM831X=m
> > > CONFIG_RTC_DRV_WM8350=m
> > > CONFIG_RTC_DRV_PCF50633=m
> > > CONFIG_RTC_DRV_AB3100=m
> > > CONFIG_RTC_DRV_CROS_EC=m
> > > 
> > > #
> > > # on-CPU RTC drivers
> > > #
> > > CONFIG_RTC_DRV_FTRTC010=m
> > > CONFIG_RTC_DRV_PCAP=m
> > > CONFIG_RTC_DRV_MC13XXX=m
> > > CONFIG_RTC_DRV_MT6397=m
> > > 
> > > #
> > > # HID Sensor RTC drivers
> > > #
> > > CONFIG_RTC_DRV_HID_SENSOR_TIME=m
> > > CONFIG_RTC_DRV_WILCO_EC=m
> > > CONFIG_DMADEVICES=y
> > > # CONFIG_DMADEVICES_DEBUG is not set
> > > 
> > > #
> > > # DMA Devices
> > > #
> > > CONFIG_DMA_ENGINE=y
> > > CONFIG_DMA_VIRTUAL_CHANNELS=m
> > > CONFIG_DMA_ACPI=y
> > > CONFIG_ALTERA_MSGDMA=m
> > > CONFIG_INTEL_IDMA64=m
> > > CONFIG_INTEL_IOATDMA=m
> > > CONFIG_INTEL_MIC_X100_DMA=m
> > > CONFIG_QCOM_HIDMA_MGMT=m
> > > CONFIG_QCOM_HIDMA=m
> > > CONFIG_DW_DMAC_CORE=m
> > > CONFIG_DW_DMAC=m
> > > CONFIG_DW_DMAC_PCI=m
> > > CONFIG_DW_EDMA=m
> > > CONFIG_DW_EDMA_PCIE=m
> > > CONFIG_HSU_DMA=m
> > > # CONFIG_SF_PDMA is not set
> > > 
> > > #
> > > # DMA Clients
> > > #
> > > CONFIG_ASYNC_TX_DMA=y
> > > # CONFIG_DMATEST is not set
> > > CONFIG_DMA_ENGINE_RAID=y
> > > 
> > > #
> > > # DMABUF options
> > > #
> > > CONFIG_SYNC_FILE=y
> > > CONFIG_SW_SYNC=y
> > > CONFIG_UDMABUF=y
> > > # CONFIG_DMABUF_SELFTESTS is not set
> > > # end of DMABUF options
> > > 
> > > CONFIG_DCA=m
> > > CONFIG_AUXDISPLAY=y
> > > CONFIG_HD44780=m
> > > CONFIG_KS0108=m
> > > CONFIG_KS0108_PORT=0x378
> > > CONFIG_KS0108_DELAY=2
> > > CONFIG_CFAG12864B=m
> > > CONFIG_CFAG12864B_RATE=20
> > > CONFIG_IMG_ASCII_LCD=m
> > > CONFIG_PARPORT_PANEL=m
> > > CONFIG_PANEL_PARPORT=0
> > > CONFIG_PANEL_PROFILE=5
> > > # CONFIG_PANEL_CHANGE_MESSAGE is not set
> > > # CONFIG_CHARLCD_BL_OFF is not set
> > > # CONFIG_CHARLCD_BL_ON is not set
> > > CONFIG_CHARLCD_BL_FLASH=y
> > > CONFIG_PANEL=m
> > > CONFIG_CHARLCD=m
> > > CONFIG_UIO=m
> > > CONFIG_UIO_CIF=m
> > > CONFIG_UIO_PDRV_GENIRQ=m
> > > CONFIG_UIO_DMEM_GENIRQ=m
> > > CONFIG_UIO_AEC=m
> > > CONFIG_UIO_SERCOS3=m
> > > CONFIG_UIO_PCI_GENERIC=m
> > > CONFIG_UIO_NETX=m
> > > CONFIG_UIO_PRUSS=m
> > > CONFIG_UIO_MF624=m
> > > CONFIG_UIO_HV_GENERIC=m
> > > CONFIG_VFIO_IOMMU_TYPE1=m
> > > CONFIG_VFIO_VIRQFD=m
> > > CONFIG_VFIO=m
> > > CONFIG_VFIO_NOIOMMU=y
> > > CONFIG_VFIO_PCI=m
> > > CONFIG_VFIO_PCI_VGA=y
> > > CONFIG_VFIO_PCI_MMAP=y
> > > CONFIG_VFIO_PCI_INTX=y
> > > CONFIG_VFIO_PCI_IGD=y
> > > CONFIG_VFIO_MDEV=m
> > > CONFIG_VFIO_MDEV_DEVICE=m
> > > CONFIG_IRQ_BYPASS_MANAGER=m
> > > CONFIG_VIRT_DRIVERS=y
> > > # CONFIG_VBOXGUEST is not set
> > > CONFIG_VIRTIO=y
> > > CONFIG_VIRTIO_MENU=y
> > > CONFIG_VIRTIO_PCI=y
> > > CONFIG_VIRTIO_PCI_LEGACY=y
> > > CONFIG_VIRTIO_PMEM=m
> > > CONFIG_VIRTIO_BALLOON=y
> > > CONFIG_VIRTIO_INPUT=m
> > > CONFIG_VIRTIO_MMIO=y
> > > CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
> > > 
> > > #
> > > # Microsoft Hyper-V guest support
> > > #
> > > CONFIG_HYPERV=m
> > > CONFIG_HYPERV_TIMER=y
> > > CONFIG_HYPERV_UTILS=m
> > > CONFIG_HYPERV_BALLOON=m
> > > # end of Microsoft Hyper-V guest support
> > > 
> > > #
> > > # Xen driver support
> > > #
> > > CONFIG_XEN_BALLOON=y
> > > CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=y
> > > CONFIG_XEN_BALLOON_MEMORY_HOTPLUG_LIMIT=512
> > > CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
> > > CONFIG_XEN_DEV_EVTCHN=m
> > > CONFIG_XEN_BACKEND=y
> > > CONFIG_XENFS=m
> > > CONFIG_XEN_COMPAT_XENFS=y
> > > CONFIG_XEN_SYS_HYPERVISOR=y
> > > CONFIG_XEN_XENBUS_FRONTEND=y
> > > CONFIG_XEN_GNTDEV=m
> > > CONFIG_XEN_GNTDEV_DMABUF=y
> > > CONFIG_XEN_GRANT_DEV_ALLOC=m
> > > CONFIG_XEN_GRANT_DMA_ALLOC=y
> > > CONFIG_SWIOTLB_XEN=y
> > > CONFIG_XEN_PCIDEV_BACKEND=m
> > > CONFIG_XEN_PVCALLS_FRONTEND=m
> > > # CONFIG_XEN_PVCALLS_BACKEND is not set
> > > CONFIG_XEN_SCSI_BACKEND=m
> > > CONFIG_XEN_PRIVCMD=m
> > > CONFIG_XEN_ACPI_PROCESSOR=y
> > > CONFIG_XEN_MCE_LOG=y
> > > CONFIG_XEN_HAVE_PVMMU=y
> > > CONFIG_XEN_EFI=y
> > > CONFIG_XEN_AUTO_XLATE=y
> > > CONFIG_XEN_ACPI=y
> > > CONFIG_XEN_SYMS=y
> > > CONFIG_XEN_HAVE_VPMU=y
> > > CONFIG_XEN_FRONT_PGDIR_SHBUF=m
> > > # end of Xen driver support
> > > 
> > > CONFIG_GREYBUS=m
> > > CONFIG_GREYBUS_ES2=m
> > > CONFIG_STAGING=y
> > > CONFIG_PRISM2_USB=m
> > > CONFIG_COMEDI=m
> > > # CONFIG_COMEDI_DEBUG is not set
> > > CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
> > > CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
> > > CONFIG_COMEDI_MISC_DRIVERS=y
> > > CONFIG_COMEDI_BOND=m
> > > CONFIG_COMEDI_TEST=m
> > > CONFIG_COMEDI_PARPORT=m
> > > CONFIG_COMEDI_ISA_DRIVERS=y
> > > CONFIG_COMEDI_PCL711=m
> > > CONFIG_COMEDI_PCL724=m
> > > CONFIG_COMEDI_PCL726=m
> > > CONFIG_COMEDI_PCL730=m
> > > CONFIG_COMEDI_PCL812=m
> > > CONFIG_COMEDI_PCL816=m
> > > CONFIG_COMEDI_PCL818=m
> > > CONFIG_COMEDI_PCM3724=m
> > > CONFIG_COMEDI_AMPLC_DIO200_ISA=m
> > > CONFIG_COMEDI_AMPLC_PC236_ISA=m
> > > CONFIG_COMEDI_AMPLC_PC263_ISA=m
> > > CONFIG_COMEDI_RTI800=m
> > > CONFIG_COMEDI_RTI802=m
> > > CONFIG_COMEDI_DAC02=m
> > > CONFIG_COMEDI_DAS16M1=m
> > > CONFIG_COMEDI_DAS08_ISA=m
> > > CONFIG_COMEDI_DAS16=m
> > > CONFIG_COMEDI_DAS800=m
> > > CONFIG_COMEDI_DAS1800=m
> > > CONFIG_COMEDI_DAS6402=m
> > > CONFIG_COMEDI_DT2801=m
> > > CONFIG_COMEDI_DT2811=m
> > > CONFIG_COMEDI_DT2814=m
> > > CONFIG_COMEDI_DT2815=m
> > > CONFIG_COMEDI_DT2817=m
> > > CONFIG_COMEDI_DT282X=m
> > > CONFIG_COMEDI_DMM32AT=m
> > > CONFIG_COMEDI_FL512=m
> > > CONFIG_COMEDI_AIO_AIO12_8=m
> > > CONFIG_COMEDI_AIO_IIRO_16=m
> > > CONFIG_COMEDI_II_PCI20KC=m
> > > CONFIG_COMEDI_C6XDIGIO=m
> > > CONFIG_COMEDI_MPC624=m
> > > CONFIG_COMEDI_ADQ12B=m
> > > CONFIG_COMEDI_NI_AT_A2150=m
> > > CONFIG_COMEDI_NI_AT_AO=m
> > > CONFIG_COMEDI_NI_ATMIO=m
> > > CONFIG_COMEDI_NI_ATMIO16D=m
> > > CONFIG_COMEDI_NI_LABPC_ISA=m
> > > CONFIG_COMEDI_PCMAD=m
> > > CONFIG_COMEDI_PCMDA12=m
> > > CONFIG_COMEDI_PCMMIO=m
> > > CONFIG_COMEDI_PCMUIO=m
> > > CONFIG_COMEDI_MULTIQ3=m
> > > CONFIG_COMEDI_S526=m
> > > CONFIG_COMEDI_PCI_DRIVERS=m
> > > CONFIG_COMEDI_8255_PCI=m
> > > CONFIG_COMEDI_ADDI_WATCHDOG=m
> > > CONFIG_COMEDI_ADDI_APCI_1032=m
> > > CONFIG_COMEDI_ADDI_APCI_1500=m
> > > CONFIG_COMEDI_ADDI_APCI_1516=m
> > > CONFIG_COMEDI_ADDI_APCI_1564=m
> > > CONFIG_COMEDI_ADDI_APCI_16XX=m
> > > CONFIG_COMEDI_ADDI_APCI_2032=m
> > > CONFIG_COMEDI_ADDI_APCI_2200=m
> > > CONFIG_COMEDI_ADDI_APCI_3120=m
> > > CONFIG_COMEDI_ADDI_APCI_3501=m
> > > CONFIG_COMEDI_ADDI_APCI_3XXX=m
> > > CONFIG_COMEDI_ADL_PCI6208=m
> > > CONFIG_COMEDI_ADL_PCI7X3X=m
> > > CONFIG_COMEDI_ADL_PCI8164=m
> > > CONFIG_COMEDI_ADL_PCI9111=m
> > > CONFIG_COMEDI_ADL_PCI9118=m
> > > CONFIG_COMEDI_ADV_PCI1710=m
> > > CONFIG_COMEDI_ADV_PCI1720=m
> > > CONFIG_COMEDI_ADV_PCI1723=m
> > > CONFIG_COMEDI_ADV_PCI1724=m
> > > CONFIG_COMEDI_ADV_PCI1760=m
> > > CONFIG_COMEDI_ADV_PCI_DIO=m
> > > CONFIG_COMEDI_AMPLC_DIO200_PCI=m
> > > CONFIG_COMEDI_AMPLC_PC236_PCI=m
> > > CONFIG_COMEDI_AMPLC_PC263_PCI=m
> > > CONFIG_COMEDI_AMPLC_PCI224=m
> > > CONFIG_COMEDI_AMPLC_PCI230=m
> > > CONFIG_COMEDI_CONTEC_PCI_DIO=m
> > > CONFIG_COMEDI_DAS08_PCI=m
> > > CONFIG_COMEDI_DT3000=m
> > > CONFIG_COMEDI_DYNA_PCI10XX=m
> > > CONFIG_COMEDI_GSC_HPDI=m
> > > CONFIG_COMEDI_MF6X4=m
> > > CONFIG_COMEDI_ICP_MULTI=m
> > > CONFIG_COMEDI_DAQBOARD2000=m
> > > CONFIG_COMEDI_JR3_PCI=m
> > > CONFIG_COMEDI_KE_COUNTER=m
> > > CONFIG_COMEDI_CB_PCIDAS64=m
> > > CONFIG_COMEDI_CB_PCIDAS=m
> > > CONFIG_COMEDI_CB_PCIDDA=m
> > > CONFIG_COMEDI_CB_PCIMDAS=m
> > > CONFIG_COMEDI_CB_PCIMDDA=m
> > > CONFIG_COMEDI_ME4000=m
> > > CONFIG_COMEDI_ME_DAQ=m
> > > CONFIG_COMEDI_NI_6527=m
> > > CONFIG_COMEDI_NI_65XX=m
> > > CONFIG_COMEDI_NI_660X=m
> > > CONFIG_COMEDI_NI_670X=m
> > > CONFIG_COMEDI_NI_LABPC_PCI=m
> > > CONFIG_COMEDI_NI_PCIDIO=m
> > > CONFIG_COMEDI_NI_PCIMIO=m
> > > CONFIG_COMEDI_RTD520=m
> > > CONFIG_COMEDI_S626=m
> > > CONFIG_COMEDI_MITE=m
> > > CONFIG_COMEDI_NI_TIOCMD=m
> > > CONFIG_COMEDI_PCMCIA_DRIVERS=m
> > > CONFIG_COMEDI_CB_DAS16_CS=m
> > > CONFIG_COMEDI_DAS08_CS=m
> > > CONFIG_COMEDI_NI_DAQ_700_CS=m
> > > CONFIG_COMEDI_NI_DAQ_DIO24_CS=m
> > > CONFIG_COMEDI_NI_LABPC_CS=m
> > > CONFIG_COMEDI_NI_MIO_CS=m
> > > CONFIG_COMEDI_QUATECH_DAQP_CS=m
> > > CONFIG_COMEDI_USB_DRIVERS=m
> > > CONFIG_COMEDI_DT9812=m
> > > CONFIG_COMEDI_NI_USB6501=m
> > > CONFIG_COMEDI_USBDUX=m
> > > CONFIG_COMEDI_USBDUXFAST=m
> > > CONFIG_COMEDI_USBDUXSIGMA=m
> > > CONFIG_COMEDI_VMK80XX=m
> > > CONFIG_COMEDI_8254=m
> > > CONFIG_COMEDI_8255=m
> > > CONFIG_COMEDI_8255_SA=m
> > > CONFIG_COMEDI_KCOMEDILIB=m
> > > CONFIG_COMEDI_AMPLC_DIO200=m
> > > CONFIG_COMEDI_AMPLC_PC236=m
> > > CONFIG_COMEDI_DAS08=m
> > > CONFIG_COMEDI_ISADMA=m
> > > CONFIG_COMEDI_NI_LABPC=m
> > > CONFIG_COMEDI_NI_LABPC_ISADMA=m
> > > CONFIG_COMEDI_NI_TIO=m
> > > CONFIG_COMEDI_NI_ROUTING=m
> > > CONFIG_RTL8192U=m
> > > CONFIG_RTLLIB=m
> > > CONFIG_RTLLIB_CRYPTO_CCMP=m
> > > CONFIG_RTLLIB_CRYPTO_TKIP=m
> > > CONFIG_RTLLIB_CRYPTO_WEP=m
> > > CONFIG_RTL8192E=m
> > > CONFIG_RTL8723BS=m
> > > CONFIG_R8712U=m
> > > CONFIG_R8188EU=m
> > > CONFIG_88EU_AP_MODE=y
> > > CONFIG_RTS5208=m
> > > CONFIG_VT6655=m
> > > CONFIG_VT6656=m
> > > 
> > > #
> > > # IIO staging drivers
> > > #
> > > 
> > > #
> > > # Accelerometers
> > > #
> > > CONFIG_ADIS16203=m
> > > CONFIG_ADIS16240=m
> > > # end of Accelerometers
> > > 
> > > #
> > > # Analog to digital converters
> > > #
> > > CONFIG_AD7816=m
> > > CONFIG_AD7192=m
> > > CONFIG_AD7280=m
> > > # end of Analog to digital converters
> > > 
> > > #
> > > # Analog digital bi-direction converters
> > > #
> > > CONFIG_ADT7316=m
> > > CONFIG_ADT7316_SPI=m
> > > CONFIG_ADT7316_I2C=m
> > > # end of Analog digital bi-direction converters
> > > 
> > > #
> > > # Capacitance to digital converters
> > > #
> > > CONFIG_AD7150=m
> > > CONFIG_AD7746=m
> > > # end of Capacitance to digital converters
> > > 
> > > #
> > > # Direct Digital Synthesis
> > > #
> > > CONFIG_AD9832=m
> > > CONFIG_AD9834=m
> > > # end of Direct Digital Synthesis
> > > 
> > > #
> > > # Network Analyzer, Impedance Converters
> > > #
> > > CONFIG_AD5933=m
> > > # end of Network Analyzer, Impedance Converters
> > > 
> > > #
> > > # Active energy metering IC
> > > #
> > > CONFIG_ADE7854=m
> > > CONFIG_ADE7854_I2C=m
> > > CONFIG_ADE7854_SPI=m
> > > # end of Active energy metering IC
> > > 
> > > #
> > > # Resolver to digital converters
> > > #
> > > CONFIG_AD2S1210=m
> > > # end of Resolver to digital converters
> > > # end of IIO staging drivers
> > > 
> > > CONFIG_FB_SM750=m
> > > 
> > > #
> > > # Speakup console speech
> > > #
> > > CONFIG_SPEAKUP=m
> > > CONFIG_SPEAKUP_SYNTH_ACNTSA=m
> > > CONFIG_SPEAKUP_SYNTH_APOLLO=m
> > > CONFIG_SPEAKUP_SYNTH_AUDPTR=m
> > > CONFIG_SPEAKUP_SYNTH_BNS=m
> > > CONFIG_SPEAKUP_SYNTH_DECTLK=m
> > > CONFIG_SPEAKUP_SYNTH_DECEXT=m
> > > CONFIG_SPEAKUP_SYNTH_LTLK=m
> > > CONFIG_SPEAKUP_SYNTH_SOFT=m
> > > CONFIG_SPEAKUP_SYNTH_SPKOUT=m
> > > CONFIG_SPEAKUP_SYNTH_TXPRT=m
> > > CONFIG_SPEAKUP_SYNTH_DUMMY=m
> > > # end of Speakup console speech
> > > 
> > > CONFIG_STAGING_MEDIA=y
> > > CONFIG_VIDEO_IPU3_IMGU=m
> > > 
> > > #
> > > # soc_camera sensor drivers
> > > #
> > > 
> > > #
> > > # Android
> > > #
> > > # CONFIG_ASHMEM is not set
> > > # CONFIG_ANDROID_VSOC is not set
> > > # CONFIG_ION is not set
> > > # end of Android
> > > 
> > > CONFIG_LTE_GDM724X=m
> > > CONFIG_FIREWIRE_SERIAL=m
> > > CONFIG_FWTTY_MAX_TOTAL_PORTS=64
> > > CONFIG_FWTTY_MAX_CARD_PORTS=32
> > > CONFIG_GS_FPGABOOT=m
> > > CONFIG_UNISYSSPAR=y
> > > CONFIG_UNISYS_VISORNIC=m
> > > CONFIG_UNISYS_VISORINPUT=m
> > > CONFIG_UNISYS_VISORHBA=m
> > > # CONFIG_FB_TFT is not set
> > > CONFIG_WILC1000=m
> > > CONFIG_WILC1000_SDIO=m
> > > CONFIG_WILC1000_SPI=m
> > > CONFIG_WILC1000_HW_OOB_INTR=y
> > > CONFIG_MOST=m
> > > CONFIG_MOST_CDEV=m
> > > CONFIG_MOST_NET=m
> > > CONFIG_MOST_SOUND=m
> > > CONFIG_MOST_VIDEO=m
> > > CONFIG_MOST_I2C=m
> > > CONFIG_MOST_USB=m
> > > CONFIG_KS7010=m
> > > CONFIG_GREYBUS_AUDIO=m
> > > CONFIG_GREYBUS_BOOTROM=m
> > > CONFIG_GREYBUS_FIRMWARE=m
> > > CONFIG_GREYBUS_HID=m
> > > CONFIG_GREYBUS_LIGHT=m
> > > CONFIG_GREYBUS_LOG=m
> > > CONFIG_GREYBUS_LOOPBACK=m
> > > CONFIG_GREYBUS_POWER=m
> > > CONFIG_GREYBUS_RAW=m
> > > CONFIG_GREYBUS_VIBRATOR=m
> > > CONFIG_GREYBUS_BRIDGED_PHY=m
> > > CONFIG_GREYBUS_GPIO=m
> > > CONFIG_GREYBUS_I2C=m
> > > CONFIG_GREYBUS_PWM=m
> > > CONFIG_GREYBUS_SDIO=m
> > > CONFIG_GREYBUS_SPI=m
> > > CONFIG_GREYBUS_UART=m
> > > CONFIG_GREYBUS_USB=m
> > > CONFIG_PI433=m
> > > 
> > > #
> > > # Gasket devices
> > > #
> > > CONFIG_STAGING_GASKET_FRAMEWORK=m
> > > CONFIG_STAGING_APEX_DRIVER=m
> > > # end of Gasket devices
> > > 
> > > CONFIG_FIELDBUS_DEV=m
> > > CONFIG_KPC2000=y
> > > CONFIG_KPC2000_CORE=m
> > > CONFIG_KPC2000_SPI=m
> > > CONFIG_KPC2000_I2C=m
> > > CONFIG_KPC2000_DMA=m
> > > 
> > > #
> > > # ISDN CAPI drivers
> > > #
> > > CONFIG_CAPI_AVM=y
> > > CONFIG_ISDN_DRV_AVMB1_B1PCI=m
> > > CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
> > > CONFIG_ISDN_DRV_AVMB1_B1PCMCIA=m
> > > CONFIG_ISDN_DRV_AVMB1_AVM_CS=m
> > > CONFIG_ISDN_DRV_AVMB1_T1PCI=m
> > > CONFIG_ISDN_DRV_AVMB1_C4=m
> > > CONFIG_ISDN_DRV_GIGASET=m
> > > # CONFIG_GIGASET_CAPI is not set
> > > CONFIG_GIGASET_BASE=m
> > > CONFIG_GIGASET_M105=m
> > > CONFIG_GIGASET_M101=m
> > > # CONFIG_GIGASET_DEBUG is not set
> > > CONFIG_HYSDN=m
> > > CONFIG_HYSDN_CAPI=y
> > > # end of ISDN CAPI drivers
> > > 
> > > CONFIG_USB_WUSB=m
> > > CONFIG_USB_WUSB_CBAF=m
> > > # CONFIG_USB_WUSB_CBAF_DEBUG is not set
> > > CONFIG_USB_WHCI_HCD=m
> > > CONFIG_USB_HWA_HCD=m
> > > CONFIG_UWB=m
> > > CONFIG_UWB_HWA=m
> > > CONFIG_UWB_WHCI=m
> > > CONFIG_UWB_I1480U=m
> > > # CONFIG_EXFAT_FS is not set
> > > CONFIG_QLGE=m
> > > CONFIG_NET_VENDOR_HP=y
> > > CONFIG_HP100=m
> > > # CONFIG_WFX is not set
> > > CONFIG_X86_PLATFORM_DEVICES=y
> > > CONFIG_ACER_WMI=m
> > > CONFIG_ACER_WIRELESS=m
> > > CONFIG_ACERHDF=m
> > > CONFIG_ALIENWARE_WMI=m
> > > CONFIG_ASUS_LAPTOP=m
> > > CONFIG_DCDBAS=m
> > > CONFIG_DELL_SMBIOS=m
> > > CONFIG_DELL_SMBIOS_WMI=y
> > > CONFIG_DELL_SMBIOS_SMM=y
> > > CONFIG_DELL_LAPTOP=m
> > > CONFIG_DELL_WMI=m
> > > CONFIG_DELL_WMI_DESCRIPTOR=m
> > > CONFIG_DELL_WMI_AIO=m
> > > CONFIG_DELL_WMI_LED=m
> > > CONFIG_DELL_SMO8800=m
> > > CONFIG_DELL_RBTN=m
> > > CONFIG_DELL_RBU=m
> > > CONFIG_FUJITSU_LAPTOP=m
> > > CONFIG_FUJITSU_TABLET=m
> > > CONFIG_AMILO_RFKILL=m
> > > CONFIG_GPD_POCKET_FAN=m
> > > CONFIG_HP_ACCEL=m
> > > CONFIG_HP_WIRELESS=m
> > > CONFIG_HP_WMI=m
> > > CONFIG_LG_LAPTOP=m
> > > CONFIG_MSI_LAPTOP=m
> > > CONFIG_PANASONIC_LAPTOP=m
> > > CONFIG_COMPAL_LAPTOP=m
> > > CONFIG_SONY_LAPTOP=m
> > > CONFIG_SONYPI_COMPAT=y
> > > CONFIG_IDEAPAD_LAPTOP=m
> > > CONFIG_SURFACE3_WMI=m
> > > CONFIG_THINKPAD_ACPI=m
> > > CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
> > > CONFIG_THINKPAD_ACPI_DEBUGFACILITIES=y
> > > # CONFIG_THINKPAD_ACPI_DEBUG is not set
> > > # CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
> > > CONFIG_THINKPAD_ACPI_VIDEO=y
> > > CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
> > > CONFIG_SENSORS_HDAPS=m
> > > CONFIG_INTEL_MENLOW=m
> > > CONFIG_EEEPC_LAPTOP=m
> > > CONFIG_ASUS_WMI=m
> > > CONFIG_ASUS_NB_WMI=m
> > > CONFIG_EEEPC_WMI=m
> > > CONFIG_ASUS_WIRELESS=m
> > > CONFIG_ACPI_WMI=m
> > > CONFIG_WMI_BMOF=m
> > > CONFIG_INTEL_WMI_THUNDERBOLT=m
> > > CONFIG_XIAOMI_WMI=m
> > > CONFIG_MSI_WMI=m
> > > CONFIG_PEAQ_WMI=m
> > > CONFIG_TOPSTAR_LAPTOP=m
> > > CONFIG_ACPI_TOSHIBA=m
> > > CONFIG_TOSHIBA_BT_RFKILL=m
> > > CONFIG_TOSHIBA_HAPS=m
> > > # CONFIG_TOSHIBA_WMI is not set
> > > CONFIG_ACPI_CMPC=m
> > > CONFIG_INTEL_CHT_INT33FE=m
> > > CONFIG_INTEL_INT0002_VGPIO=m
> > > CONFIG_INTEL_HID_EVENT=m
> > > CONFIG_INTEL_VBTN=m
> > > CONFIG_INTEL_IPS=m
> > > CONFIG_INTEL_PMC_CORE=y
> > > CONFIG_IBM_RTL=m
> > > CONFIG_SAMSUNG_LAPTOP=m
> > > CONFIG_MXM_WMI=m
> > > CONFIG_INTEL_OAKTRAIL=m
> > > CONFIG_SAMSUNG_Q10=m
> > > CONFIG_APPLE_GMUX=m
> > > CONFIG_INTEL_RST=m
> > > CONFIG_INTEL_SMARTCONNECT=m
> > > CONFIG_INTEL_PMC_IPC=m
> > > CONFIG_INTEL_BXTWC_PMIC_TMU=m
> > > CONFIG_SURFACE_PRO3_BUTTON=m
> > > CONFIG_SURFACE_3_BUTTON=m
> > > CONFIG_INTEL_PUNIT_IPC=m
> > > CONFIG_INTEL_TELEMETRY=m
> > > CONFIG_MLX_PLATFORM=m
> > > CONFIG_INTEL_TURBO_MAX_3=y
> > > CONFIG_TOUCHSCREEN_DMI=y
> > > CONFIG_INTEL_CHTDC_TI_PWRBTN=m
> > > CONFIG_I2C_MULTI_INSTANTIATE=m
> > > CONFIG_INTEL_ATOMISP2_PM=m
> > > CONFIG_HUAWEI_WMI=m
> > > CONFIG_PCENGINES_APU2=m
> > > 
> > > #
> > > # Intel Speed Select Technology interface support
> > > #
> > > CONFIG_INTEL_SPEED_SELECT_INTERFACE=m
> > > # end of Intel Speed Select Technology interface support
> > > 
> > > # CONFIG_SYSTEM76_ACPI is not set
> > > CONFIG_PMC_ATOM=y
> > > CONFIG_MFD_CROS_EC=m
> > > CONFIG_CHROME_PLATFORMS=y
> > > CONFIG_CHROMEOS_LAPTOP=m
> > > CONFIG_CHROMEOS_PSTORE=m
> > > CONFIG_CHROMEOS_TBMC=m
> > > CONFIG_CROS_EC=m
> > > CONFIG_CROS_EC_I2C=m
> > > CONFIG_CROS_EC_ISHTP=m
> > > CONFIG_CROS_EC_SPI=m
> > > CONFIG_CROS_EC_LPC=m
> > > CONFIG_CROS_EC_PROTO=y
> > > CONFIG_CROS_KBD_LED_BACKLIGHT=m
> > > CONFIG_CROS_EC_CHARDEV=m
> > > CONFIG_CROS_EC_LIGHTBAR=m
> > > CONFIG_CROS_EC_DEBUGFS=m
> > > CONFIG_CROS_EC_SENSORHUB=m
> > > CONFIG_CROS_EC_SYSFS=m
> > > CONFIG_CROS_USBPD_LOGGER=m
> > > CONFIG_WILCO_EC=m
> > > CONFIG_WILCO_EC_DEBUGFS=m
> > > CONFIG_WILCO_EC_EVENTS=m
> > > CONFIG_WILCO_EC_TELEMETRY=m
> > > CONFIG_MELLANOX_PLATFORM=y
> > > CONFIG_MLXREG_HOTPLUG=m
> > > CONFIG_MLXREG_IO=m
> > > CONFIG_CLKDEV_LOOKUP=y
> > > CONFIG_HAVE_CLK_PREPARE=y
> > > CONFIG_COMMON_CLK=y
> > > 
> > > #
> > > # Common Clock Framework
> > > #
> > > CONFIG_COMMON_CLK_WM831X=m
> > > CONFIG_COMMON_CLK_MAX9485=m
> > > CONFIG_COMMON_CLK_SI5341=m
> > > CONFIG_COMMON_CLK_SI5351=m
> > > CONFIG_COMMON_CLK_SI544=m
> > > CONFIG_COMMON_CLK_CDCE706=m
> > > CONFIG_COMMON_CLK_CS2000_CP=m
> > > CONFIG_COMMON_CLK_S2MPS11=m
> > > CONFIG_CLK_TWL6040=m
> > > CONFIG_COMMON_CLK_PALMAS=m
> > > CONFIG_COMMON_CLK_PWM=m
> > > # end of Common Clock Framework
> > > 
> > > CONFIG_HWSPINLOCK=y
> > > 
> > > #
> > > # Clock Source drivers
> > > #
> > > CONFIG_CLKEVT_I8253=y
> > > CONFIG_I8253_LOCK=y
> > > CONFIG_CLKBLD_I8253=y
> > > # end of Clock Source drivers
> > > 
> > > CONFIG_MAILBOX=y
> > > CONFIG_PCC=y
> > > CONFIG_ALTERA_MBOX=m
> > > CONFIG_IOMMU_IOVA=y
> > > CONFIG_IOMMU_API=y
> > > CONFIG_IOMMU_SUPPORT=y
> > > 
> > > #
> > > # Generic IOMMU Pagetable Support
> > > #
> > > # end of Generic IOMMU Pagetable Support
> > > 
> > > # CONFIG_IOMMU_DEBUGFS is not set
> > > # CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
> > > CONFIG_IOMMU_DMA=y
> > > CONFIG_AMD_IOMMU=y
> > > CONFIG_AMD_IOMMU_V2=m
> > > CONFIG_DMAR_TABLE=y
> > > CONFIG_INTEL_IOMMU=y
> > > CONFIG_INTEL_IOMMU_SVM=y
> > > # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
> > > CONFIG_INTEL_IOMMU_FLOPPY_WA=y
> > > CONFIG_IRQ_REMAP=y
> > > CONFIG_HYPERV_IOMMU=y
> > > 
> > > #
> > > # Remoteproc drivers
> > > #
> > > # CONFIG_REMOTEPROC is not set
> > > # end of Remoteproc drivers
> > > 
> > > #
> > > # Rpmsg drivers
> > > #
> > > CONFIG_RPMSG=m
> > > CONFIG_RPMSG_CHAR=m
> > > CONFIG_RPMSG_QCOM_GLINK_NATIVE=m
> > > CONFIG_RPMSG_QCOM_GLINK_RPM=m
> > > CONFIG_RPMSG_VIRTIO=m
> > > # end of Rpmsg drivers
> > > 
> > > CONFIG_SOUNDWIRE=y
> > > 
> > > #
> > > # SoundWire Devices
> > > #
> > > CONFIG_SOUNDWIRE_CADENCE=m
> > > CONFIG_SOUNDWIRE_INTEL=m
> > > 
> > > #
> > > # SOC (System On Chip) specific Drivers
> > > #
> > > 
> > > #
> > > # Amlogic SoC drivers
> > > #
> > > # end of Amlogic SoC drivers
> > > 
> > > #
> > > # Aspeed SoC drivers
> > > #
> > > # end of Aspeed SoC drivers
> > > 
> > > #
> > > # Broadcom SoC drivers
> > > #
> > > # end of Broadcom SoC drivers
> > > 
> > > #
> > > # NXP/Freescale QorIQ SoC drivers
> > > #
> > > # end of NXP/Freescale QorIQ SoC drivers
> > > 
> > > #
> > > # i.MX SoC drivers
> > > #
> > > # end of i.MX SoC drivers
> > > 
> > > #
> > > # Qualcomm SoC drivers
> > > #
> > > # end of Qualcomm SoC drivers
> > > 
> > > CONFIG_SOC_TI=y
> > > 
> > > #
> > > # Xilinx SoC drivers
> > > #
> > > CONFIG_XILINX_VCU=m
> > > # end of Xilinx SoC drivers
> > > # end of SOC (System On Chip) specific Drivers
> > > 
> > > CONFIG_PM_DEVFREQ=y
> > > 
> > > #
> > > # DEVFREQ Governors
> > > #
> > > CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
> > > CONFIG_DEVFREQ_GOV_PERFORMANCE=y
> > > CONFIG_DEVFREQ_GOV_POWERSAVE=y
> > > CONFIG_DEVFREQ_GOV_USERSPACE=y
> > > CONFIG_DEVFREQ_GOV_PASSIVE=y
> > > 
> > > #
> > > # DEVFREQ Drivers
> > > #
> > > CONFIG_PM_DEVFREQ_EVENT=y
> > > CONFIG_EXTCON=y
> > > 
> > > #
> > > # Extcon Device Drivers
> > > #
> > > CONFIG_EXTCON_ADC_JACK=m
> > > CONFIG_EXTCON_ARIZONA=m
> > > CONFIG_EXTCON_AXP288=m
> > > CONFIG_EXTCON_FSA9480=m
> > > CONFIG_EXTCON_GPIO=m
> > > CONFIG_EXTCON_INTEL_INT3496=m
> > > CONFIG_EXTCON_INTEL_CHT_WC=m
> > > CONFIG_EXTCON_MAX14577=m
> > > CONFIG_EXTCON_MAX3355=m
> > > CONFIG_EXTCON_MAX77693=m
> > > CONFIG_EXTCON_MAX77843=m
> > > CONFIG_EXTCON_MAX8997=m
> > > CONFIG_EXTCON_PALMAS=m
> > > CONFIG_EXTCON_PTN5150=m
> > > CONFIG_EXTCON_RT8973A=m
> > > CONFIG_EXTCON_SM5502=m
> > > CONFIG_EXTCON_USB_GPIO=m
> > > CONFIG_EXTCON_USBC_CROS_EC=m
> > > CONFIG_MEMORY=y
> > > CONFIG_IIO=m
> > > CONFIG_IIO_BUFFER=y
> > > CONFIG_IIO_BUFFER_CB=m
> > > CONFIG_IIO_BUFFER_HW_CONSUMER=m
> > > CONFIG_IIO_KFIFO_BUF=m
> > > CONFIG_IIO_TRIGGERED_BUFFER=m
> > > CONFIG_IIO_CONFIGFS=m
> > > CONFIG_IIO_TRIGGER=y
> > > CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> > > CONFIG_IIO_SW_DEVICE=m
> > > CONFIG_IIO_SW_TRIGGER=m
> > > CONFIG_IIO_TRIGGERED_EVENT=m
> > > 
> > > #
> > > # Accelerometers
> > > #
> > > CONFIG_ADIS16201=m
> > > CONFIG_ADIS16209=m
> > > CONFIG_ADXL372=m
> > > CONFIG_ADXL372_SPI=m
> > > CONFIG_ADXL372_I2C=m
> > > CONFIG_BMA180=m
> > > CONFIG_BMA220=m
> > > CONFIG_BMC150_ACCEL=m
> > > CONFIG_BMC150_ACCEL_I2C=m
> > > CONFIG_BMC150_ACCEL_SPI=m
> > > CONFIG_DA280=m
> > > CONFIG_DA311=m
> > > CONFIG_DMARD09=m
> > > CONFIG_DMARD10=m
> > > CONFIG_HID_SENSOR_ACCEL_3D=m
> > > CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
> > > CONFIG_IIO_ST_ACCEL_3AXIS=m
> > > CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
> > > CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
> > > CONFIG_KXSD9=m
> > > CONFIG_KXSD9_SPI=m
> > > CONFIG_KXSD9_I2C=m
> > > CONFIG_KXCJK1013=m
> > > CONFIG_MC3230=m
> > > CONFIG_MMA7455=m
> > > CONFIG_MMA7455_I2C=m
> > > CONFIG_MMA7455_SPI=m
> > > CONFIG_MMA7660=m
> > > CONFIG_MMA8452=m
> > > CONFIG_MMA9551_CORE=m
> > > CONFIG_MMA9551=m
> > > CONFIG_MMA9553=m
> > > CONFIG_MXC4005=m
> > > CONFIG_MXC6255=m
> > > CONFIG_SCA3000=m
> > > CONFIG_STK8312=m
> > > CONFIG_STK8BA50=m
> > > # end of Accelerometers
> > > 
> > > #
> > > # Analog to digital converters
> > > #
> > > CONFIG_AD_SIGMA_DELTA=m
> > > CONFIG_AD7124=m
> > > CONFIG_AD7266=m
> > > CONFIG_AD7291=m
> > > # CONFIG_AD7292 is not set
> > > CONFIG_AD7298=m
> > > CONFIG_AD7476=m
> > > CONFIG_AD7606=m
> > > CONFIG_AD7606_IFACE_PARALLEL=m
> > > CONFIG_AD7606_IFACE_SPI=m
> > > CONFIG_AD7766=m
> > > CONFIG_AD7768_1=m
> > > CONFIG_AD7780=m
> > > CONFIG_AD7791=m
> > > CONFIG_AD7793=m
> > > CONFIG_AD7887=m
> > > CONFIG_AD7923=m
> > > CONFIG_AD7949=m
> > > CONFIG_AD799X=m
> > > CONFIG_AXP20X_ADC=m
> > > CONFIG_AXP288_ADC=m
> > > CONFIG_CC10001_ADC=m
> > > CONFIG_DA9150_GPADC=m
> > > CONFIG_DLN2_ADC=m
> > > CONFIG_HI8435=m
> > > CONFIG_HX711=m
> > > CONFIG_INA2XX_ADC=m
> > > CONFIG_LP8788_ADC=m
> > > CONFIG_LTC2471=m
> > > CONFIG_LTC2485=m
> > > CONFIG_LTC2497=m
> > > CONFIG_MAX1027=m
> > > CONFIG_MAX11100=m
> > > CONFIG_MAX1118=m
> > > CONFIG_MAX1363=m
> > > CONFIG_MAX9611=m
> > > CONFIG_MCP320X=m
> > > CONFIG_MCP3422=m
> > > CONFIG_MCP3911=m
> > > CONFIG_MEN_Z188_ADC=m
> > > CONFIG_NAU7802=m
> > > CONFIG_PALMAS_GPADC=m
> > > CONFIG_QCOM_VADC_COMMON=m
> > > CONFIG_QCOM_SPMI_IADC=m
> > > CONFIG_QCOM_SPMI_VADC=m
> > > CONFIG_QCOM_SPMI_ADC5=m
> > > CONFIG_STX104=m
> > > CONFIG_TI_ADC081C=m
> > > CONFIG_TI_ADC0832=m
> > > CONFIG_TI_ADC084S021=m
> > > CONFIG_TI_ADC12138=m
> > > CONFIG_TI_ADC108S102=m
> > > CONFIG_TI_ADC128S052=m
> > > CONFIG_TI_ADC161S626=m
> > > CONFIG_TI_ADS1015=m
> > > CONFIG_TI_ADS7950=m
> > > CONFIG_TI_AM335X_ADC=m
> > > CONFIG_TI_TLC4541=m
> > > CONFIG_TWL4030_MADC=m
> > > CONFIG_TWL6030_GPADC=m
> > > CONFIG_VIPERBOARD_ADC=m
> > > CONFIG_XILINX_XADC=m
> > > # end of Analog to digital converters
> > > 
> > > #
> > > # Analog Front Ends
> > > #
> > > # end of Analog Front Ends
> > > 
> > > #
> > > # Amplifiers
> > > #
> > > CONFIG_AD8366=m
> > > # end of Amplifiers
> > > 
> > > #
> > > # Chemical Sensors
> > > #
> > > CONFIG_ATLAS_PH_SENSOR=m
> > > CONFIG_BME680=m
> > > CONFIG_BME680_I2C=m
> > > CONFIG_BME680_SPI=m
> > > CONFIG_CCS811=m
> > > CONFIG_IAQCORE=m
> > > CONFIG_PMS7003=m
> > > CONFIG_SENSIRION_SGP30=m
> > > CONFIG_SPS30=m
> > > CONFIG_VZ89X=m
> > > # end of Chemical Sensors
> > > 
> > > CONFIG_IIO_CROS_EC_SENSORS_CORE=m
> > > CONFIG_IIO_CROS_EC_SENSORS=m
> > > CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE=m
> > > 
> > > #
> > > # Hid Sensor IIO Common
> > > #
> > > CONFIG_HID_SENSOR_IIO_COMMON=m
> > > CONFIG_HID_SENSOR_IIO_TRIGGER=m
> > > # end of Hid Sensor IIO Common
> > > 
> > > CONFIG_IIO_MS_SENSORS_I2C=m
> > > 
> > > #
> > > # SSP Sensor Common
> > > #
> > > CONFIG_IIO_SSP_SENSORS_COMMONS=m
> > > CONFIG_IIO_SSP_SENSORHUB=m
> > > # end of SSP Sensor Common
> > > 
> > > CONFIG_IIO_ST_SENSORS_I2C=m
> > > CONFIG_IIO_ST_SENSORS_SPI=m
> > > CONFIG_IIO_ST_SENSORS_CORE=m
> > > 
> > > #
> > > # Digital to analog converters
> > > #
> > > CONFIG_AD5064=m
> > > CONFIG_AD5360=m
> > > CONFIG_AD5380=m
> > > CONFIG_AD5421=m
> > > CONFIG_AD5446=m
> > > CONFIG_AD5449=m
> > > CONFIG_AD5592R_BASE=m
> > > CONFIG_AD5592R=m
> > > CONFIG_AD5593R=m
> > > CONFIG_AD5504=m
> > > CONFIG_AD5624R_SPI=m
> > > CONFIG_LTC1660=m
> > > CONFIG_LTC2632=m
> > > CONFIG_AD5686=m
> > > CONFIG_AD5686_SPI=m
> > > CONFIG_AD5696_I2C=m
> > > CONFIG_AD5755=m
> > > CONFIG_AD5758=m
> > > CONFIG_AD5761=m
> > > CONFIG_AD5764=m
> > > CONFIG_AD5791=m
> > > CONFIG_AD7303=m
> > > CONFIG_CIO_DAC=m
> > > CONFIG_AD8801=m
> > > CONFIG_DS4424=m
> > > CONFIG_M62332=m
> > > CONFIG_MAX517=m
> > > CONFIG_MCP4725=m
> > > CONFIG_MCP4922=m
> > > CONFIG_TI_DAC082S085=m
> > > CONFIG_TI_DAC5571=m
> > > CONFIG_TI_DAC7311=m
> > > CONFIG_TI_DAC7612=m
> > > # end of Digital to analog converters
> > > 
> > > #
> > > # IIO dummy driver
> > > #
> > > CONFIG_IIO_SIMPLE_DUMMY=m
> > > # CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
> > > # CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
> > > # end of IIO dummy driver
> > > 
> > > #
> > > # Frequency Synthesizers DDS/PLL
> > > #
> > > 
> > > #
> > > # Clock Generator/Distribution
> > > #
> > > CONFIG_AD9523=m
> > > # end of Clock Generator/Distribution
> > > 
> > > #
> > > # Phase-Locked Loop (PLL) frequency synthesizers
> > > #
> > > CONFIG_ADF4350=m
> > > CONFIG_ADF4371=m
> > > # end of Phase-Locked Loop (PLL) frequency synthesizers
> > > # end of Frequency Synthesizers DDS/PLL
> > > 
> > > #
> > > # Digital gyroscope sensors
> > > #
> > > CONFIG_ADIS16080=m
> > > CONFIG_ADIS16130=m
> > > CONFIG_ADIS16136=m
> > > CONFIG_ADIS16260=m
> > > CONFIG_ADXRS450=m
> > > CONFIG_BMG160=m
> > > CONFIG_BMG160_I2C=m
> > > CONFIG_BMG160_SPI=m
> > > CONFIG_FXAS21002C=m
> > > CONFIG_FXAS21002C_I2C=m
> > > CONFIG_FXAS21002C_SPI=m
> > > CONFIG_HID_SENSOR_GYRO_3D=m
> > > CONFIG_MPU3050=m
> > > CONFIG_MPU3050_I2C=m
> > > CONFIG_IIO_ST_GYRO_3AXIS=m
> > > CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
> > > CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
> > > CONFIG_ITG3200=m
> > > # end of Digital gyroscope sensors
> > > 
> > > #
> > > # Health Sensors
> > > #
> > > 
> > > #
> > > # Heart Rate Monitors
> > > #
> > > CONFIG_AFE4403=m
> > > CONFIG_AFE4404=m
> > > CONFIG_MAX30100=m
> > > CONFIG_MAX30102=m
> > > # end of Heart Rate Monitors
> > > # end of Health Sensors
> > > 
> > > #
> > > # Humidity sensors
> > > #
> > > CONFIG_AM2315=m
> > > CONFIG_DHT11=m
> > > CONFIG_HDC100X=m
> > > CONFIG_HID_SENSOR_HUMIDITY=m
> > > CONFIG_HTS221=m
> > > CONFIG_HTS221_I2C=m
> > > CONFIG_HTS221_SPI=m
> > > CONFIG_HTU21=m
> > > CONFIG_SI7005=m
> > > CONFIG_SI7020=m
> > > # end of Humidity sensors
> > > 
> > > #
> > > # Inertial measurement units
> > > #
> > > CONFIG_ADIS16400=m
> > > # CONFIG_ADIS16460 is not set
> > > CONFIG_ADIS16480=m
> > > CONFIG_BMI160=m
> > > CONFIG_BMI160_I2C=m
> > > CONFIG_BMI160_SPI=m
> > > # CONFIG_FXOS8700_I2C is not set
> > > # CONFIG_FXOS8700_SPI is not set
> > > CONFIG_KMX61=m
> > > CONFIG_INV_MPU6050_IIO=m
> > > CONFIG_INV_MPU6050_I2C=m
> > > CONFIG_INV_MPU6050_SPI=m
> > > CONFIG_IIO_ST_LSM6DSX=m
> > > CONFIG_IIO_ST_LSM6DSX_I2C=m
> > > CONFIG_IIO_ST_LSM6DSX_SPI=m
> > > CONFIG_IIO_ST_LSM6DSX_I3C=m
> > > # end of Inertial measurement units
> > > 
> > > CONFIG_IIO_ADIS_LIB=m
> > > CONFIG_IIO_ADIS_LIB_BUFFER=y
> > > 
> > > #
> > > # Light sensors
> > > #
> > > CONFIG_ACPI_ALS=m
> > > CONFIG_ADJD_S311=m
> > > # CONFIG_ADUX1020 is not set
> > > CONFIG_AL3320A=m
> > > CONFIG_APDS9300=m
> > > CONFIG_APDS9960=m
> > > CONFIG_BH1750=m
> > > CONFIG_BH1780=m
> > > CONFIG_CM32181=m
> > > CONFIG_CM3232=m
> > > CONFIG_CM3323=m
> > > CONFIG_CM36651=m
> > > CONFIG_IIO_CROS_EC_LIGHT_PROX=m
> > > CONFIG_GP2AP020A00F=m
> > > CONFIG_SENSORS_ISL29018=m
> > > CONFIG_SENSORS_ISL29028=m
> > > CONFIG_ISL29125=m
> > > CONFIG_HID_SENSOR_ALS=m
> > > CONFIG_HID_SENSOR_PROX=m
> > > CONFIG_JSA1212=m
> > > CONFIG_RPR0521=m
> > > CONFIG_SENSORS_LM3533=m
> > > CONFIG_LTR501=m
> > > CONFIG_LV0104CS=m
> > > CONFIG_MAX44000=m
> > > CONFIG_MAX44009=m
> > > # CONFIG_NOA1305 is not set
> > > CONFIG_OPT3001=m
> > > CONFIG_PA12203001=m
> > > CONFIG_SI1133=m
> > > CONFIG_SI1145=m
> > > CONFIG_STK3310=m
> > > CONFIG_ST_UVIS25=m
> > > CONFIG_ST_UVIS25_I2C=m
> > > CONFIG_ST_UVIS25_SPI=m
> > > CONFIG_TCS3414=m
> > > CONFIG_TCS3472=m
> > > CONFIG_SENSORS_TSL2563=m
> > > CONFIG_TSL2583=m
> > > CONFIG_TSL2772=m
> > > CONFIG_TSL4531=m
> > > CONFIG_US5182D=m
> > > CONFIG_VCNL4000=m
> > > CONFIG_VCNL4035=m
> > > # CONFIG_VEML6030 is not set
> > > CONFIG_VEML6070=m
> > > CONFIG_VL6180=m
> > > CONFIG_ZOPT2201=m
> > > # end of Light sensors
> > > 
> > > #
> > > # Magnetometer sensors
> > > #
> > > CONFIG_AK8975=m
> > > CONFIG_AK09911=m
> > > CONFIG_BMC150_MAGN=m
> > > CONFIG_BMC150_MAGN_I2C=m
> > > CONFIG_BMC150_MAGN_SPI=m
> > > CONFIG_MAG3110=m
> > > CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
> > > CONFIG_MMC35240=m
> > > CONFIG_IIO_ST_MAGN_3AXIS=m
> > > CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
> > > CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
> > > CONFIG_SENSORS_HMC5843=m
> > > CONFIG_SENSORS_HMC5843_I2C=m
> > > CONFIG_SENSORS_HMC5843_SPI=m
> > > CONFIG_SENSORS_RM3100=m
> > > CONFIG_SENSORS_RM3100_I2C=m
> > > CONFIG_SENSORS_RM3100_SPI=m
> > > # end of Magnetometer sensors
> > > 
> > > #
> > > # Multiplexers
> > > #
> > > # end of Multiplexers
> > > 
> > > #
> > > # Inclinometer sensors
> > > #
> > > CONFIG_HID_SENSOR_INCLINOMETER_3D=m
> > > CONFIG_HID_SENSOR_DEVICE_ROTATION=m
> > > # end of Inclinometer sensors
> > > 
> > > #
> > > # Triggers - standalone
> > > #
> > > CONFIG_IIO_HRTIMER_TRIGGER=m
> > > CONFIG_IIO_INTERRUPT_TRIGGER=m
> > > CONFIG_IIO_TIGHTLOOP_TRIGGER=m
> > > CONFIG_IIO_SYSFS_TRIGGER=m
> > > # end of Triggers - standalone
> > > 
> > > #
> > > # Digital potentiometers
> > > #
> > > CONFIG_AD5272=m
> > > CONFIG_DS1803=m
> > > # CONFIG_MAX5432 is not set
> > > CONFIG_MAX5481=m
> > > CONFIG_MAX5487=m
> > > CONFIG_MCP4018=m
> > > CONFIG_MCP4131=m
> > > CONFIG_MCP4531=m
> > > CONFIG_MCP41010=m
> > > CONFIG_TPL0102=m
> > > # end of Digital potentiometers
> > > 
> > > #
> > > # Digital potentiostats
> > > #
> > > CONFIG_LMP91000=m
> > > # end of Digital potentiostats
> > > 
> > > #
> > > # Pressure sensors
> > > #
> > > CONFIG_ABP060MG=m
> > > CONFIG_BMP280=m
> > > CONFIG_BMP280_I2C=m
> > > CONFIG_BMP280_SPI=m
> > > CONFIG_IIO_CROS_EC_BARO=m
> > > CONFIG_DPS310=m
> > > CONFIG_HID_SENSOR_PRESS=m
> > > CONFIG_HP03=m
> > > CONFIG_MPL115=m
> > > CONFIG_MPL115_I2C=m
> > > CONFIG_MPL115_SPI=m
> > > CONFIG_MPL3115=m
> > > CONFIG_MS5611=m
> > > CONFIG_MS5611_I2C=m
> > > CONFIG_MS5611_SPI=m
> > > CONFIG_MS5637=m
> > > CONFIG_IIO_ST_PRESS=m
> > > CONFIG_IIO_ST_PRESS_I2C=m
> > > CONFIG_IIO_ST_PRESS_SPI=m
> > > CONFIG_T5403=m
> > > CONFIG_HP206C=m
> > > CONFIG_ZPA2326=m
> > > CONFIG_ZPA2326_I2C=m
> > > CONFIG_ZPA2326_SPI=m
> > > # end of Pressure sensors
> > > 
> > > #
> > > # Lightning sensors
> > > #
> > > CONFIG_AS3935=m
> > > # end of Lightning sensors
> > > 
> > > #
> > > # Proximity and distance sensors
> > > #
> > > CONFIG_ISL29501=m
> > > CONFIG_LIDAR_LITE_V2=m
> > > CONFIG_MB1232=m
> > > CONFIG_RFD77402=m
> > > CONFIG_SRF04=m
> > > CONFIG_SX9500=m
> > > CONFIG_SRF08=m
> > > CONFIG_VL53L0X_I2C=m
> > > # end of Proximity and distance sensors
> > > 
> > > #
> > > # Resolver to digital converters
> > > #
> > > CONFIG_AD2S90=m
> > > CONFIG_AD2S1200=m
> > > # end of Resolver to digital converters
> > > 
> > > #
> > > # Temperature sensors
> > > #
> > > # CONFIG_LTC2983 is not set
> > > CONFIG_MAXIM_THERMOCOUPLE=m
> > > CONFIG_HID_SENSOR_TEMP=m
> > > CONFIG_MLX90614=m
> > > CONFIG_MLX90632=m
> > > CONFIG_TMP006=m
> > > CONFIG_TMP007=m
> > > CONFIG_TSYS01=m
> > > CONFIG_TSYS02D=m
> > > CONFIG_MAX31856=m
> > > # end of Temperature sensors
> > > 
> > > CONFIG_NTB=m
> > > CONFIG_NTB_MSI=y
> > > # CONFIG_NTB_AMD is not set
> > > CONFIG_NTB_IDT=m
> > > CONFIG_NTB_INTEL=m
> > > CONFIG_NTB_SWITCHTEC=m
> > > CONFIG_NTB_PINGPONG=m
> > > CONFIG_NTB_TOOL=m
> > > CONFIG_NTB_PERF=m
> > > # CONFIG_NTB_MSI_TEST is not set
> > > CONFIG_NTB_TRANSPORT=m
> > > CONFIG_VME_BUS=y
> > > 
> > > #
> > > # VME Bridge Drivers
> > > #
> > > CONFIG_VME_CA91CX42=m
> > > CONFIG_VME_TSI148=m
> > > CONFIG_VME_FAKE=m
> > > 
> > > #
> > > # VME Board Drivers
> > > #
> > > CONFIG_VMIVME_7805=m
> > > 
> > > #
> > > # VME Device Drivers
> > > #
> > > CONFIG_VME_USER=m
> > > CONFIG_PWM=y
> > > CONFIG_PWM_SYSFS=y
> > > CONFIG_PWM_CRC=y
> > > CONFIG_PWM_CROS_EC=m
> > > CONFIG_PWM_LP3943=m
> > > CONFIG_PWM_LPSS=y
> > > CONFIG_PWM_LPSS_PCI=y
> > > CONFIG_PWM_LPSS_PLATFORM=y
> > > CONFIG_PWM_PCA9685=m
> > > CONFIG_PWM_TWL=m
> > > CONFIG_PWM_TWL_LED=m
> > > 
> > > #
> > > # IRQ chip support
> > > #
> > > CONFIG_MADERA_IRQ=m
> > > # end of IRQ chip support
> > > 
> > > CONFIG_IPACK_BUS=m
> > > CONFIG_BOARD_TPCI200=m
> > > CONFIG_SERIAL_IPOCTAL=m
> > > CONFIG_RESET_CONTROLLER=y
> > > CONFIG_RESET_TI_SYSCON=m
> > > 
> > > #
> > > # PHY Subsystem
> > > #
> > > CONFIG_GENERIC_PHY=y
> > > CONFIG_BCM_KONA_USB2_PHY=m
> > > CONFIG_PHY_PXA_28NM_HSIC=m
> > > CONFIG_PHY_PXA_28NM_USB2=m
> > > CONFIG_PHY_CPCAP_USB=m
> > > CONFIG_PHY_QCOM_USB_HS=m
> > > CONFIG_PHY_QCOM_USB_HSIC=m
> > > CONFIG_PHY_SAMSUNG_USB2=m
> > > CONFIG_PHY_TUSB1210=m
> > > # end of PHY Subsystem
> > > 
> > > CONFIG_POWERCAP=y
> > > CONFIG_INTEL_RAPL_CORE=m
> > > CONFIG_INTEL_RAPL=m
> > > CONFIG_IDLE_INJECT=y
> > > CONFIG_MCB=m
> > > CONFIG_MCB_PCI=m
> > > CONFIG_MCB_LPC=m
> > > 
> > > #
> > > # Performance monitor support
> > > #
> > > # end of Performance monitor support
> > > 
> > > CONFIG_RAS=y
> > > CONFIG_RAS_CEC=y
> > > # CONFIG_RAS_CEC_DEBUG is not set
> > > CONFIG_THUNDERBOLT=m
> > > 
> > > #
> > > # Android
> > > #
> > > CONFIG_ANDROID=y
> > > # CONFIG_ANDROID_BINDER_IPC is not set
> > > # end of Android
> > > 
> > > CONFIG_LIBNVDIMM=y
> > > CONFIG_BLK_DEV_PMEM=m
> > > CONFIG_ND_BLK=m
> > > CONFIG_ND_CLAIM=y
> > > CONFIG_ND_BTT=m
> > > CONFIG_BTT=y
> > > CONFIG_ND_PFN=m
> > > CONFIG_NVDIMM_PFN=y
> > > CONFIG_NVDIMM_DAX=y
> > > CONFIG_NVDIMM_KEYS=y
> > > CONFIG_DAX_DRIVER=y
> > > CONFIG_DAX=y
> > > CONFIG_DEV_DAX=m
> > > CONFIG_DEV_DAX_PMEM=m
> > > CONFIG_DEV_DAX_HMEM=m
> > > CONFIG_DEV_DAX_KMEM=m
> > > CONFIG_DEV_DAX_PMEM_COMPAT=m
> > > CONFIG_NVMEM=y
> > > CONFIG_NVMEM_SYSFS=y
> > > CONFIG_RAVE_SP_EEPROM=m
> > > 
> > > #
> > > # HW tracing support
> > > #
> > > CONFIG_STM=m
> > > CONFIG_STM_PROTO_BASIC=m
> > > CONFIG_STM_PROTO_SYS_T=m
> > > CONFIG_STM_DUMMY=m
> > > CONFIG_STM_SOURCE_CONSOLE=m
> > > CONFIG_STM_SOURCE_HEARTBEAT=m
> > > CONFIG_STM_SOURCE_FTRACE=m
> > > CONFIG_INTEL_TH=m
> > > CONFIG_INTEL_TH_PCI=m
> > > CONFIG_INTEL_TH_ACPI=m
> > > CONFIG_INTEL_TH_GTH=m
> > > CONFIG_INTEL_TH_STH=m
> > > CONFIG_INTEL_TH_MSU=m
> > > CONFIG_INTEL_TH_PTI=m
> > > # CONFIG_INTEL_TH_DEBUG is not set
> > > # end of HW tracing support
> > > 
> > > CONFIG_FPGA=m
> > > CONFIG_ALTERA_PR_IP_CORE=m
> > > CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
> > > CONFIG_FPGA_MGR_ALTERA_CVP=m
> > > CONFIG_FPGA_MGR_XILINX_SPI=m
> > > CONFIG_FPGA_MGR_MACHXO2_SPI=m
> > > CONFIG_FPGA_BRIDGE=m
> > > CONFIG_ALTERA_FREEZE_BRIDGE=m
> > > CONFIG_XILINX_PR_DECOUPLER=m
> > > CONFIG_FPGA_REGION=m
> > > CONFIG_FPGA_DFL=m
> > > CONFIG_FPGA_DFL_FME=m
> > > CONFIG_FPGA_DFL_FME_MGR=m
> > > CONFIG_FPGA_DFL_FME_BRIDGE=m
> > > CONFIG_FPGA_DFL_FME_REGION=m
> > > CONFIG_FPGA_DFL_AFU=m
> > > CONFIG_FPGA_DFL_PCI=m
> > > CONFIG_PM_OPP=y
> > > CONFIG_UNISYS_VISORBUS=m
> > > CONFIG_SIOX=m
> > > CONFIG_SIOX_BUS_GPIO=m
> > > CONFIG_SLIMBUS=m
> > > CONFIG_SLIM_QCOM_CTRL=m
> > > CONFIG_INTERCONNECT=m
> > > CONFIG_COUNTER=m
> > > CONFIG_104_QUAD_8=m
> > > # end of Device Drivers
> > > 
> > > #
> > > # File systems
> > > #
> > > CONFIG_DCACHE_WORD_ACCESS=y
> > > CONFIG_VALIDATE_FS_PARSER=y
> > > CONFIG_FS_IOMAP=y
> > > # CONFIG_EXT2_FS is not set
> > > # CONFIG_EXT3_FS is not set
> > > CONFIG_EXT4_FS=y
> > > CONFIG_EXT4_USE_FOR_EXT2=y
> > > CONFIG_EXT4_FS_POSIX_ACL=y
> > > CONFIG_EXT4_FS_SECURITY=y
> > > # CONFIG_EXT4_DEBUG is not set
> > > CONFIG_JBD2=y
> > > # CONFIG_JBD2_DEBUG is not set
> > > CONFIG_FS_MBCACHE=y
> > > CONFIG_REISERFS_FS=m
> > > # CONFIG_REISERFS_CHECK is not set
> > > # CONFIG_REISERFS_PROC_INFO is not set
> > > CONFIG_REISERFS_FS_XATTR=y
> > > CONFIG_REISERFS_FS_POSIX_ACL=y
> > > CONFIG_REISERFS_FS_SECURITY=y
> > > CONFIG_JFS_FS=m
> > > CONFIG_JFS_POSIX_ACL=y
> > > CONFIG_JFS_SECURITY=y
> > > # CONFIG_JFS_DEBUG is not set
> > > CONFIG_JFS_STATISTICS=y
> > > CONFIG_XFS_FS=m
> > > CONFIG_XFS_QUOTA=y
> > > CONFIG_XFS_POSIX_ACL=y
> > > CONFIG_XFS_RT=y
> > > # CONFIG_XFS_ONLINE_SCRUB is not set
> > > # CONFIG_XFS_WARN is not set
> > > # CONFIG_XFS_DEBUG is not set
> > > CONFIG_GFS2_FS=m
> > > CONFIG_GFS2_FS_LOCKING_DLM=y
> > > CONFIG_OCFS2_FS=m
> > > CONFIG_OCFS2_FS_O2CB=m
> > > CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
> > > CONFIG_OCFS2_FS_STATS=y
> > > CONFIG_OCFS2_DEBUG_MASKLOG=y
> > > # CONFIG_OCFS2_DEBUG_FS is not set
> > > CONFIG_BTRFS_FS=m
> > > CONFIG_BTRFS_FS_POSIX_ACL=y
> > > # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> > > # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> > > # CONFIG_BTRFS_DEBUG is not set
> > > # CONFIG_BTRFS_ASSERT is not set
> > > # CONFIG_BTRFS_FS_REF_VERIFY is not set
> > > CONFIG_NILFS2_FS=m
> > > CONFIG_F2FS_FS=m
> > > CONFIG_F2FS_STAT_FS=y
> > > CONFIG_F2FS_FS_XATTR=y
> > > CONFIG_F2FS_FS_POSIX_ACL=y
> > > CONFIG_F2FS_FS_SECURITY=y
> > > # CONFIG_F2FS_CHECK_FS is not set
> > > # CONFIG_F2FS_IO_TRACE is not set
> > > # CONFIG_F2FS_FAULT_INJECTION is not set
> > > CONFIG_FS_DAX=y
> > > CONFIG_FS_DAX_PMD=y
> > > CONFIG_FS_POSIX_ACL=y
> > > CONFIG_EXPORTFS=y
> > > CONFIG_EXPORTFS_BLOCK_OPS=y
> > > CONFIG_FILE_LOCKING=y
> > > CONFIG_MANDATORY_FILE_LOCKING=y
> > > CONFIG_FS_ENCRYPTION=y
> > > # CONFIG_FS_VERITY is not set
> > > CONFIG_FSNOTIFY=y
> > > CONFIG_DNOTIFY=y
> > > CONFIG_INOTIFY_USER=y
> > > CONFIG_FANOTIFY=y
> > > CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
> > > CONFIG_QUOTA=y
> > > CONFIG_QUOTA_NETLINK_INTERFACE=y
> > > # CONFIG_PRINT_QUOTA_WARNING is not set
> > > # CONFIG_QUOTA_DEBUG is not set
> > > CONFIG_QUOTA_TREE=m
> > > CONFIG_QFMT_V1=m
> > > CONFIG_QFMT_V2=m
> > > CONFIG_QUOTACTL=y
> > > CONFIG_QUOTACTL_COMPAT=y
> > > CONFIG_AUTOFS4_FS=m
> > > CONFIG_AUTOFS_FS=m
> > > CONFIG_FUSE_FS=y
> > > CONFIG_CUSE=m
> > > # CONFIG_VIRTIO_FS is not set
> > > CONFIG_OVERLAY_FS=m
> > > # CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
> > > CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
> > > # CONFIG_OVERLAY_FS_INDEX is not set
> > > CONFIG_OVERLAY_FS_XINO_AUTO=y
> > > # CONFIG_OVERLAY_FS_METACOPY is not set
> > > 
> > > #
> > > # Caches
> > > #
> > > CONFIG_FSCACHE=m
> > > CONFIG_FSCACHE_STATS=y
> > > # CONFIG_FSCACHE_HISTOGRAM is not set
> > > # CONFIG_FSCACHE_DEBUG is not set
> > > # CONFIG_FSCACHE_OBJECT_LIST is not set
> > > CONFIG_CACHEFILES=m
> > > # CONFIG_CACHEFILES_DEBUG is not set
> > > # CONFIG_CACHEFILES_HISTOGRAM is not set
> > > # end of Caches
> > > 
> > > #
> > > # CD-ROM/DVD Filesystems
> > > #
> > > CONFIG_ISO9660_FS=m
> > > CONFIG_JOLIET=y
> > > CONFIG_ZISOFS=y
> > > CONFIG_UDF_FS=m
> > > # end of CD-ROM/DVD Filesystems
> > > 
> > > #
> > > # DOS/FAT/NT Filesystems
> > > #
> > > CONFIG_FAT_FS=y
> > > CONFIG_MSDOS_FS=m
> > > CONFIG_VFAT_FS=y
> > > CONFIG_FAT_DEFAULT_CODEPAGE=437
> > > CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> > > # CONFIG_FAT_DEFAULT_UTF8 is not set
> > > CONFIG_NTFS_FS=m
> > > # CONFIG_NTFS_DEBUG is not set
> > > # CONFIG_NTFS_RW is not set
> > > # end of DOS/FAT/NT Filesystems
> > > 
> > > #
> > > # Pseudo filesystems
> > > #
> > > CONFIG_PROC_FS=y
> > > CONFIG_PROC_KCORE=y
> > > CONFIG_PROC_VMCORE=y
> > > CONFIG_PROC_VMCORE_DEVICE_DUMP=y
> > > CONFIG_PROC_SYSCTL=y
> > > CONFIG_PROC_PAGE_MONITOR=y
> > > CONFIG_PROC_CHILDREN=y
> > > CONFIG_PROC_PID_ARCH_STATUS=y
> > > CONFIG_KERNFS=y
> > > CONFIG_SYSFS=y
> > > CONFIG_TMPFS=y
> > > CONFIG_TMPFS_POSIX_ACL=y
> > > CONFIG_TMPFS_XATTR=y
> > > CONFIG_HUGETLBFS=y
> > > CONFIG_HUGETLB_PAGE=y
> > > CONFIG_MEMFD_CREATE=y
> > > CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
> > > CONFIG_CONFIGFS_FS=y
> > > CONFIG_EFIVAR_FS=y
> > > # end of Pseudo filesystems
> > > 
> > > CONFIG_MISC_FILESYSTEMS=y
> > > CONFIG_ORANGEFS_FS=m
> > > CONFIG_ADFS_FS=m
> > > # CONFIG_ADFS_FS_RW is not set
> > > CONFIG_AFFS_FS=m
> > > CONFIG_ECRYPT_FS=y
> > > CONFIG_ECRYPT_FS_MESSAGING=y
> > > CONFIG_HFS_FS=m
> > > CONFIG_HFSPLUS_FS=m
> > > CONFIG_BEFS_FS=m
> > > # CONFIG_BEFS_DEBUG is not set
> > > CONFIG_BFS_FS=m
> > > CONFIG_EFS_FS=m
> > > CONFIG_JFFS2_FS=m
> > > CONFIG_JFFS2_FS_DEBUG=0
> > > CONFIG_JFFS2_FS_WRITEBUFFER=y
> > > # CONFIG_JFFS2_FS_WBUF_VERIFY is not set
> > > # CONFIG_JFFS2_SUMMARY is not set
> > > CONFIG_JFFS2_FS_XATTR=y
> > > CONFIG_JFFS2_FS_POSIX_ACL=y
> > > CONFIG_JFFS2_FS_SECURITY=y
> > > CONFIG_JFFS2_COMPRESSION_OPTIONS=y
> > > CONFIG_JFFS2_ZLIB=y
> > > CONFIG_JFFS2_LZO=y
> > > CONFIG_JFFS2_RTIME=y
> > > # CONFIG_JFFS2_RUBIN is not set
> > > # CONFIG_JFFS2_CMODE_NONE is not set
> > > # CONFIG_JFFS2_CMODE_PRIORITY is not set
> > > # CONFIG_JFFS2_CMODE_SIZE is not set
> > > CONFIG_JFFS2_CMODE_FAVOURLZO=y
> > > CONFIG_UBIFS_FS=m
> > > # CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
> > > CONFIG_UBIFS_FS_LZO=y
> > > CONFIG_UBIFS_FS_ZLIB=y
> > > CONFIG_UBIFS_FS_ZSTD=y
> > > # CONFIG_UBIFS_ATIME_SUPPORT is not set
> > > CONFIG_UBIFS_FS_XATTR=y
> > > CONFIG_UBIFS_FS_SECURITY=y
> > > CONFIG_UBIFS_FS_AUTHENTICATION=y
> > > CONFIG_CRAMFS=m
> > > CONFIG_CRAMFS_BLOCKDEV=y
> > > CONFIG_CRAMFS_MTD=y
> > > CONFIG_SQUASHFS=y
> > > # CONFIG_SQUASHFS_FILE_CACHE is not set
> > > CONFIG_SQUASHFS_FILE_DIRECT=y
> > > CONFIG_SQUASHFS_DECOMP_SINGLE=y
> > > # CONFIG_SQUASHFS_DECOMP_MULTI is not set
> > > # CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
> > > CONFIG_SQUASHFS_XATTR=y
> > > CONFIG_SQUASHFS_ZLIB=y
> > > CONFIG_SQUASHFS_LZ4=y
> > > CONFIG_SQUASHFS_LZO=y
> > > CONFIG_SQUASHFS_XZ=y
> > > CONFIG_SQUASHFS_ZSTD=y
> > > # CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
> > > # CONFIG_SQUASHFS_EMBEDDED is not set
> > > CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
> > > CONFIG_VXFS_FS=m
> > > CONFIG_MINIX_FS=m
> > > CONFIG_OMFS_FS=m
> > > CONFIG_HPFS_FS=m
> > > CONFIG_QNX4FS_FS=m
> > > CONFIG_QNX6FS_FS=m
> > > # CONFIG_QNX6FS_DEBUG is not set
> > > CONFIG_ROMFS_FS=m
> > > CONFIG_ROMFS_BACKED_BY_BLOCK=y
> > > # CONFIG_ROMFS_BACKED_BY_MTD is not set
> > > # CONFIG_ROMFS_BACKED_BY_BOTH is not set
> > > CONFIG_ROMFS_ON_BLOCK=y
> > > CONFIG_PSTORE=y
> > > CONFIG_PSTORE_DEFLATE_COMPRESS=y
> > > # CONFIG_PSTORE_LZO_COMPRESS is not set
> > > # CONFIG_PSTORE_LZ4_COMPRESS is not set
> > > # CONFIG_PSTORE_LZ4HC_COMPRESS is not set
> > > # CONFIG_PSTORE_842_COMPRESS is not set
> > > # CONFIG_PSTORE_ZSTD_COMPRESS is not set
> > > CONFIG_PSTORE_COMPRESS=y
> > > CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
> > > CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
> > > # CONFIG_PSTORE_CONSOLE is not set
> > > # CONFIG_PSTORE_PMSG is not set
> > > # CONFIG_PSTORE_FTRACE is not set
> > > CONFIG_PSTORE_RAM=m
> > > CONFIG_SYSV_FS=m
> > > CONFIG_UFS_FS=m
> > > # CONFIG_UFS_FS_WRITE is not set
> > > # CONFIG_UFS_DEBUG is not set
> > > CONFIG_EROFS_FS=m
> > > # CONFIG_EROFS_FS_DEBUG is not set
> > > CONFIG_EROFS_FS_XATTR=y
> > > CONFIG_EROFS_FS_POSIX_ACL=y
> > > CONFIG_EROFS_FS_SECURITY=y
> > > # CONFIG_EROFS_FS_ZIP is not set
> > > CONFIG_NETWORK_FILESYSTEMS=y
> > > CONFIG_NFS_FS=m
> > > CONFIG_NFS_V2=m
> > > CONFIG_NFS_V3=m
> > > CONFIG_NFS_V3_ACL=y
> > > CONFIG_NFS_V4=m
> > > CONFIG_NFS_SWAP=y
> > > CONFIG_NFS_V4_1=y
> > > CONFIG_NFS_V4_2=y
> > > CONFIG_PNFS_FILE_LAYOUT=m
> > > CONFIG_PNFS_BLOCK=m
> > > CONFIG_PNFS_FLEXFILE_LAYOUT=m
> > > CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
> > > CONFIG_NFS_V4_1_MIGRATION=y
> > > CONFIG_NFS_V4_SECURITY_LABEL=y
> > > CONFIG_NFS_FSCACHE=y
> > > # CONFIG_NFS_USE_LEGACY_DNS is not set
> > > CONFIG_NFS_USE_KERNEL_DNS=y
> > > CONFIG_NFS_DEBUG=y
> > > CONFIG_NFSD=m
> > > CONFIG_NFSD_V2_ACL=y
> > > CONFIG_NFSD_V3=y
> > > CONFIG_NFSD_V3_ACL=y
> > > CONFIG_NFSD_V4=y
> > > CONFIG_NFSD_PNFS=y
> > > CONFIG_NFSD_BLOCKLAYOUT=y
> > > CONFIG_NFSD_SCSILAYOUT=y
> > > CONFIG_NFSD_FLEXFILELAYOUT=y
> > > CONFIG_NFSD_V4_SECURITY_LABEL=y
> > > CONFIG_GRACE_PERIOD=m
> > > CONFIG_LOCKD=m
> > > CONFIG_LOCKD_V4=y
> > > CONFIG_NFS_ACL_SUPPORT=m
> > > CONFIG_NFS_COMMON=y
> > > CONFIG_SUNRPC=m
> > > CONFIG_SUNRPC_GSS=m
> > > CONFIG_SUNRPC_BACKCHANNEL=y
> > > CONFIG_SUNRPC_SWAP=y
> > > CONFIG_RPCSEC_GSS_KRB5=m
> > > # CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
> > > CONFIG_SUNRPC_DEBUG=y
> > > CONFIG_SUNRPC_XPRT_RDMA=m
> > > CONFIG_CEPH_FS=m
> > > CONFIG_CEPH_FSCACHE=y
> > > CONFIG_CEPH_FS_POSIX_ACL=y
> > > CONFIG_CEPH_FS_SECURITY_LABEL=y
> > > CONFIG_CIFS=m
> > > # CONFIG_CIFS_STATS2 is not set
> > > CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
> > > CONFIG_CIFS_WEAK_PW_HASH=y
> > > CONFIG_CIFS_UPCALL=y
> > > CONFIG_CIFS_XATTR=y
> > > CONFIG_CIFS_POSIX=y
> > > CONFIG_CIFS_DEBUG=y
> > > # CONFIG_CIFS_DEBUG2 is not set
> > > # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> > > CONFIG_CIFS_DFS_UPCALL=y
> > > # CONFIG_CIFS_SMB_DIRECT is not set
> > > CONFIG_CIFS_FSCACHE=y
> > > CONFIG_CODA_FS=m
> > > CONFIG_AFS_FS=m
> > > # CONFIG_AFS_DEBUG is not set
> > > CONFIG_AFS_FSCACHE=y
> > > # CONFIG_AFS_DEBUG_CURSOR is not set
> > > CONFIG_9P_FS=m
> > > CONFIG_9P_FSCACHE=y
> > > CONFIG_9P_FS_POSIX_ACL=y
> > > CONFIG_9P_FS_SECURITY=y
> > > CONFIG_NLS=y
> > > CONFIG_NLS_DEFAULT="utf8"
> > > CONFIG_NLS_CODEPAGE_437=y
> > > CONFIG_NLS_CODEPAGE_737=m
> > > CONFIG_NLS_CODEPAGE_775=m
> > > CONFIG_NLS_CODEPAGE_850=m
> > > CONFIG_NLS_CODEPAGE_852=m
> > > CONFIG_NLS_CODEPAGE_855=m
> > > CONFIG_NLS_CODEPAGE_857=m
> > > CONFIG_NLS_CODEPAGE_860=m
> > > CONFIG_NLS_CODEPAGE_861=m
> > > CONFIG_NLS_CODEPAGE_862=m
> > > CONFIG_NLS_CODEPAGE_863=m
> > > CONFIG_NLS_CODEPAGE_864=m
> > > CONFIG_NLS_CODEPAGE_865=m
> > > CONFIG_NLS_CODEPAGE_866=m
> > > CONFIG_NLS_CODEPAGE_869=m
> > > CONFIG_NLS_CODEPAGE_936=m
> > > CONFIG_NLS_CODEPAGE_950=m
> > > CONFIG_NLS_CODEPAGE_932=m
> > > CONFIG_NLS_CODEPAGE_949=m
> > > CONFIG_NLS_CODEPAGE_874=m
> > > CONFIG_NLS_ISO8859_8=m
> > > CONFIG_NLS_CODEPAGE_1250=m
> > > CONFIG_NLS_CODEPAGE_1251=m
> > > CONFIG_NLS_ASCII=m
> > > CONFIG_NLS_ISO8859_1=m
> > > CONFIG_NLS_ISO8859_2=m
> > > CONFIG_NLS_ISO8859_3=m
> > > CONFIG_NLS_ISO8859_4=m
> > > CONFIG_NLS_ISO8859_5=m
> > > CONFIG_NLS_ISO8859_6=m
> > > CONFIG_NLS_ISO8859_7=m
> > > CONFIG_NLS_ISO8859_9=m
> > > CONFIG_NLS_ISO8859_13=m
> > > CONFIG_NLS_ISO8859_14=m
> > > CONFIG_NLS_ISO8859_15=m
> > > CONFIG_NLS_KOI8_R=m
> > > CONFIG_NLS_KOI8_U=m
> > > CONFIG_NLS_MAC_ROMAN=m
> > > CONFIG_NLS_MAC_CELTIC=m
> > > CONFIG_NLS_MAC_CENTEURO=m
> > > CONFIG_NLS_MAC_CROATIAN=m
> > > CONFIG_NLS_MAC_CYRILLIC=m
> > > CONFIG_NLS_MAC_GAELIC=m
> > > CONFIG_NLS_MAC_GREEK=m
> > > CONFIG_NLS_MAC_ICELAND=m
> > > CONFIG_NLS_MAC_INUIT=m
> > > CONFIG_NLS_MAC_ROMANIAN=m
> > > CONFIG_NLS_MAC_TURKISH=m
> > > CONFIG_NLS_UTF8=m
> > > CONFIG_DLM=m
> > > # CONFIG_DLM_DEBUG is not set
> > > CONFIG_UNICODE=y
> > > # CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
> > > CONFIG_IO_WQ=y
> > > # end of File systems
> > > 
> > > #
> > > # Security options
> > > #
> > > CONFIG_KEYS=y
> > > CONFIG_KEYS_COMPAT=y
> > > CONFIG_KEYS_REQUEST_CACHE=y
> > > CONFIG_PERSISTENT_KEYRINGS=y
> > > CONFIG_BIG_KEYS=y
> > > CONFIG_TRUSTED_KEYS=y
> > > CONFIG_ENCRYPTED_KEYS=y
> > > CONFIG_KEY_DH_OPERATIONS=y
> > > # CONFIG_SECURITY_DMESG_RESTRICT is not set
> > > CONFIG_SECURITY=y
> > > CONFIG_SECURITYFS=y
> > > CONFIG_SECURITY_NETWORK=y
> > > CONFIG_PAGE_TABLE_ISOLATION=y
> > > CONFIG_SECURITY_INFINIBAND=y
> > > CONFIG_SECURITY_NETWORK_XFRM=y
> > > CONFIG_SECURITY_PATH=y
> > > CONFIG_INTEL_TXT=y
> > > CONFIG_LSM_MMAP_MIN_ADDR=0
> > > CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> > > CONFIG_HARDENED_USERCOPY=y
> > > CONFIG_HARDENED_USERCOPY_FALLBACK=y
> > > # CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
> > > CONFIG_FORTIFY_SOURCE=y
> > > # CONFIG_STATIC_USERMODEHELPER is not set
> > > CONFIG_SECURITY_SELINUX=y
> > > CONFIG_SECURITY_SELINUX_BOOTPARAM=y
> > > # CONFIG_SECURITY_SELINUX_DISABLE is not set
> > > CONFIG_SECURITY_SELINUX_DEVELOP=y
> > > CONFIG_SECURITY_SELINUX_AVC_STATS=y
> > > CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
> > > CONFIG_SECURITY_SMACK=y
> > > # CONFIG_SECURITY_SMACK_BRINGUP is not set
> > > CONFIG_SECURITY_SMACK_NETFILTER=y
> > > CONFIG_SECURITY_SMACK_APPEND_SIGNALS=y
> > > CONFIG_SECURITY_TOMOYO=y
> > > CONFIG_SECURITY_TOMOYO_MAX_ACCEPT_ENTRY=2048
> > > CONFIG_SECURITY_TOMOYO_MAX_AUDIT_LOG=1024
> > > # CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER is not set
> > > CONFIG_SECURITY_TOMOYO_POLICY_LOADER="/sbin/tomoyo-init"
> > > CONFIG_SECURITY_TOMOYO_ACTIVATION_TRIGGER="/sbin/init"
> > > # CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING is not set
> > > CONFIG_SECURITY_APPARMOR=y
> > > CONFIG_SECURITY_APPARMOR_HASH=y
> > > CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
> > > # CONFIG_SECURITY_APPARMOR_DEBUG is not set
> > > # CONFIG_SECURITY_LOADPIN is not set
> > > CONFIG_SECURITY_YAMA=y
> > > CONFIG_SECURITY_SAFESETID=y
> > > # CONFIG_SECURITY_LOCKDOWN_LSM is not set
> > > CONFIG_INTEGRITY=y
> > > CONFIG_INTEGRITY_SIGNATURE=y
> > > CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
> > > CONFIG_INTEGRITY_TRUSTED_KEYRING=y
> > > CONFIG_INTEGRITY_PLATFORM_KEYRING=y
> > > CONFIG_LOAD_UEFI_KEYS=y
> > > CONFIG_INTEGRITY_AUDIT=y
> > > CONFIG_IMA=y
> > > CONFIG_IMA_MEASURE_PCR_IDX=10
> > > CONFIG_IMA_LSM_RULES=y
> > > # CONFIG_IMA_TEMPLATE is not set
> > > CONFIG_IMA_NG_TEMPLATE=y
> > > # CONFIG_IMA_SIG_TEMPLATE is not set
> > > CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
> > > CONFIG_IMA_DEFAULT_HASH_SHA1=y
> > > # CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
> > > # CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
> > > CONFIG_IMA_DEFAULT_HASH="sha1"
> > > # CONFIG_IMA_WRITE_POLICY is not set
> > > # CONFIG_IMA_READ_POLICY is not set
> > > CONFIG_IMA_APPRAISE=y
> > > # CONFIG_IMA_ARCH_POLICY is not set
> > > # CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
> > > CONFIG_IMA_APPRAISE_BOOTPARAM=y
> > > # CONFIG_IMA_APPRAISE_MODSIG is not set
> > > CONFIG_IMA_TRUSTED_KEYRING=y
> > > # CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not set
> > > # CONFIG_IMA_BLACKLIST_KEYRING is not set
> > > # CONFIG_IMA_LOAD_X509 is not set
> > > CONFIG_EVM=y
> > > CONFIG_EVM_ATTR_FSUUID=y
> > > CONFIG_EVM_EXTRA_SMACK_XATTRS=y
> > > CONFIG_EVM_ADD_XATTRS=y
> > > # CONFIG_EVM_LOAD_X509 is not set
> > > # CONFIG_DEFAULT_SECURITY_SELINUX is not set
> > > # CONFIG_DEFAULT_SECURITY_SMACK is not set
> > > # CONFIG_DEFAULT_SECURITY_TOMOYO is not set
> > > CONFIG_DEFAULT_SECURITY_APPARMOR=y
> > > # CONFIG_DEFAULT_SECURITY_DAC is not set
> > > CONFIG_LSM="yama,integrity,apparmor"
> > > 
> > > #
> > > # Kernel hardening options
> > > #
> > > 
> > > #
> > > # Memory initialization
> > > #
> > > CONFIG_INIT_STACK_NONE=y
> > > CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
> > > # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> > > # end of Memory initialization
> > > # end of Kernel hardening options
> > > # end of Security options
> > > 
> > > CONFIG_XOR_BLOCKS=m
> > > CONFIG_ASYNC_CORE=m
> > > CONFIG_ASYNC_MEMCPY=m
> > > CONFIG_ASYNC_XOR=m
> > > CONFIG_ASYNC_PQ=m
> > > CONFIG_ASYNC_RAID6_RECOV=m
> > > CONFIG_CRYPTO=y
> > > 
> > > #
> > > # Crypto core or helper
> > > #
> > > CONFIG_CRYPTO_ALGAPI=y
> > > CONFIG_CRYPTO_ALGAPI2=y
> > > CONFIG_CRYPTO_AEAD=y
> > > CONFIG_CRYPTO_AEAD2=y
> > > CONFIG_CRYPTO_SKCIPHER=y
> > > CONFIG_CRYPTO_SKCIPHER2=y
> > > CONFIG_CRYPTO_HASH=y
> > > CONFIG_CRYPTO_HASH2=y
> > > CONFIG_CRYPTO_RNG=y
> > > CONFIG_CRYPTO_RNG2=y
> > > CONFIG_CRYPTO_RNG_DEFAULT=y
> > > CONFIG_CRYPTO_AKCIPHER2=y
> > > CONFIG_CRYPTO_AKCIPHER=y
> > > CONFIG_CRYPTO_KPP2=y
> > > CONFIG_CRYPTO_KPP=y
> > > CONFIG_CRYPTO_ACOMP2=y
> > > CONFIG_CRYPTO_MANAGER=y
> > > CONFIG_CRYPTO_MANAGER2=y
> > > CONFIG_CRYPTO_USER=m
> > > CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> > > CONFIG_CRYPTO_GF128MUL=y
> > > CONFIG_CRYPTO_NULL=y
> > > CONFIG_CRYPTO_NULL2=y
> > > CONFIG_CRYPTO_PCRYPT=m
> > > CONFIG_CRYPTO_CRYPTD=m
> > > CONFIG_CRYPTO_AUTHENC=m
> > > CONFIG_CRYPTO_TEST=m
> > > CONFIG_CRYPTO_SIMD=m
> > > CONFIG_CRYPTO_GLUE_HELPER_X86=m
> > > CONFIG_CRYPTO_ENGINE=m
> > > 
> > > #
> > > # Public-key cryptography
> > > #
> > > CONFIG_CRYPTO_RSA=y
> > > CONFIG_CRYPTO_DH=y
> > > CONFIG_CRYPTO_ECC=m
> > > CONFIG_CRYPTO_ECDH=m
> > > CONFIG_CRYPTO_ECRDSA=m
> > > # CONFIG_CRYPTO_CURVE25519 is not set
> > > # CONFIG_CRYPTO_CURVE25519_X86 is not set
> > > 
> > > #
> > > # Authenticated Encryption with Associated Data
> > > #
> > > CONFIG_CRYPTO_CCM=m
> > > CONFIG_CRYPTO_GCM=y
> > > CONFIG_CRYPTO_CHACHA20POLY1305=m
> > > CONFIG_CRYPTO_AEGIS128=m
> > > CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=m
> > > CONFIG_CRYPTO_SEQIV=y
> > > CONFIG_CRYPTO_ECHAINIV=m
> > > 
> > > #
> > > # Block modes
> > > #
> > > CONFIG_CRYPTO_CBC=y
> > > CONFIG_CRYPTO_CFB=m
> > > CONFIG_CRYPTO_CTR=y
> > > CONFIG_CRYPTO_CTS=y
> > > CONFIG_CRYPTO_ECB=y
> > > CONFIG_CRYPTO_LRW=m
> > > CONFIG_CRYPTO_OFB=m
> > > CONFIG_CRYPTO_PCBC=m
> > > CONFIG_CRYPTO_XTS=y
> > > CONFIG_CRYPTO_KEYWRAP=m
> > > CONFIG_CRYPTO_NHPOLY1305=m
> > > CONFIG_CRYPTO_NHPOLY1305_SSE2=m
> > > CONFIG_CRYPTO_NHPOLY1305_AVX2=m
> > > CONFIG_CRYPTO_ADIANTUM=m
> > > CONFIG_CRYPTO_ESSIV=m
> > > 
> > > #
> > > # Hash modes
> > > #
> > > CONFIG_CRYPTO_CMAC=m
> > > CONFIG_CRYPTO_HMAC=y
> > > CONFIG_CRYPTO_XCBC=m
> > > CONFIG_CRYPTO_VMAC=m
> > > 
> > > #
> > > # Digest
> > > #
> > > CONFIG_CRYPTO_CRC32C=y
> > > CONFIG_CRYPTO_CRC32C_INTEL=y
> > > CONFIG_CRYPTO_CRC32=m
> > > CONFIG_CRYPTO_CRC32_PCLMUL=m
> > > CONFIG_CRYPTO_XXHASH=m
> > > # CONFIG_CRYPTO_BLAKE2B is not set
> > > # CONFIG_CRYPTO_BLAKE2S is not set
> > > # CONFIG_CRYPTO_BLAKE2S_X86 is not set
> > > CONFIG_CRYPTO_CRCT10DIF=y
> > > CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
> > > CONFIG_CRYPTO_GHASH=y
> > > CONFIG_CRYPTO_POLY1305=m
> > > CONFIG_CRYPTO_POLY1305_X86_64=m
> > > CONFIG_CRYPTO_MD4=m
> > > CONFIG_CRYPTO_MD5=y
> > > CONFIG_CRYPTO_MICHAEL_MIC=m
> > > CONFIG_CRYPTO_RMD128=m
> > > CONFIG_CRYPTO_RMD160=m
> > > CONFIG_CRYPTO_RMD256=m
> > > CONFIG_CRYPTO_RMD320=m
> > > CONFIG_CRYPTO_SHA1=y
> > > CONFIG_CRYPTO_SHA1_SSSE3=m
> > > CONFIG_CRYPTO_SHA256_SSSE3=m
> > > CONFIG_CRYPTO_SHA512_SSSE3=m
> > > CONFIG_CRYPTO_SHA256=y
> > > CONFIG_CRYPTO_SHA512=y
> > > CONFIG_CRYPTO_SHA3=m
> > > CONFIG_CRYPTO_SM3=m
> > > CONFIG_CRYPTO_STREEBOG=m
> > > CONFIG_CRYPTO_TGR192=m
> > > CONFIG_CRYPTO_WP512=m
> > > CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
> > > 
> > > #
> > > # Ciphers
> > > #
> > > CONFIG_CRYPTO_AES=y
> > > CONFIG_CRYPTO_AES_TI=m
> > > CONFIG_CRYPTO_AES_NI_INTEL=m
> > > CONFIG_CRYPTO_ANUBIS=m
> > > CONFIG_CRYPTO_ARC4=m
> > > CONFIG_CRYPTO_BLOWFISH=m
> > > CONFIG_CRYPTO_BLOWFISH_COMMON=m
> > > CONFIG_CRYPTO_BLOWFISH_X86_64=m
> > > CONFIG_CRYPTO_CAMELLIA=m
> > > CONFIG_CRYPTO_CAMELLIA_X86_64=m
> > > CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
> > > CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
> > > CONFIG_CRYPTO_CAST_COMMON=m
> > > CONFIG_CRYPTO_CAST5=m
> > > CONFIG_CRYPTO_CAST5_AVX_X86_64=m
> > > CONFIG_CRYPTO_CAST6=m
> > > CONFIG_CRYPTO_CAST6_AVX_X86_64=m
> > > CONFIG_CRYPTO_DES=m
> > > CONFIG_CRYPTO_DES3_EDE_X86_64=m
> > > CONFIG_CRYPTO_FCRYPT=m
> > > CONFIG_CRYPTO_KHAZAD=m
> > > CONFIG_CRYPTO_SALSA20=m
> > > CONFIG_CRYPTO_CHACHA20=m
> > > CONFIG_CRYPTO_CHACHA20_X86_64=m
> > > CONFIG_CRYPTO_SEED=m
> > > CONFIG_CRYPTO_SERPENT=m
> > > CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
> > > CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
> > > CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
> > > CONFIG_CRYPTO_SM4=m
> > > CONFIG_CRYPTO_TEA=m
> > > CONFIG_CRYPTO_TWOFISH=m
> > > CONFIG_CRYPTO_TWOFISH_COMMON=m
> > > CONFIG_CRYPTO_TWOFISH_X86_64=m
> > > CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
> > > CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
> > > 
> > > #
> > > # Compression
> > > #
> > > CONFIG_CRYPTO_DEFLATE=y
> > > CONFIG_CRYPTO_LZO=y
> > > CONFIG_CRYPTO_842=m
> > > CONFIG_CRYPTO_LZ4=m
> > > CONFIG_CRYPTO_LZ4HC=m
> > > CONFIG_CRYPTO_ZSTD=m
> > > 
> > > #
> > > # Random Number Generation
> > > #
> > > CONFIG_CRYPTO_ANSI_CPRNG=m
> > > CONFIG_CRYPTO_DRBG_MENU=y
> > > CONFIG_CRYPTO_DRBG_HMAC=y
> > > CONFIG_CRYPTO_DRBG_HASH=y
> > > CONFIG_CRYPTO_DRBG_CTR=y
> > > CONFIG_CRYPTO_DRBG=y
> > > CONFIG_CRYPTO_JITTERENTROPY=y
> > > CONFIG_CRYPTO_USER_API=m
> > > CONFIG_CRYPTO_USER_API_HASH=m
> > > CONFIG_CRYPTO_USER_API_SKCIPHER=m
> > > CONFIG_CRYPTO_USER_API_RNG=m
> > > CONFIG_CRYPTO_USER_API_AEAD=m
> > > CONFIG_CRYPTO_STATS=y
> > > CONFIG_CRYPTO_HASH_INFO=y
> > > 
> > > #
> > > # Crypto library routines
> > > #
> > > CONFIG_CRYPTO_LIB_AES=y
> > > CONFIG_CRYPTO_LIB_ARC4=m
> > > # CONFIG_CRYPTO_LIB_BLAKE2S is not set
> > > CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
> > > CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
> > > # CONFIG_CRYPTO_LIB_CHACHA is not set
> > > # CONFIG_CRYPTO_LIB_CURVE25519 is not set
> > > CONFIG_CRYPTO_LIB_DES=m
> > > CONFIG_CRYPTO_LIB_POLY1305_RSIZE=4
> > > CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
> > > CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
> > > # CONFIG_CRYPTO_LIB_POLY1305 is not set
> > > # CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
> > > CONFIG_CRYPTO_LIB_SHA256=y
> > > CONFIG_CRYPTO_HW=y
> > > CONFIG_CRYPTO_DEV_PADLOCK=y
> > > CONFIG_CRYPTO_DEV_PADLOCK_AES=m
> > > CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
> > > CONFIG_CRYPTO_DEV_ATMEL_I2C=m
> > > CONFIG_CRYPTO_DEV_ATMEL_ECC=m
> > > CONFIG_CRYPTO_DEV_ATMEL_SHA204A=m
> > > CONFIG_CRYPTO_DEV_CCP=y
> > > CONFIG_CRYPTO_DEV_CCP_DD=m
> > > CONFIG_CRYPTO_DEV_SP_CCP=y
> > > CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
> > > CONFIG_CRYPTO_DEV_SP_PSP=y
> > > # CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
> > > CONFIG_CRYPTO_DEV_QAT=m
> > > CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
> > > # CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
> > > # CONFIG_CRYPTO_DEV_QAT_C62X is not set
> > > CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
> > > # CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
> > > # CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
> > > CONFIG_CRYPTO_DEV_NITROX=m
> > > CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
> > > CONFIG_CRYPTO_DEV_CHELSIO=m
> > > CONFIG_CHELSIO_IPSEC_INLINE=y
> > > CONFIG_CRYPTO_DEV_VIRTIO=m
> > > # CONFIG_CRYPTO_DEV_SAFEXCEL is not set
> > > # CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
> > > CONFIG_ASYMMETRIC_KEY_TYPE=y
> > > CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> > > CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE=m
> > > CONFIG_X509_CERTIFICATE_PARSER=y
> > > CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
> > > CONFIG_TPM_KEY_PARSER=m
> > > CONFIG_PKCS7_MESSAGE_PARSER=y
> > > CONFIG_PKCS7_TEST_KEY=m
> > > CONFIG_SIGNED_PE_FILE_VERIFICATION=y
> > > 
> > > #
> > > # Certificates for signature checking
> > > #
> > > CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
> > > CONFIG_SYSTEM_TRUSTED_KEYRING=y
> > > CONFIG_SYSTEM_TRUSTED_KEYS=""
> > > CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
> > > CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
> > > CONFIG_SECONDARY_TRUSTED_KEYRING=y
> > > CONFIG_SYSTEM_BLACKLIST_KEYRING=y
> > > CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
> > > # end of Certificates for signature checking
> > > 
> > > CONFIG_BINARY_PRINTF=y
> > > 
> > > #
> > > # Library routines
> > > #
> > > CONFIG_RAID6_PQ=m
> > > CONFIG_RAID6_PQ_BENCHMARK=y
> > > CONFIG_PACKING=y
> > > CONFIG_BITREVERSE=y
> > > CONFIG_GENERIC_STRNCPY_FROM_USER=y
> > > CONFIG_GENERIC_STRNLEN_USER=y
> > > CONFIG_GENERIC_NET_UTILS=y
> > > CONFIG_GENERIC_FIND_FIRST_BIT=y
> > > CONFIG_CORDIC=m
> > > CONFIG_RATIONAL=y
> > > CONFIG_GENERIC_PCI_IOMAP=y
> > > CONFIG_GENERIC_IOMAP=y
> > > CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
> > > CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> > > CONFIG_CRC_CCITT=y
> > > CONFIG_CRC16=y
> > > CONFIG_CRC_T10DIF=y
> > > CONFIG_CRC_ITU_T=m
> > > CONFIG_CRC32=y
> > > # CONFIG_CRC32_SELFTEST is not set
> > > CONFIG_CRC32_SLICEBY8=y
> > > # CONFIG_CRC32_SLICEBY4 is not set
> > > # CONFIG_CRC32_SARWATE is not set
> > > # CONFIG_CRC32_BIT is not set
> > > CONFIG_CRC64=m
> > > CONFIG_CRC4=m
> > > CONFIG_CRC7=m
> > > CONFIG_LIBCRC32C=m
> > > CONFIG_CRC8=m
> > > CONFIG_XXHASH=y
> > > # CONFIG_RANDOM32_SELFTEST is not set
> > > CONFIG_842_COMPRESS=m
> > > CONFIG_842_DECOMPRESS=m
> > > CONFIG_ZLIB_INFLATE=y
> > > CONFIG_ZLIB_DEFLATE=y
> > > CONFIG_LZO_COMPRESS=y
> > > CONFIG_LZO_DECOMPRESS=y
> > > CONFIG_LZ4_COMPRESS=m
> > > CONFIG_LZ4HC_COMPRESS=m
> > > CONFIG_LZ4_DECOMPRESS=y
> > > CONFIG_ZSTD_COMPRESS=m
> > > CONFIG_ZSTD_DECOMPRESS=y
> > > CONFIG_XZ_DEC=y
> > > CONFIG_XZ_DEC_X86=y
> > > CONFIG_XZ_DEC_POWERPC=y
> > > CONFIG_XZ_DEC_IA64=y
> > > CONFIG_XZ_DEC_ARM=y
> > > CONFIG_XZ_DEC_ARMTHUMB=y
> > > CONFIG_XZ_DEC_SPARC=y
> > > CONFIG_XZ_DEC_BCJ=y
> > > CONFIG_XZ_DEC_TEST=m
> > > CONFIG_DECOMPRESS_GZIP=y
> > > CONFIG_DECOMPRESS_BZIP2=y
> > > CONFIG_DECOMPRESS_LZMA=y
> > > CONFIG_DECOMPRESS_XZ=y
> > > CONFIG_DECOMPRESS_LZO=y
> > > CONFIG_DECOMPRESS_LZ4=y
> > > CONFIG_GENERIC_ALLOCATOR=y
> > > CONFIG_REED_SOLOMON=m
> > > CONFIG_REED_SOLOMON_ENC8=y
> > > CONFIG_REED_SOLOMON_DEC8=y
> > > CONFIG_REED_SOLOMON_DEC16=y
> > > CONFIG_BCH=m
> > > CONFIG_TEXTSEARCH=y
> > > CONFIG_TEXTSEARCH_KMP=m
> > > CONFIG_TEXTSEARCH_BM=m
> > > CONFIG_TEXTSEARCH_FSM=m
> > > CONFIG_BTREE=y
> > > CONFIG_INTERVAL_TREE=y
> > > CONFIG_XARRAY_MULTI=y
> > > CONFIG_ASSOCIATIVE_ARRAY=y
> > > CONFIG_HAS_IOMEM=y
> > > CONFIG_HAS_IOPORT_MAP=y
> > > CONFIG_HAS_DMA=y
> > > CONFIG_NEED_SG_DMA_LENGTH=y
> > > CONFIG_NEED_DMA_MAP_STATE=y
> > > CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> > > CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
> > > CONFIG_DMA_VIRT_OPS=y
> > > CONFIG_SWIOTLB=y
> > > # CONFIG_DMA_CMA is not set
> > > # CONFIG_DMA_API_DEBUG is not set
> > > CONFIG_SGL_ALLOC=y
> > > CONFIG_IOMMU_HELPER=y
> > > CONFIG_CHECK_SIGNATURE=y
> > > CONFIG_CPUMASK_OFFSTACK=y
> > > CONFIG_CPU_RMAP=y
> > > CONFIG_DQL=y
> > > CONFIG_GLOB=y
> > > # CONFIG_GLOB_SELFTEST is not set
> > > CONFIG_NLATTR=y
> > > CONFIG_LRU_CACHE=m
> > > CONFIG_CLZ_TAB=y
> > > CONFIG_IRQ_POLL=y
> > > CONFIG_MPILIB=y
> > > CONFIG_SIGNATURE=y
> > > CONFIG_DIMLIB=y
> > > CONFIG_OID_REGISTRY=y
> > > CONFIG_UCS2_STRING=y
> > > CONFIG_HAVE_GENERIC_VDSO=y
> > > CONFIG_GENERIC_GETTIMEOFDAY=y
> > > CONFIG_FONT_SUPPORT=y
> > > CONFIG_FONTS=y
> > > CONFIG_FONT_8x8=y
> > > CONFIG_FONT_8x16=y
> > > # CONFIG_FONT_6x11 is not set
> > > # CONFIG_FONT_7x14 is not set
> > > # CONFIG_FONT_PEARL_8x8 is not set
> > > CONFIG_FONT_ACORN_8x8=y
> > > # CONFIG_FONT_MINI_4x6 is not set
> > > CONFIG_FONT_6x10=y
> > > # CONFIG_FONT_10x18 is not set
> > > # CONFIG_FONT_SUN8x16 is not set
> > > # CONFIG_FONT_SUN12x22 is not set
> > > CONFIG_FONT_TER16x32=y
> > > CONFIG_SG_POOL=y
> > > CONFIG_ARCH_HAS_PMEM_API=y
> > > CONFIG_MEMREGION=y
> > > CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
> > > CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
> > > CONFIG_ARCH_STACKWALK=y
> > > CONFIG_SBITMAP=y
> > > CONFIG_PARMAN=m
> > > CONFIG_OBJAGG=m
> > > # CONFIG_STRING_SELFTEST is not set
> > > # end of Library routines
> > > 
> > > #
> > > # Kernel hacking
> > > #
> > > 
> > > #
> > > # printk and dmesg options
> > > #
> > > CONFIG_PRINTK_TIME=y
> > > # CONFIG_PRINTK_CALLER is not set
> > > CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> > > CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> > > CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> > > CONFIG_BOOT_PRINTK_DELAY=y
> > > CONFIG_DYNAMIC_DEBUG=y
> > > CONFIG_SYMBOLIC_ERRNAME=y
> > > # end of printk and dmesg options
> > > 
> > > #
> > > # Compile-time checks and compiler options
> > > #
> > > CONFIG_DEBUG_INFO=y
> > > # CONFIG_DEBUG_INFO_REDUCED is not set
> > > # CONFIG_DEBUG_INFO_SPLIT is not set
> > > CONFIG_DEBUG_INFO_DWARF4=y
> > > # CONFIG_DEBUG_INFO_BTF is not set
> > > CONFIG_GDB_SCRIPTS=y
> > > # CONFIG_ENABLE_MUST_CHECK is not set
> > > CONFIG_FRAME_WARN=1024
> > > # CONFIG_STRIP_ASM_SYMS is not set
> > > # CONFIG_READABLE_ASM is not set
> > > CONFIG_DEBUG_FS=y
> > > # CONFIG_HEADERS_INSTALL is not set
> > > CONFIG_OPTIMIZE_INLINING=y
> > > # CONFIG_DEBUG_SECTION_MISMATCH is not set
> > > CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> > > CONFIG_FRAME_POINTER=y
> > > CONFIG_STACK_VALIDATION=y
> > > # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> > > # end of Compile-time checks and compiler options
> > > 
> > > CONFIG_MAGIC_SYSRQ=y
> > > CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x01b6
> > > CONFIG_MAGIC_SYSRQ_SERIAL=y
> > > CONFIG_DEBUG_KERNEL=y
> > > CONFIG_DEBUG_MISC=y
> > > 
> > > #
> > > # Memory Debugging
> > > #
> > > # CONFIG_PAGE_EXTENSION is not set
> > > # CONFIG_DEBUG_PAGEALLOC is not set
> > > # CONFIG_PAGE_OWNER is not set
> > > CONFIG_PAGE_POISONING=y
> > > CONFIG_PAGE_POISONING_NO_SANITY=y
> > > CONFIG_PAGE_POISONING_ZERO=y
> > > # CONFIG_DEBUG_PAGE_REF is not set
> > > # CONFIG_DEBUG_RODATA_TEST is not set
> > > # CONFIG_DEBUG_OBJECTS is not set
> > > # CONFIG_SLUB_DEBUG_ON is not set
> > > # CONFIG_SLUB_STATS is not set
> > > CONFIG_HAVE_DEBUG_KMEMLEAK=y
> > > # CONFIG_DEBUG_KMEMLEAK is not set
> > > # CONFIG_DEBUG_STACK_USAGE is not set
> > > # CONFIG_DEBUG_VM is not set
> > > CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> > > # CONFIG_DEBUG_VIRTUAL is not set
> > > # CONFIG_DEBUG_MEMORY_INIT is not set
> > > CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
> > > # CONFIG_DEBUG_PER_CPU_MAPS is not set
> > > CONFIG_HAVE_ARCH_KASAN=y
> > > CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> > > CONFIG_CC_HAS_KASAN_GENERIC=y
> > > # CONFIG_KASAN is not set
> > > CONFIG_KASAN_STACK=1
> > > # end of Memory Debugging
> > > 
> > > CONFIG_ARCH_HAS_KCOV=y
> > > CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> > > # CONFIG_KCOV is not set
> > > # CONFIG_DEBUG_SHIRQ is not set
> > > 
> > > #
> > > # Debug Lockups and Hangs
> > > #
> > > CONFIG_LOCKUP_DETECTOR=y
> > > CONFIG_SOFTLOCKUP_DETECTOR=y
> > > # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> > > CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
> > > CONFIG_HARDLOCKUP_DETECTOR_PERF=y
> > > CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
> > > CONFIG_HARDLOCKUP_DETECTOR=y
> > > # CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
> > > CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
> > > CONFIG_DETECT_HUNG_TASK=y
> > > CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
> > > # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> > > CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
> > > # CONFIG_WQ_WATCHDOG is not set
> > > # end of Debug Lockups and Hangs
> > > 
> > > # CONFIG_PANIC_ON_OOPS is not set
> > > CONFIG_PANIC_ON_OOPS_VALUE=0
> > > CONFIG_PANIC_TIMEOUT=0
> > > CONFIG_SCHED_DEBUG=y
> > > CONFIG_SCHED_INFO=y
> > > CONFIG_SCHEDSTATS=y
> > > CONFIG_SCHED_STACK_END_CHECK=y
> > > # CONFIG_DEBUG_TIMEKEEPING is not set
> > > 
> > > #
> > > # Lock Debugging (spinlocks, mutexes, etc...)
> > > #
> > > CONFIG_LOCK_DEBUGGING_SUPPORT=y
> > > # CONFIG_PROVE_LOCKING is not set
> > > # CONFIG_LOCK_STAT is not set
> > > # CONFIG_DEBUG_RT_MUTEXES is not set
> > > # CONFIG_DEBUG_SPINLOCK is not set
> > > # CONFIG_DEBUG_MUTEXES is not set
> > > # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> > > # CONFIG_DEBUG_RWSEMS is not set
> > > # CONFIG_DEBUG_LOCK_ALLOC is not set
> > > # CONFIG_DEBUG_ATOMIC_SLEEP is not set
> > > # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> > > # CONFIG_LOCK_TORTURE_TEST is not set
> > > # CONFIG_WW_MUTEX_SELFTEST is not set
> > > # end of Lock Debugging (spinlocks, mutexes, etc...)
> > > 
> > > CONFIG_STACKTRACE=y
> > > # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> > > # CONFIG_DEBUG_KOBJECT is not set
> > > CONFIG_DEBUG_BUGVERBOSE=y
> > > # CONFIG_DEBUG_LIST is not set
> > > # CONFIG_DEBUG_PLIST is not set
> > > # CONFIG_DEBUG_SG is not set
> > > # CONFIG_DEBUG_NOTIFIERS is not set
> > > # CONFIG_DEBUG_CREDENTIALS is not set
> > > 
> > > #
> > > # RCU Debugging
> > > #
> > > CONFIG_TORTURE_TEST=m
> > > CONFIG_RCU_PERF_TEST=m
> > > # CONFIG_RCU_TORTURE_TEST is not set
> > > CONFIG_RCU_CPU_STALL_TIMEOUT=60
> > > # CONFIG_RCU_TRACE is not set
> > > # CONFIG_RCU_EQS_DEBUG is not set
> > > # end of RCU Debugging
> > > 
> > > # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> > > # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> > > # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> > > CONFIG_NOTIFIER_ERROR_INJECTION=m
> > > CONFIG_PM_NOTIFIER_ERROR_INJECT=m
> > > # CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
> > > CONFIG_FUNCTION_ERROR_INJECTION=y
> > > # CONFIG_FAULT_INJECTION is not set
> > > # CONFIG_LATENCYTOP is not set
> > > CONFIG_USER_STACKTRACE_SUPPORT=y
> > > CONFIG_NOP_TRACER=y
> > > CONFIG_HAVE_FUNCTION_TRACER=y
> > > CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> > > CONFIG_HAVE_DYNAMIC_FTRACE=y
> > > CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> > > CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> > > CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> > > CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> > > CONFIG_HAVE_FENTRY=y
> > > CONFIG_HAVE_C_RECORDMCOUNT=y
> > > CONFIG_TRACER_MAX_TRACE=y
> > > CONFIG_TRACE_CLOCK=y
> > > CONFIG_RING_BUFFER=y
> > > CONFIG_EVENT_TRACING=y
> > > CONFIG_CONTEXT_SWITCH_TRACER=y
> > > CONFIG_RING_BUFFER_ALLOW_SWAP=y
> > > CONFIG_TRACING=y
> > > CONFIG_GENERIC_TRACER=y
> > > CONFIG_TRACING_SUPPORT=y
> > > CONFIG_FTRACE=y
> > > CONFIG_FUNCTION_TRACER=y
> > > CONFIG_FUNCTION_GRAPH_TRACER=y
> > > # CONFIG_PREEMPTIRQ_EVENTS is not set
> > > # CONFIG_IRQSOFF_TRACER is not set
> > > CONFIG_SCHED_TRACER=y
> > > CONFIG_HWLAT_TRACER=y
> > > CONFIG_FTRACE_SYSCALLS=y
> > > CONFIG_TRACER_SNAPSHOT=y
> > > # CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
> > > CONFIG_BRANCH_PROFILE_NONE=y
> > > # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> > > CONFIG_STACK_TRACER=y
> > > CONFIG_BLK_DEV_IO_TRACE=y
> > > CONFIG_KPROBE_EVENTS=y
> > > # CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
> > > CONFIG_UPROBE_EVENTS=y
> > > CONFIG_BPF_EVENTS=y
> > > CONFIG_DYNAMIC_EVENTS=y
> > > CONFIG_PROBE_EVENTS=y
> > > CONFIG_DYNAMIC_FTRACE=y
> > > CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
> > > CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> > > CONFIG_FUNCTION_PROFILER=y
> > > CONFIG_BPF_KPROBE_OVERRIDE=y
> > > CONFIG_FTRACE_MCOUNT_RECORD=y
> > > # CONFIG_FTRACE_STARTUP_TEST is not set
> > > CONFIG_MMIOTRACE=y
> > > CONFIG_TRACING_MAP=y
> > > CONFIG_HIST_TRIGGERS=y
> > > # CONFIG_TRACE_EVENT_INJECT is not set
> > > # CONFIG_MMIOTRACE_TEST is not set
> > > # CONFIG_TRACEPOINT_BENCHMARK is not set
> > > # CONFIG_RING_BUFFER_BENCHMARK is not set
> > > # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> > > # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> > > # CONFIG_TRACE_EVAL_MAP_FILE is not set
> > > # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> > > # CONFIG_KUNIT is not set
> > > CONFIG_RUNTIME_TESTING_MENU=y
> > > # CONFIG_LKDTM is not set
> > > # CONFIG_TEST_LIST_SORT is not set
> > > # CONFIG_TEST_SORT is not set
> > > # CONFIG_KPROBES_SANITY_TEST is not set
> > > # CONFIG_BACKTRACE_SELF_TEST is not set
> > > # CONFIG_RBTREE_TEST is not set
> > > # CONFIG_REED_SOLOMON_TEST is not set
> > > # CONFIG_INTERVAL_TREE_TEST is not set
> > > # CONFIG_PERCPU_TEST is not set
> > > # CONFIG_ATOMIC64_SELFTEST is not set
> > > # CONFIG_ASYNC_RAID6_TEST is not set
> > > # CONFIG_TEST_HEXDUMP is not set
> > > # CONFIG_TEST_STRING_HELPERS is not set
> > > # CONFIG_TEST_STRSCPY is not set
> > > # CONFIG_TEST_KSTRTOX is not set
> > > # CONFIG_TEST_PRINTF is not set
> > > # CONFIG_TEST_BITMAP is not set
> > > # CONFIG_TEST_BITFIELD is not set
> > > # CONFIG_TEST_UUID is not set
> > > # CONFIG_TEST_XARRAY is not set
> > > # CONFIG_TEST_OVERFLOW is not set
> > > # CONFIG_TEST_RHASHTABLE is not set
> > > # CONFIG_TEST_HASH is not set
> > > # CONFIG_TEST_IDA is not set
> > > # CONFIG_TEST_PARMAN is not set
> > > # CONFIG_TEST_LKM is not set
> > > # CONFIG_TEST_VMALLOC is not set
> > > # CONFIG_TEST_USER_COPY is not set
> > > CONFIG_TEST_BPF=m
> > > CONFIG_TEST_BLACKHOLE_DEV=m
> > > # CONFIG_FIND_BIT_BENCHMARK is not set
> > > # CONFIG_TEST_FIRMWARE is not set
> > > # CONFIG_TEST_SYSCTL is not set
> > > # CONFIG_TEST_UDELAY is not set
> > > # CONFIG_TEST_STATIC_KEYS is not set
> > > # CONFIG_TEST_KMOD is not set
> > > # CONFIG_TEST_MEMCAT_P is not set
> > > # CONFIG_TEST_LIVEPATCH is not set
> > > # CONFIG_TEST_OBJAGG is not set
> > > # CONFIG_TEST_STACKINIT is not set
> > > # CONFIG_TEST_MEMINIT is not set
> > > CONFIG_MEMTEST=y
> > > # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> > > CONFIG_SAMPLES=y
> > > # CONFIG_SAMPLE_TRACE_EVENTS is not set
> > > CONFIG_SAMPLE_TRACE_PRINTK=m
> > > # CONFIG_SAMPLE_FTRACE_DIRECT is not set
> > > # CONFIG_SAMPLE_TRACE_ARRAY is not set
> > > # CONFIG_SAMPLE_KOBJECT is not set
> > > # CONFIG_SAMPLE_KPROBES is not set
> > > # CONFIG_SAMPLE_HW_BREAKPOINT is not set
> > > # CONFIG_SAMPLE_KFIFO is not set
> > > # CONFIG_SAMPLE_KDB is not set
> > > # CONFIG_SAMPLE_RPMSG_CLIENT is not set
> > > # CONFIG_SAMPLE_LIVEPATCH is not set
> > > # CONFIG_SAMPLE_CONFIGFS is not set
> > > # CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
> > > # CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
> > > # CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
> > > # CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
> > > # CONFIG_SAMPLE_INTEL_MEI is not set
> > > CONFIG_HAVE_ARCH_KGDB=y
> > > CONFIG_KGDB=y
> > > CONFIG_KGDB_SERIAL_CONSOLE=y
> > > # CONFIG_KGDB_TESTS is not set
> > > CONFIG_KGDB_LOW_LEVEL_TRAP=y
> > > CONFIG_KGDB_KDB=y
> > > CONFIG_KDB_DEFAULT_ENABLE=0x1
> > > CONFIG_KDB_KEYBOARD=y
> > > CONFIG_KDB_CONTINUE_CATASTROPHIC=0
> > > CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> > > # CONFIG_UBSAN is not set
> > > CONFIG_UBSAN_ALIGNMENT=y
> > > CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> > > CONFIG_STRICT_DEVMEM=y
> > > # CONFIG_IO_STRICT_DEVMEM is not set
> > > CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> > > CONFIG_EARLY_PRINTK_USB=y
> > > # CONFIG_X86_VERBOSE_BOOTUP is not set
> > > CONFIG_EARLY_PRINTK=y
> > > CONFIG_EARLY_PRINTK_DBGP=y
> > > CONFIG_EARLY_PRINTK_USB_XDBC=y
> > > CONFIG_X86_PTDUMP_CORE=y
> > > # CONFIG_X86_PTDUMP is not set
> > > # CONFIG_EFI_PGT_DUMP is not set
> > > CONFIG_DEBUG_WX=y
> > > CONFIG_DOUBLEFAULT=y
> > > # CONFIG_DEBUG_TLBFLUSH is not set
> > > # CONFIG_IOMMU_DEBUG is not set
> > > CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> > > # CONFIG_X86_DECODER_SELFTEST is not set
> > > # CONFIG_IO_DELAY_0X80 is not set
> > > CONFIG_IO_DELAY_0XED=y
> > > # CONFIG_IO_DELAY_UDELAY is not set
> > > # CONFIG_IO_DELAY_NONE is not set
> > > # CONFIG_DEBUG_BOOT_PARAMS is not set
> > > # CONFIG_CPA_DEBUG is not set
> > > # CONFIG_DEBUG_ENTRY is not set
> > > # CONFIG_DEBUG_NMI_SELFTEST is not set
> > > CONFIG_X86_DEBUG_FPU=y
> > > CONFIG_PUNIT_ATOM_DEBUG=m
> > > # CONFIG_UNWINDER_ORC is not set
> > > CONFIG_UNWINDER_FRAME_POINTER=y
> > > # CONFIG_UNWINDER_GUESS is not set
> > > # CONFIG_HYPERV_TESTING is not set
> > > # end of Kernel hacking
> > > [    0.000000] microcode: microcode updated early to revision 0xca, date = 2019-10-03
> > > [    0.000000] Linux version 5.4.0-s76+ (chirvasitua@system76-pc) (gcc version 7.4.0 (Ubuntu 7.4.0-1ubuntu1~18.04.1)) #1 SMP Thu Dec 5 13:32:08 EST 2019
> > > [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.4.0-s76+ root=UUID=64b7f2ae-fb0a-481d-8aaf-ed44d4d73bb5 ro quiet splash psmouse.synaptics_intertouch=1 vt.handoff=1
> > > [    0.000000] KERNEL supported cpus:
> > > [    0.000000]   Intel GenuineIntel
> > > [    0.000000]   AMD AuthenticAMD
> > > [    0.000000]   Hygon HygonGenuine
> > > [    0.000000]   Centaur CentaurHauls
> > > [    0.000000]   zhaoxin   Shanghai  
> > > [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> > > [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> > > [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> > > [    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
> > > [    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
> > > [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> > > [    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
> > > [    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
> > > [    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
> > > [    0.000000] BIOS-provided physical RAM map:
> > > [    0.000000] BIOS-e820: [mem 0x0000000000001000-0x000000000009ffff] usable
> > > [    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
> > > [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000996adfff] usable
> > > [    0.000000] BIOS-e820: [mem 0x00000000996ae000-0x000000009972dfff] type 20
> > > [    0.000000] BIOS-e820: [mem 0x000000009972e000-0x00000000997f1fff] reserved
> > > [    0.000000] BIOS-e820: [mem 0x00000000997f2000-0x00000000997fcfff] usable
> > > [    0.000000] BIOS-e820: [mem 0x00000000997fd000-0x00000000997fdfff] ACPI data
> > > [    0.000000] BIOS-e820: [mem 0x00000000997fe000-0x0000000099b5dfff] usable
> > > [    0.000000] BIOS-e820: [mem 0x0000000099b5e000-0x000000009f7fffff] reserved
> > > [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000085e7fffff] usable
> > > [    0.000000] NX (Execute Disable) protection: active
> > > [    0.000000] efi: EFI v2.70 by EDK II
> > > [    0.000000] efi:  ACPI 2.0=0x99b60000  SMBIOS=0x99b5e000 
> > > [    0.000000] SMBIOS 2.8 present.
> > > [    0.000000] DMI: System76 Galago Pro/Galago Pro, BIOS 2019-10-31_cca6ad0 10/30/2019
> > > [    0.000000] tsc: Detected 2300.000 MHz processor
> > > [    0.000013] tsc: Detected 2299.968 MHz TSC
> > > [    0.000014] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> > > [    0.000016] e820: remove [mem 0x000a0000-0x000fffff] usable
> > > [    0.000021] last_pfn = 0x85e800 max_arch_pfn = 0x400000000
> > > [    0.000026] MTRR default type: write-back
> > > [    0.000027] MTRR fixed ranges enabled:
> > > [    0.000028]   00000-9FFFF write-back
> > > [    0.000029]   A0000-BFFFF uncachable
> > > [    0.000030]   C0000-FFFFF write-back
> > > [    0.000031] MTRR variable ranges enabled:
> > > [    0.000033]   0 base 009B000000 mask 7FFF000000 uncachable
> > > [    0.000034]   1 base 009C000000 mask 7FFC000000 uncachable
> > > [    0.000036]   2 base 00A0000000 mask 7FF0000000 uncachable
> > > [    0.000037]   3 base 00B0000000 mask 7FF0000000 write-combining
> > > [    0.000038]   4 base 00C0000000 mask 7FC0000000 uncachable
> > > [    0.000038]   5 disabled
> > > [    0.000039]   6 disabled
> > > [    0.000040]   7 disabled
> > > [    0.000040]   8 disabled
> > > [    0.000041]   9 disabled
> > > [    0.000697] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> > > [    0.000957] last_pfn = 0x99b5e max_arch_pfn = 0x400000000
> > > [    0.012745] check: Scanning 1 areas for low memory corruption
> > > [    0.012752] Using GB pages for direct mapping
> > > [    0.012754] BRK [0x7c1201000, 0x7c1201fff] PGTABLE
> > > [    0.012756] BRK [0x7c1202000, 0x7c1202fff] PGTABLE
> > > [    0.012757] BRK [0x7c1203000, 0x7c1203fff] PGTABLE
> > > [    0.012804] BRK [0x7c1204000, 0x7c1204fff] PGTABLE
> > > [    0.012806] BRK [0x7c1205000, 0x7c1205fff] PGTABLE
> > > [    0.013015] BRK [0x7c1206000, 0x7c1206fff] PGTABLE
> > > [    0.013063] BRK [0x7c1207000, 0x7c1207fff] PGTABLE
> > > [    0.013258] BRK [0x7c1208000, 0x7c1208fff] PGTABLE
> > > [    0.013345] Secure boot could not be determined
> > > [    0.013346] RAMDISK: [mem 0x332d9000-0x35963fff]
> > > [    0.013360] ACPI: Early table checksum verification disabled
> > > [    0.013363] ACPI: RSDP 0x0000000099B60000 000024 (v02 COREv4)
> > > [    0.013368] ACPI: XSDT 0x00000000997FDF18 000064 (v01 COREv4 COREBOOT 00000000 CORE 20190215)
> > > [    0.013374] ACPI: FACP 0x0000000099B63520 0000F4 (v04 COREv4 COREBOOT 00000000 CORE 20190215)
> > > [    0.013381] ACPI: DSDT 0x0000000099B60280 00329B (v02 COREv4 COREBOOT 20110725 INTL 20190215)
> > > [    0.013385] ACPI: FACS 0x0000000099B60240 000040
> > > [    0.013388] ACPI: FACS 0x0000000099B60240 000040
> > > [    0.013390] ACPI: SSDT 0x0000000099B63620 001271 (v02 COREv4 COREBOOT 0000002A CORE 20190215)
> > > [    0.013394] ACPI: MCFG 0x0000000099B648A0 00003C (v01 COREv4 COREBOOT 00000000 CORE 20190215)
> > > [    0.013398] ACPI: APIC 0x0000000099B648E0 00008C (v02 COREv4 COREBOOT 00000000 CORE 20190215)
> > > [    0.013401] ACPI: DMAR 0x0000000099B64970 000088 (v01 COREv4 COREBOOT 00000000 CORE 20190215)
> > > [    0.013404] ACPI: DBG2 0x0000000099B66A00 000061 (v00 COREv4 COREBOOT 00000000 CORE 20190215)
> > > [    0.013408] ACPI: HPET 0x0000000099B66A70 000038 (v01 COREv4 COREBOOT 00000000 CORE 20190215)
> > > [    0.013411] ACPI: BGRT 0x00000000997FD018 000038 (v00 INTEL      EDK2 00001720 PTL  00000002)
> > > [    0.013420] ACPI: Local APIC address 0xfee00000
> > > [    0.013855] No NUMA configuration found
> > > [    0.013856] Faking a node at [mem 0x0000000000000000-0x000000085e7fffff]
> > > [    0.013870] NODE_DATA(0) allocated [mem 0x85e7d5000-0x85e7fffff]
> > > [    0.014225] Zone ranges:
> > > [    0.014226]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> > > [    0.014228]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> > > [    0.014229]   Normal   [mem 0x0000000100000000-0x000000085e7fffff]
> > > [    0.014230]   Device   empty
> > > [    0.014231] Movable zone start for each node
> > > [    0.014236] Early memory node ranges
> > > [    0.014237]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
> > > [    0.014238]   node   0: [mem 0x0000000000100000-0x00000000996adfff]
> > > [    0.014239]   node   0: [mem 0x00000000997f2000-0x00000000997fcfff]
> > > [    0.014240]   node   0: [mem 0x00000000997fe000-0x0000000099b5dfff]
> > > [    0.014241]   node   0: [mem 0x0000000100000000-0x000000085e7fffff]
> > > [    0.014535] Zeroed struct page in unavailable ranges: 26184 pages
> > > [    0.014537] Initmem setup node 0 [mem 0x0000000000001000-0x000000085e7fffff]
> > > [    0.014538] On node 0 totalpages: 8356280
> > > [    0.014540]   DMA zone: 64 pages used for memmap
> > > [    0.014541]   DMA zone: 1064 pages reserved
> > > [    0.014542]   DMA zone: 3999 pages, LIFO batch:0
> > > [    0.014625]   DMA32 zone: 9769 pages used for memmap
> > > [    0.014626]   DMA32 zone: 625177 pages, LIFO batch:63
> > > [    0.031023]   Normal zone: 120736 pages used for memmap
> > > [    0.031024]   Normal zone: 7727104 pages, LIFO batch:63
> > > [    0.187151] Reserving Intel graphics memory at [mem 0x9b800000-0x9f7fffff]
> > > [    0.187629] ACPI: PM-Timer IO Port: 0x1808
> > > [    0.187631] ACPI: Local APIC address 0xfee00000
> > > [    0.187684] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
> > > [    0.187687] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> > > [    0.187688] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> > > [    0.187690] ACPI: IRQ0 used by override.
> > > [    0.187691] ACPI: IRQ9 used by override.
> > > [    0.187694] Using ACPI (MADT) for SMP configuration information
> > > [    0.187695] ACPI: HPET id: 0x8086a701 base: 0xfed00000
> > > [    0.187706] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
> > > [    0.187721] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> > > [    0.187723] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
> > > [    0.187725] PM: Registered nosave memory: [mem 0x996ae000-0x9972dfff]
> > > [    0.187726] PM: Registered nosave memory: [mem 0x9972e000-0x997f1fff]
> > > [    0.187727] PM: Registered nosave memory: [mem 0x997fd000-0x997fdfff]
> > > [    0.187729] PM: Registered nosave memory: [mem 0x99b5e000-0x9f7fffff]
> > > [    0.187730] PM: Registered nosave memory: [mem 0x9f800000-0xffffffff]
> > > [    0.187732] [mem 0x9f800000-0xffffffff] available for PCI devices
> > > [    0.187733] Booting paravirtualized kernel on bare hardware
> > > [    0.187737] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> > > [    0.187744] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
> > > [    0.188005] percpu: Embedded 56 pages/cpu s192512 r8192 d28672 u262144
> > > [    0.188013] pcpu-alloc: s192512 r8192 d28672 u262144 alloc=1*2097152
> > > [    0.188014] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
> > > [    0.188047] Built 1 zonelists, mobility grouping on.  Total pages: 8224647
> > > [    0.188048] Policy zone: Normal
> > > [    0.188050] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.4.0-s76+ root=UUID=64b7f2ae-fb0a-481d-8aaf-ed44d4d73bb5 ro quiet splash psmouse.synaptics_intertouch=1 vt.handoff=1
> > > [    0.190520] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
> > > [    0.191685] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
> > > [    0.191789] mem auto-init: stack:off, heap alloc:on, heap free:off
> > > [    0.287322] Memory: 32683288K/33425120K available (14339K kernel code, 2382K rwdata, 4812K rodata, 2628K init, 5096K bss, 741832K reserved, 0K cma-reserved)
> > > [    0.287485] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
> > > [    0.287500] ftrace: allocating 43820 entries in 172 pages
> > > [    0.313002] ftrace: allocated 172 pages with 4 groups
> > > [    0.313139] rcu: Hierarchical RCU implementation.
> > > [    0.313140] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
> > > [    0.313141] 	Tasks RCU enabled.
> > > [    0.313142] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> > > [    0.313143] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
> > > [    0.317119] NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16
> > > [    0.317619] random: crng done (trusting CPU's manufacturer)
> > > [    0.317655] Console: colour dummy device 80x25
> > > [    0.317659] printk: console [tty0] enabled
> > > [    0.317677] ACPI: Core revision 20191018
> > > [    0.317926] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
> > > [    0.318079] APIC: Switch to symmetric I/O mode setup
> > > [    0.318081] DMAR: Host address width 39
> > > [    0.318082] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
> > > [    0.318088] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
> > > [    0.318089] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
> > > [    0.318093] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
> > > [    0.318094] DMAR: RMRR base: 0x0000009b000000 end: 0x0000009f7fffff
> > > [    0.318097] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
> > > [    0.318098] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
> > > [    0.318099] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
> > > [    0.320358] DMAR-IR: Enabled IRQ remapping in x2apic mode
> > > [    0.320359] x2apic enabled
> > > [    0.320389] Switched APIC routing to cluster x2apic.
> > > [    0.326391] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> > > [    0.346079] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x212717146a7, max_idle_ns: 440795291431 ns
> > > [    0.346084] Calibrating delay loop (skipped), value calculated using timer frequency.. 4599.93 BogoMIPS (lpj=9199872)
> > > [    0.346087] pid_max: default: 32768 minimum: 301
> > > [    0.347645] LSM: Security Framework initializing
> > > [    0.347658] Yama: becoming mindful.
> > > [    0.347687] AppArmor: AppArmor initialized
> > > [    0.347787] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
> > > [    0.347844] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
> > > [    0.347862] *** VALIDATE tmpfs ***
> > > [    0.348055] *** VALIDATE proc ***
> > > [    0.348119] *** VALIDATE cgroup1 ***
> > > [    0.348120] *** VALIDATE cgroup2 ***
> > > [    0.348187] mce: CPU0: Thermal monitoring enabled (TM1)
> > > [    0.348217] process: using mwait in idle threads
> > > [    0.348220] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
> > > [    0.348221] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
> > > [    0.348225] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> > > [    0.348227] Spectre V2 : Mitigation: Enhanced IBRS
> > > [    0.348227] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> > > [    0.348229] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> > > [    0.348231] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
> > > [    0.348563] Freeing SMP alternatives memory: 40K
> > > [    0.351059] TSC deadline timer enabled
> > > [    0.351070] smpboot: CPU0: Intel(R) Core(TM) i7-10510U CPU @ 1.80GHz (family: 0x6, model: 0x8e, stepping: 0xc)
> > > [    0.351195] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
> > > [    0.351202] ... version:                4
> > > [    0.351202] ... bit width:              48
> > > [    0.351203] ... generic registers:      4
> > > [    0.351204] ... value mask:             0000ffffffffffff
> > > [    0.351205] ... max period:             00007fffffffffff
> > > [    0.351205] ... fixed-purpose events:   3
> > > [    0.351206] ... event mask:             000000070000000f
> > > [    0.351255] rcu: Hierarchical SRCU implementation.
> > > [    0.352463] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> > > [    0.352562] smp: Bringing up secondary CPUs ...
> > > [    0.352666] x86: Booting SMP configuration:
> > > [    0.352667] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
> > > [    0.364911] smp: Brought up 1 node, 8 CPUs
> > > [    0.364911] smpboot: Max logical packages: 1
> > > [    0.364911] smpboot: Total of 8 processors activated (36799.48 BogoMIPS)
> > > [    0.366898] devtmpfs: initialized
> > > [    0.366898] x86/mm: Memory block size: 128MB
> > > [    0.372763] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> > > [    0.372763] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
> > > [    0.372763] pinctrl core: initialized pinctrl subsystem
> > > [    0.372763] PM: RTC time: 20:29:34, date: 2019-12-08
> > > [    0.372763] NET: Registered protocol family 16
> > > [    0.372763] audit: initializing netlink subsys (disabled)
> > > [    0.372763] audit: type=2000 audit(1575836974.048:1): state=initialized audit_enabled=0 res=1
> > > [    0.372763] EISA bus registered
> > > [    0.372763] cpuidle: using governor ladder
> > > [    0.372763] cpuidle: using governor menu
> > > [    0.372763] ACPI: bus type PCI registered
> > > [    0.372763] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> > > [    0.372763] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
> > > [    0.372763] PCI: not using MMCONFIG
> > > [    0.372763] PCI: Using configuration type 1 for base access
> > > [    0.379474] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> > > [    0.379474] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> > > [    0.382192] ACPI: Added _OSI(Module Device)
> > > [    0.382194] ACPI: Added _OSI(Processor Device)
> > > [    0.382195] ACPI: Added _OSI(3.0 _SCP Extensions)
> > > [    0.382196] ACPI: Added _OSI(Processor Aggregator Device)
> > > [    0.382197] ACPI: Added _OSI(Linux-Dell-Video)
> > > [    0.382198] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> > > [    0.382200] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> > > [    0.385530] ACPI: 2 ACPI AML tables successfully acquired and loaded
> > > [    0.387850] ACPI: EC: EC started
> > > [    0.387851] ACPI: EC: interrupt blocked
> > > [    0.407601] ACPI: \_SB_.PCI0.LPCB.EC0_: Used as first EC
> > > [    0.407604] ACPI: \_SB_.PCI0.LPCB.EC0_: GPE=0x50, IRQ=-1, EC_CMD/EC_SC=0x66, EC_DATA=0x62
> > > [    0.407605] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions
> > > [    0.407606] ACPI: Interpreter enabled
> > > [    0.407625] ACPI: (supports S0 S3 S4 S5)
> > > [    0.407626] ACPI: Using IOAPIC for interrupt routing
> > > [    0.407651] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
> > > [    0.408286] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
> > > [    0.408305] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> > > [    0.408507] ACPI: Enabled 2 GPEs in block 00 to 7F
> > > [    0.414176] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> > > [    0.414182] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> > > [    0.414250] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
> > > [    0.414939] PCI host bridge to bus 0000:00
> > > [    0.414941] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> > > [    0.414943] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> > > [    0.414944] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> > > [    0.414945] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
> > > [    0.414947] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
> > > [    0.414948] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
> > > [    0.414949] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
> > > [    0.414950] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
> > > [    0.414951] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
> > > [    0.414953] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
> > > [    0.414954] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
> > > [    0.414955] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
> > > [    0.414956] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
> > > [    0.414958] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff window]
> > > [    0.414959] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff window]
> > > [    0.414960] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000fffff window]
> > > [    0.414961] pci_bus 0000:00: root bus resource [mem 0x9f800001-0xdfffffff window]
> > > [    0.414963] pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7fffff window]
> > > [    0.414966] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed47fff window]
> > > [    0.414967] pci_bus 0000:00: root bus resource [bus 00-ff]
> > > [    0.414979] pci 0000:00:00.0: [8086:9b61] type 00 class 0x060000
> > > [    0.415166] pci 0000:00:02.0: [8086:9b41] type 00 class 0x030000
> > > [    0.415179] pci 0000:00:02.0: reg 0x10: [mem 0xc0000000-0xc0ffffff 64bit]
> > > [    0.415186] pci 0000:00:02.0: reg 0x18: [mem 0xb0000000-0xbfffffff 64bit pref]
> > > [    0.415191] pci 0000:00:02.0: reg 0x20: [io  0x5000-0x503f]
> > > [    0.415208] pci 0000:00:02.0: BAR 2: assigned to efifb
> > > [    0.415376] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000
> > > [    0.415391] pci 0000:00:08.0: reg 0x10: [mem 0xd1c1c000-0xd1c1cfff 64bit]
> > > [    0.415596] pci 0000:00:12.0: [8086:02f9] type 00 class 0x118000
> > > [    0.415621] pci 0000:00:12.0: reg 0x10: [mem 0xd1c1d000-0xd1c1dfff 64bit]
> > > [    0.415852] pci 0000:00:14.0: [8086:02ed] type 00 class 0x0c0330
> > > [    0.415875] pci 0000:00:14.0: reg 0x10: [mem 0xd1c00000-0xd1c0ffff 64bit]
> > > [    0.415947] pci 0000:00:14.0: PME# supported from D3hot D3cold
> > > [    0.416097] pci 0000:00:14.2: [8086:02ef] type 00 class 0x050000
> > > [    0.416122] pci 0000:00:14.2: reg 0x10: [mem 0xd1c18000-0xd1c19fff 64bit]
> > > [    0.416136] pci 0000:00:14.2: reg 0x18: [mem 0xd1c1e000-0xd1c1efff 64bit]
> > > [    0.416328] pci 0000:00:14.3: [8086:02f0] type 00 class 0x028000
> > > [    0.416359] pci 0000:00:14.3: reg 0x10: [mem 0xd1c10000-0xd1c13fff 64bit]
> > > [    0.416494] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
> > > [    0.416700] pci 0000:00:17.0: [8086:02d3] type 00 class 0x010601
> > > [    0.416720] pci 0000:00:17.0: reg 0x10: [mem 0xd1c1a000-0xd1c1bfff]
> > > [    0.416728] pci 0000:00:17.0: reg 0x14: [mem 0xd1c21000-0xd1c210ff]
> > > [    0.416737] pci 0000:00:17.0: reg 0x18: [io  0x5060-0x5067]
> > > [    0.416745] pci 0000:00:17.0: reg 0x1c: [io  0x5068-0x506b]
> > > [    0.416753] pci 0000:00:17.0: reg 0x20: [io  0x5040-0x505f]
> > > [    0.416761] pci 0000:00:17.0: reg 0x24: [mem 0xd1c20000-0xd1c207ff]
> > > [    0.416806] pci 0000:00:17.0: PME# supported from D3hot
> > > [    0.416946] pci 0000:00:19.0: [8086:02c5] type 00 class 0x0c8000
> > > [    0.416975] pci 0000:00:19.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
> > > [    0.417198] pci 0000:00:19.2: [8086:02c7] type 00 class 0x078000
> > > [    0.417229] pci 0000:00:19.2: reg 0x10: [mem 0xfe032000-0xfe032fff 64bit]
> > > [    0.417478] pci 0000:00:1c.0: [8086:02bc] type 01 class 0x060400
> > > [    0.417644] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> > > [    0.417668] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
> > > [    0.417829] pci 0000:00:1d.0: [8086:02b0] type 01 class 0x060400
> > > [    0.417919] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> > > [    0.417943] pci 0000:00:1d.0: PTM enabled (root), 4ns granularity
> > > [    0.418126] pci 0000:00:1f.0: [8086:0284] type 00 class 0x060100
> > > [    0.418514] pci 0000:00:1f.3: [8086:02c8] type 00 class 0x040300
> > > [    0.418588] pci 0000:00:1f.3: reg 0x10: [mem 0xd1c14000-0xd1c17fff 64bit]
> > > [    0.418672] pci 0000:00:1f.3: reg 0x20: [mem 0xd1b00000-0xd1bfffff 64bit]
> > > [    0.418809] pci 0000:00:1f.3: PME# supported from D3hot D3cold
> > > [    0.419020] pci 0000:00:1f.4: [8086:02a3] type 00 class 0x0c0500
> > > [    0.419050] pci 0000:00:1f.4: reg 0x10: [mem 0xd1c22000-0xd1c220ff 64bit]
> > > [    0.419081] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
> > > [    0.419258] pci 0000:00:1f.5: [8086:02a4] type 00 class 0x0c8000
> > > [    0.419277] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
> > > [    0.419533] pci 0000:01:00.0: [8086:15e7] type 01 class 0x060400
> > > [    0.419598] pci 0000:01:00.0: enabling Extended Tags
> > > [    0.419697] pci 0000:01:00.0: supports D1 D2
> > > [    0.419698] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> > > [    0.419775] pci 0000:01:00.0: PTM enabled, 4ns granularity
> > > [    0.419922] pci 0000:00:1c.0: PCI bridge to [bus 01-25]
> > > [    0.419926] pci 0000:00:1c.0:   bridge window [io  0x2000-0x3fff]
> > > [    0.419929] pci 0000:00:1c.0:   bridge window [mem 0xd1000000-0xd19fffff]
> > > [    0.419933] pci 0000:00:1c.0:   bridge window [mem 0xc1000000-0xd0ffffff 64bit pref]
> > > [    0.419997] pci 0000:02:00.0: [8086:15e7] type 01 class 0x060400
> > > [    0.420067] pci 0000:02:00.0: enabling Extended Tags
> > > [    0.420167] pci 0000:02:00.0: supports D1 D2
> > > [    0.420168] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> > > [    0.420294] pci 0000:02:01.0: [8086:15e7] type 01 class 0x060400
> > > [    0.420363] pci 0000:02:01.0: enabling Extended Tags
> > > [    0.420463] pci 0000:02:01.0: supports D1 D2
> > > [    0.420465] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> > > [    0.420583] pci 0000:02:02.0: [8086:15e7] type 01 class 0x060400
> > > [    0.420652] pci 0000:02:02.0: enabling Extended Tags
> > > [    0.420749] pci 0000:02:02.0: supports D1 D2
> > > [    0.420750] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
> > > [    0.420894] pci 0000:01:00.0: PCI bridge to [bus 02-25]
> > > [    0.420900] pci 0000:01:00.0:   bridge window [io  0x2000-0x3fff]
> > > [    0.420904] pci 0000:01:00.0:   bridge window [mem 0xd1000000-0xd19fffff]
> > > [    0.420911] pci 0000:01:00.0:   bridge window [mem 0xc1000000-0xd0ffffff 64bit pref]
> > > [    0.420975] pci 0000:03:00.0: [8086:15e8] type 00 class 0x088000
> > > [    0.421009] pci 0000:03:00.0: reg 0x10: [mem 0xd1800000-0xd183ffff]
> > > [    0.421022] pci 0000:03:00.0: reg 0x14: [mem 0xd1840000-0xd1840fff]
> > > [    0.421086] pci 0000:03:00.0: enabling Extended Tags
> > > [    0.421193] pci 0000:03:00.0: supports D1 D2
> > > [    0.421194] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> > > [    0.421368] pci 0000:02:00.0: PCI bridge to [bus 03]
> > > [    0.421377] pci 0000:02:00.0:   bridge window [mem 0xd1800000-0xd18fffff]
> > > [    0.421433] pci 0000:02:01.0: PCI bridge to [bus 04-24]
> > > [    0.421439] pci 0000:02:01.0:   bridge window [io  0x2000-0x3fff]
> > > [    0.421443] pci 0000:02:01.0:   bridge window [mem 0xd1000000-0xd17fffff]
> > > [    0.421449] pci 0000:02:01.0:   bridge window [mem 0xc1000000-0xd0ffffff 64bit pref]
> > > [    0.421516] pci 0000:25:00.0: [8086:15e9] type 00 class 0x0c0330
> > > [    0.421553] pci 0000:25:00.0: reg 0x10: [mem 0xd1900000-0xd190ffff]
> > > [    0.421635] pci 0000:25:00.0: enabling Extended Tags
> > > [    0.421750] pci 0000:25:00.0: supports D1 D2
> > > [    0.421752] pci 0000:25:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> > > [    0.421846] pci 0000:25:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x4 link at 0000:02:02.0 (capable of 31.504 Gb/s with 8 GT/s x4 link)
> > > [    0.421953] pci 0000:02:02.0: PCI bridge to [bus 25]
> > > [    0.421962] pci 0000:02:02.0:   bridge window [mem 0xd1900000-0xd19fffff]
> > > [    0.422044] pci 0000:26:00.0: [10ec:5287] type 00 class 0xff0000
> > > [    0.422075] pci 0000:26:00.0: reg 0x10: [mem 0xd1a14000-0xd1a14fff]
> > > [    0.422139] pci 0000:26:00.0: reg 0x30: [mem 0xd1a00000-0xd1a0ffff pref]
> > > [    0.422238] pci 0000:26:00.0: supports D1 D2
> > > [    0.422240] pci 0000:26:00.0: PME# supported from D1 D2 D3hot D3cold
> > > [    0.422365] pci 0000:26:00.1: [10ec:8168] type 00 class 0x020000
> > > [    0.422395] pci 0000:26:00.1: reg 0x10: [io  0x4000-0x40ff]
> > > [    0.422423] pci 0000:26:00.1: reg 0x18: [mem 0xd1a15000-0xd1a15fff 64bit]
> > > [    0.422441] pci 0000:26:00.1: reg 0x20: [mem 0xd1a10000-0xd1a13fff 64bit]
> > > [    0.422547] pci 0000:26:00.1: supports D1 D2
> > > [    0.422548] pci 0000:26:00.1: PME# supported from D0 D1 D2 D3hot D3cold
> > > [    0.422706] pci 0000:00:1d.0: PCI bridge to [bus 26]
> > > [    0.422711] pci 0000:00:1d.0:   bridge window [io  0x4000-0x4fff]
> > > [    0.422714] pci 0000:00:1d.0:   bridge window [mem 0xd1a00000-0xd1afffff]
> > > [    0.424212] ACPI: EC: interrupt unblocked
> > > [    0.424234] ACPI: EC: event unblocked
> > > [    0.424252] ACPI: \_SB_.PCI0.LPCB.EC0_: GPE=0x50, IRQ=-1, EC_CMD/EC_SC=0x66, EC_DATA=0x62
> > > [    0.424254] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions and events
> > > [    0.424354] iommu: Default domain type: Translated 
> > > [    0.424354] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> > > [    0.424354] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> > > [    0.424354] pci 0000:00:02.0: vgaarb: bridge control possible
> > > [    0.424354] vgaarb: loaded
> > > [    0.424354] SCSI subsystem initialized
> > > [    0.424354] libata version 3.00 loaded.
> > > [    0.424354] ACPI: bus type USB registered
> > > [    0.424354] usbcore: registered new interface driver usbfs
> > > [    0.424354] usbcore: registered new interface driver hub
> > > [    0.424354] usbcore: registered new device driver usb
> > > [    0.424354] pps_core: LinuxPPS API ver. 1 registered
> > > [    0.424354] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> > > [    0.424354] PTP clock support registered
> > > [    0.424354] EDAC MC: Ver: 3.0.0
> > > [    0.424354] Registered efivars operations
> > > [    0.424354] PCI: Using ACPI for IRQ routing
> > > [    0.463615] PCI: pci_cache_line_size set to 64 bytes
> > > [    0.463744] e820: reserve RAM buffer [mem 0x996ae000-0x9bffffff]
> > > [    0.463746] e820: reserve RAM buffer [mem 0x997fd000-0x9bffffff]
> > > [    0.463747] e820: reserve RAM buffer [mem 0x99b5e000-0x9bffffff]
> > > [    0.463748] e820: reserve RAM buffer [mem 0x85e800000-0x85fffffff]
> > > [    0.463858] NetLabel: Initializing
> > > [    0.463859] NetLabel:  domain hash size = 128
> > > [    0.463860] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> > > [    0.463883] NetLabel:  unlabeled traffic allowed by default
> > > [    0.463900] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> > > [    0.463900] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
> > > [    0.468162] clocksource: Switched to clocksource tsc-early
> > > [    0.480899] *** VALIDATE bpf ***
> > > [    0.481009] VFS: Disk quotas dquot_6.6.0
> > > [    0.481027] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> > > [    0.481054] *** VALIDATE ramfs ***
> > > [    0.481058] *** VALIDATE hugetlbfs ***
> > > [    0.481147] AppArmor: AppArmor Filesystem Enabled
> > > [    0.481174] pnp: PnP ACPI init
> > > [    0.481418] system 00:00: [mem 0xfed10000-0xfed17fff] has been reserved
> > > [    0.481420] system 00:00: [mem 0xfed18000-0xfed18fff] has been reserved
> > > [    0.481421] system 00:00: [mem 0xfed19000-0xfed19fff] has been reserved
> > > [    0.481422] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
> > > [    0.481424] system 00:00: [mem 0xfed90000-0xfed93fff] could not be reserved
> > > [    0.481426] system 00:00: [mem 0xfff00000-0x100efffff] could not be reserved
> > > [    0.481428] system 00:00: [mem 0xfee00000-0xfeefffff] has been reserved
> > > [    0.481429] system 00:00: [mem 0xfed00000-0xfed003ff] has been reserved
> > > [    0.481435] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
> > > [    0.481518] system 00:01: [io  0x1800-0x18fe] has been reserved
> > > [    0.481522] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
> > > [    0.481545] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
> > > [    0.481582] pnp 00:03: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
> > > [    0.481612] pnp 00:04: Plug and Play ACPI device, IDs PNP0f13 (active)
> > > [    0.482671] pnp: PnP ACPI: found 5 devices
> > > [    0.484133] thermal_sys: Registered thermal governor 'fair_share'
> > > [    0.484134] thermal_sys: Registered thermal governor 'bang_bang'
> > > [    0.484134] thermal_sys: Registered thermal governor 'step_wise'
> > > [    0.484135] thermal_sys: Registered thermal governor 'user_space'
> > > [    0.484136] thermal_sys: Registered thermal governor 'power_allocator'
> > > [    0.488649] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> > > [    0.488705] pci 0000:00:19.0: BAR 0: assigned [mem 0x9f801000-0x9f801fff 64bit]
> > > [    0.488722] pci 0000:02:00.0: PCI bridge to [bus 03]
> > > [    0.488727] pci 0000:02:00.0:   bridge window [mem 0xd1800000-0xd18fffff]
> > > [    0.488737] pci 0000:02:01.0: PCI bridge to [bus 04-24]
> > > [    0.488740] pci 0000:02:01.0:   bridge window [io  0x2000-0x3fff]
> > > [    0.488745] pci 0000:02:01.0:   bridge window [mem 0xd1000000-0xd17fffff]
> > > [    0.488749] pci 0000:02:01.0:   bridge window [mem 0xc1000000-0xd0ffffff 64bit pref]
> > > [    0.488755] pci 0000:02:02.0: PCI bridge to [bus 25]
> > > [    0.488761] pci 0000:02:02.0:   bridge window [mem 0xd1900000-0xd19fffff]
> > > [    0.488770] pci 0000:01:00.0: PCI bridge to [bus 02-25]
> > > [    0.488772] pci 0000:01:00.0:   bridge window [io  0x2000-0x3fff]
> > > [    0.488777] pci 0000:01:00.0:   bridge window [mem 0xd1000000-0xd19fffff]
> > > [    0.488781] pci 0000:01:00.0:   bridge window [mem 0xc1000000-0xd0ffffff 64bit pref]
> > > [    0.488787] pci 0000:00:1c.0: PCI bridge to [bus 01-25]
> > > [    0.488791] pci 0000:00:1c.0:   bridge window [io  0x2000-0x3fff]
> > > [    0.488794] pci 0000:00:1c.0:   bridge window [mem 0xd1000000-0xd19fffff]
> > > [    0.488797] pci 0000:00:1c.0:   bridge window [mem 0xc1000000-0xd0ffffff 64bit pref]
> > > [    0.488802] pci 0000:00:1d.0: PCI bridge to [bus 26]
> > > [    0.488804] pci 0000:00:1d.0:   bridge window [io  0x4000-0x4fff]
> > > [    0.488807] pci 0000:00:1d.0:   bridge window [mem 0xd1a00000-0xd1afffff]
> > > [    0.488815] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> > > [    0.488816] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> > > [    0.488817] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> > > [    0.488819] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
> > > [    0.488820] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
> > > [    0.488821] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
> > > [    0.488822] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
> > > [    0.488824] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
> > > [    0.488825] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
> > > [    0.488826] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
> > > [    0.488828] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
> > > [    0.488829] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff window]
> > > [    0.488830] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff window]
> > > [    0.488831] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff window]
> > > [    0.488832] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff window]
> > > [    0.488834] pci_bus 0000:00: resource 19 [mem 0x000f0000-0x000fffff window]
> > > [    0.488835] pci_bus 0000:00: resource 20 [mem 0x9f800001-0xdfffffff window]
> > > [    0.488836] pci_bus 0000:00: resource 21 [mem 0xfc800000-0xfe7fffff window]
> > > [    0.488838] pci_bus 0000:00: resource 22 [mem 0xfed40000-0xfed47fff window]
> > > [    0.488839] pci_bus 0000:01: resource 0 [io  0x2000-0x3fff]
> > > [    0.488840] pci_bus 0000:01: resource 1 [mem 0xd1000000-0xd19fffff]
> > > [    0.488842] pci_bus 0000:01: resource 2 [mem 0xc1000000-0xd0ffffff 64bit pref]
> > > [    0.488843] pci_bus 0000:02: resource 0 [io  0x2000-0x3fff]
> > > [    0.488844] pci_bus 0000:02: resource 1 [mem 0xd1000000-0xd19fffff]
> > > [    0.488845] pci_bus 0000:02: resource 2 [mem 0xc1000000-0xd0ffffff 64bit pref]
> > > [    0.488847] pci_bus 0000:03: resource 1 [mem 0xd1800000-0xd18fffff]
> > > [    0.488848] pci_bus 0000:04: resource 0 [io  0x2000-0x3fff]
> > > [    0.488849] pci_bus 0000:04: resource 1 [mem 0xd1000000-0xd17fffff]
> > > [    0.488850] pci_bus 0000:04: resource 2 [mem 0xc1000000-0xd0ffffff 64bit pref]
> > > [    0.488851] pci_bus 0000:25: resource 1 [mem 0xd1900000-0xd19fffff]
> > > [    0.488853] pci_bus 0000:26: resource 0 [io  0x4000-0x4fff]
> > > [    0.488854] pci_bus 0000:26: resource 1 [mem 0xd1a00000-0xd1afffff]
> > > [    0.488965] NET: Registered protocol family 2
> > > [    0.489174] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
> > > [    0.489378] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> > > [    0.489809] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
> > > [    0.489925] TCP: Hash tables configured (established 262144 bind 65536)
> > > [    0.489998] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
> > > [    0.490116] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
> > > [    0.490225] NET: Registered protocol family 1
> > > [    0.490230] NET: Registered protocol family 44
> > > [    0.490241] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> > > [    0.491896] PCI: CLS 64 bytes, default 64
> > > [    0.491941] Trying to unpack rootfs image as initramfs...
> > > [    1.319434] Freeing initrd memory: 39468K
> > > [    1.362141] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> > > [    1.362143] software IO TLB: mapped [mem 0x91b50000-0x95b50000] (64MB)
> > > [    1.362551] check: Scanning for low memory corruption every 60 seconds
> > > [    1.364202] Initialise system trusted keyrings
> > > [    1.364212] Key type blacklist registered
> > > [    1.364246] workingset: timestamp_bits=36 max_order=23 bucket_order=0
> > > [    1.365864] zbud: loaded
> > > [    1.366213] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> > > [    1.366390] fuse: init (API version 7.31)
> > > [    1.366408] *** VALIDATE fuse ***
> > > [    1.366410] *** VALIDATE fuse ***
> > > [    1.366566] Platform Keyring initialized
> > > [    1.371834] Key type asymmetric registered
> > > [    1.371835] Asymmetric key parser 'x509' registered
> > > [    1.371845] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 244)
> > > [    1.371891] io scheduler mq-deadline registered
> > > [    1.372122] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
> > > [    1.372152] pcieport 0000:00:1c.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ LLActRep+
> > > [    1.372462] pcieport 0000:00:1d.0: PME: Signaling with IRQ 123
> > > [    1.373527] pcieport 0000:02:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ LLActRep+
> > > [    1.373892] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> > > [    1.373958] efifb: probing for efifb
> > > [    1.373973] efifb: framebuffer at 0xb0000000, using 8128k, total 8128k
> > > [    1.373974] efifb: mode is 1920x1080x32, linelength=7680, pages=1
> > > [    1.373975] efifb: scrolling: redraw
> > > [    1.373976] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> > > [    1.374090] Console: switching to colour frame buffer device 240x67
> > > [    1.380543] fb0: EFI VGA frame buffer device
> > > [    1.380553] intel_idle: MWAIT substates: 0x11142120
> > > [    1.380554] intel_idle: v0.4.1 model 0x8E
> > > [    1.381136] intel_idle: lapic_timer_reliable_states 0xffffffff
> > > [    1.381301] ACPI: AC Adapter [AC] (on-line)
> > > [    1.381369] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> > > [    1.381410] ACPI: Power Button [PWRB]
> > > [    1.381448] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
> > > [    1.381480] ACPI: Sleep Button [SLPB]
> > > [    1.381517] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input2
> > > [    1.381546] ACPI: Lid Switch [LID0]
> > > [    1.381582] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
> > > [    1.381608] ACPI: Power Button [PWRF]
> > > [    1.382259] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> > > [    1.384310] Linux agpgart interface v0.103
> > > [    1.387325] loop: module loaded
> > > [    1.387557] libphy: Fixed MDIO Bus: probed
> > > [    1.387558] tun: Universal TUN/TAP device driver, 1.6
> > > [    1.387592] PPP generic driver version 2.4.2
> > > [    1.387631] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> > > [    1.387634] ehci-pci: EHCI PCI platform driver
> > > [    1.387646] ehci-platform: EHCI generic platform driver
> > > [    1.387654] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> > > [    1.387656] ohci-pci: OHCI PCI platform driver
> > > [    1.387665] ohci-platform: OHCI generic platform driver
> > > [    1.387673] uhci_hcd: USB Universal Host Controller Interface driver
> > > [    1.387875] xhci_hcd 0000:00:14.0: xHCI Host Controller
> > > [    1.387881] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
> > > [    1.389025] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000000009810
> > > [    1.389030] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
> > > [    1.389225] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.04
> > > [    1.389227] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> > > [    1.389228] usb usb1: Product: xHCI Host Controller
> > > [    1.389229] usb usb1: Manufacturer: Linux 5.4.0-s76+ xhci-hcd
> > > [    1.389231] usb usb1: SerialNumber: 0000:00:14.0
> > > [    1.389339] hub 1-0:1.0: USB hub found
> > > [    1.389359] hub 1-0:1.0: 12 ports detected
> > > [    1.389778] xhci_hcd 0000:00:14.0: xHCI Host Controller
> > > [    1.389781] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
> > > [    1.389785] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
> > > [    1.389826] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.04
> > > [    1.389828] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> > > [    1.389829] usb usb2: Product: xHCI Host Controller
> > > [    1.389830] usb usb2: Manufacturer: Linux 5.4.0-s76+ xhci-hcd
> > > [    1.389831] usb usb2: SerialNumber: 0000:00:14.0
> > > [    1.389918] hub 2-0:1.0: USB hub found
> > > [    1.389929] hub 2-0:1.0: 6 ports detected
> > > [    1.390476] xhci_hcd 0000:25:00.0: xHCI Host Controller
> > > [    1.390482] xhci_hcd 0000:25:00.0: new USB bus registered, assigned bus number 3
> > > [    1.391629] xhci_hcd 0000:25:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
> > > [    1.391851] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.04
> > > [    1.391853] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> > > [    1.391854] usb usb3: Product: xHCI Host Controller
> > > [    1.391855] usb usb3: Manufacturer: Linux 5.4.0-s76+ xhci-hcd
> > > [    1.391857] usb usb3: SerialNumber: 0000:25:00.0
> > > [    1.391982] hub 3-0:1.0: USB hub found
> > > [    1.391991] hub 3-0:1.0: 2 ports detected
> > > [    1.392157] xhci_hcd 0000:25:00.0: xHCI Host Controller
> > > [    1.392160] xhci_hcd 0000:25:00.0: new USB bus registered, assigned bus number 4
> > > [    1.392162] xhci_hcd 0000:25:00.0: Host supports USB 3.1 Enhanced SuperSpeed
> > > [    1.392197] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.04
> > > [    1.392198] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> > > [    1.392199] usb usb4: Product: xHCI Host Controller
> > > [    1.392200] usb usb4: Manufacturer: Linux 5.4.0-s76+ xhci-hcd
> > > [    1.392201] usb usb4: SerialNumber: 0000:25:00.0
> > > [    1.392320] hub 4-0:1.0: USB hub found
> > > [    1.392331] hub 4-0:1.0: 2 ports detected
> > > [    1.392464] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> > > [    1.401223] i8042: Detected active multiplexing controller, rev 1.1
> > > [    1.407103] serio: i8042 KBD port at 0x60,0x64 irq 1
> > > [    1.407108] serio: i8042 AUX0 port at 0x60,0x64 irq 12
> > > [    1.407136] serio: i8042 AUX1 port at 0x60,0x64 irq 12
> > > [    1.407157] serio: i8042 AUX2 port at 0x60,0x64 irq 12
> > > [    1.407179] serio: i8042 AUX3 port at 0x60,0x64 irq 12
> > > [    1.407387] mousedev: PS/2 mouse device common for all mice
> > > [    1.407943] rtc_cmos 00:02: RTC can wake from S4
> > > [    1.408930] rtc_cmos 00:02: registered as rtc0
> > > [    1.408948] rtc_cmos 00:02: alarms up to one month, 242 bytes nvram, hpet irqs
> > > [    1.408955] i2c /dev entries driver
> > > [    1.409003] device-mapper: uevent: version 1.0.3
> > > [    1.409067] device-mapper: ioctl: 4.41.0-ioctl (2019-09-16) initialised: dm-devel@redhat.com
> > > [    1.409089] platform eisa.0: Probing EISA bus 0
> > > [    1.409091] platform eisa.0: EISA: Cannot allocate resource for mainboard
> > > [    1.409093] platform eisa.0: Cannot allocate resource for EISA slot 1
> > > [    1.409094] platform eisa.0: Cannot allocate resource for EISA slot 2
> > > [    1.409095] platform eisa.0: Cannot allocate resource for EISA slot 3
> > > [    1.409096] platform eisa.0: Cannot allocate resource for EISA slot 4
> > > [    1.409097] platform eisa.0: Cannot allocate resource for EISA slot 5
> > > [    1.409098] platform eisa.0: Cannot allocate resource for EISA slot 6
> > > [    1.409100] platform eisa.0: Cannot allocate resource for EISA slot 7
> > > [    1.409101] platform eisa.0: Cannot allocate resource for EISA slot 8
> > > [    1.409102] platform eisa.0: EISA: Detected 0 cards
> > > [    1.409106] intel_pstate: Intel P-state driver initializing
> > > [    1.409525] intel_pstate: HWP enabled
> > > [    1.409623] ledtrig-cpu: registered to indicate activity on CPUs
> > > [    1.409625] EFI Variables Facility v0.08 2004-May-17
> > > [    1.409814] intel_pmc_core intel_pmc_core.0:  initialized
> > > [    1.409838] drop_monitor: Initializing network drop monitor service
> > > [    1.409934] NET: Registered protocol family 10
> > > [    1.411236] battery: ACPI: Battery Slot [BAT0] (battery present)
> > > [    1.412628] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
> > > [    1.413579] Segment Routing with IPv6
> > > [    1.413605] NET: Registered protocol family 17
> > > [    1.413677] Key type dns_resolver registered
> > > [    1.413953] RAS: Correctable Errors collector initialized.
> > > [    1.413967] microcode: sig=0x806ec, pf=0x4, revision=0xca
> > > [    1.413997] microcode: Microcode Update Driver: v2.2.
> > > [    1.413999] IPI shorthand broadcast: enabled
> > > [    1.414002] sched_clock: Marking stable (1409476824, 4518186)->(1421454622, -7459612)
> > > [    1.414042] registered taskstats version 1
> > > [    1.414048] Loading compiled-in X.509 certificates
> > > [    1.414844] Loaded X.509 cert 'Build time autogenerated kernel key: 2ad175b85115461edd963278357c6de8afa8adad'
> > > [    1.414865] zswap: loaded using pool lzo/zbud
> > > [    1.414904] Key type ._fscrypt registered
> > > [    1.414905] Key type .fscrypt registered
> > > [    1.417421] Key type big_key registered
> > > [    1.418723] Key type encrypted registered
> > > [    1.418725] AppArmor: AppArmor sha1 policy hashing enabled
> > > [    1.418737] Couldn't get size: 0x800000000000000e
> > > [    1.418751] MODSIGN: Couldn't get UEFI db list
> > > [    1.418765] Couldn't get size: 0x800000000000000e
> > > [    1.418776] Couldn't get UEFI MokListRT
> > > [    1.418780] Couldn't get size: 0x800000000000000e
> > > [    1.418791] Couldn't get UEFI dbx list
> > > [    1.418792] ima: No TPM chip found, activating TPM-bypass!
> > > [    1.418795] ima: Allocated hash algorithm: sha1
> > > [    1.418799] ima: No architecture policies found
> > > [    1.418803] evm: Initialising EVM extended attributes:
> > > [    1.418803] evm: security.selinux
> > > [    1.418804] evm: security.SMACK64
> > > [    1.418804] evm: security.SMACK64EXEC
> > > [    1.418804] evm: security.SMACK64TRANSMUTE
> > > [    1.418804] evm: security.SMACK64MMAP
> > > [    1.418805] evm: security.apparmor
> > > [    1.418805] evm: security.ima
> > > [    1.418805] evm: security.capability
> > > [    1.418805] evm: HMAC attrs: 0x1
> > > [    1.419012] PM:   Magic number: 15:685:497
> > > [    1.419227] rtc_cmos 00:02: setting system clock to 2019-12-08T20:29:35 UTC (1575836975)
> > > [    1.420026] Freeing unused decrypted memory: 2040K
> > > [    1.420341] Freeing unused kernel image (initmem) memory: 2628K
> > > [    1.478325] Write protecting the kernel read-only data: 22528k
> > > [    1.478836] Freeing unused kernel image (text/rodata gap) memory: 2044K
> > > [    1.479015] Freeing unused kernel image (rodata/data gap) memory: 1332K
> > > [    1.484120] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> > > [    1.484121] Run /init as init process
> > > [    1.531350] ahci 0000:00:17.0: version 3.0
> > > [    1.541661] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x5 impl SATA mode
> > > [    1.541663] ahci 0000:00:17.0: flags: 64bit ncq sntf clo only pio slum part deso sadm sds apst 
> > > [    1.542020] scsi host0: ahci
> > > [    1.542175] scsi host1: ahci
> > > [    1.542266] scsi host2: ahci
> > > [    1.542321] ata1: SATA max UDMA/133 abar m2048@0xd1c20000 port 0xd1c20100 irq 130
> > > [    1.542322] ata2: DUMMY
> > > [    1.542324] ata3: SATA max UDMA/133 abar m2048@0xd1c20000 port 0xd1c20200 irq 130
> > > [    1.543109] libphy: r8169: probed
> > > [    1.543272] r8169 0000:26:00.1 eth0: RTL8411b, 80:fa:5b:76:ff:29, XID 5c8, IRQ 148
> > > [    1.543274] r8169 0000:26:00.1 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
> > > [    1.550208] r8169 0000:26:00.1 enp38s0f1: renamed from eth0
> > > [    1.722285] usb 1-7: new high-speed USB device number 2 using xhci_hcd
> > > [    1.834319] usb 4-1: new SuperSpeedPlus Gen 2 USB device number 2 using xhci_hcd
> > > [    1.854582] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> > > [    1.854616] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> > > [    1.855149] usb 4-1: New USB device found, idVendor=1058, idProduct=25f3, bcdDevice=10.06
> > > [    1.855149] usb 4-1: New USB device strings: Mfr=2, Product=3, SerialNumber=1
> > > [    1.855150] usb 4-1: Product: My Passport 25F3
> > > [    1.855151] usb 4-1: Manufacturer: Western Digital
> > > [    1.855151] usb 4-1: SerialNumber: 313731313235343230353231
> > > [    1.855764] ata1.00: ATA-11: WDC  WDS500G2B0A-00SM50, 411030WD, max UDMA/133
> > > [    1.855765] ata1.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 32), AA
> > > [    1.855871] ata3.00: ATA-11: WDC  WDS500G2B0B-00YS70, 401000WD, max UDMA/133
> > > [    1.855872] ata3.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 32), AA
> > > [    1.857970] ata1.00: configured for UDMA/133
> > > [    1.858091] scsi 0:0:0:0: Direct-Access     ATA      WDC  WDS500G2B0A 30WD PQ: 0 ANSI: 5
> > > [    1.858219] ata3.00: configured for UDMA/133
> > > [    1.858541] sd 0:0:0:0: Attached scsi generic sg0 type 0
> > > [    1.858606] usb-storage 4-1:1.0: USB Mass Storage device detected
> > > [    1.858704] scsi host3: usb-storage 4-1:1.0
> > > [    1.858704] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
> > > [    1.858715] sd 0:0:0:0: [sda] Write Protect is off
> > > [    1.858716] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> > > [    1.858717] scsi 2:0:0:0: Direct-Access     ATA      WDC  WDS500G2B0B 00WD PQ: 0 ANSI: 5
> > > [    1.858730] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> > > [    1.858745] usbcore: registered new interface driver usb-storage
> > > [    1.858811] sd 2:0:0:0: Attached scsi generic sg1 type 0
> > > [    1.858861] sd 2:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/466 GiB)
> > > [    1.858866] sd 2:0:0:0: [sdb] Write Protect is off
> > > [    1.858868] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> > > [    1.858878] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> > > [    1.859319] usbcore: registered new interface driver uas
> > > [    1.884844]  sdb: sdb1 sdb2 sdb3
> > > [    1.885280] sd 2:0:0:0: [sdb] Attached SCSI disk
> > > [    1.887100] usb 1-7: New USB device found, idVendor=04f2, idProduct=b649, bcdDevice=54.03
> > > [    1.887101] usb 1-7: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> > > [    1.887102] usb 1-7: Product: Chicony USB2.0 Camera
> > > [    1.887103] usb 1-7: Manufacturer: Sonix Technology Co., Ltd.
> > > [    1.887405]  sda: sda1
> > > [    1.887861] sd 0:0:0:0: [sda] Attached SCSI disk
> > > [    2.014289] usb 1-10: new full-speed USB device number 3 using xhci_hcd
> > > [    2.164349] usb 1-10: config 1 interface 1 altsetting 0 endpoint 0x3 has wMaxPacketSize 0, skipping
> > > [    2.164350] usb 1-10: config 1 interface 1 altsetting 0 endpoint 0x83 has wMaxPacketSize 0, skipping
> > > [    2.164369] usb 1-10: New USB device found, idVendor=8087, idProduct=0aaa, bcdDevice= 0.02
> > > [    2.164370] usb 1-10: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> > > [    2.209385] EXT4-fs (sdb2): mounted filesystem with ordered data mode. Opts: (null)
> > > [    2.370322] tsc: Refined TSC clocksource calibration: 2304.057 MHz
> > > [    2.370327] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x21362da4cd9, max_idle_ns: 440795297718 ns
> > > [    2.370387] clocksource: Switched to clocksource tsc
> > > [    2.541007] systemd[1]: systemd 237 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
> > > [    2.558452] systemd[1]: Detected architecture x86-64.
> > > [    2.579374] systemd[1]: Set hostname to <system76-pc>.
> > > [    2.581606] systemd[1]: Couldn't move remaining userspace processes, ignoring: Input/output error
> > > [    2.711811] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
> > > [    2.711828] systemd[1]: Reached target Remote File Systems.
> > > [    2.711911] systemd[1]: Created slice System Slice.
> > > [    2.711946] systemd[1]: Listening on udev Control Socket.
> > > [    2.711963] systemd[1]: Listening on udev Kernel Socket.
> > > [    2.711994] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
> > > [    2.721866] EXT4-fs (sdb2): re-mounted. Opts: errors=remount-ro
> > > [    2.785600] lp: driver loaded but no devices found
> > > [    2.787470] ppdev: user-space parallel port driver
> > > [    2.798899] systemd-journald[377]: Received request to flush runtime journal from PID 1
> > > [    2.886665] scsi 3:0:0:0: Direct-Access     WD       My Passport 25F3 1006 PQ: 0 ANSI: 6
> > > [    2.886816] scsi 3:0:0:1: Enclosure         WD       SES Device       1006 PQ: 0 ANSI: 6
> > > [    2.887822] sd 3:0:0:0: Attached scsi generic sg2 type 0
> > > [    2.887947] scsi 3:0:0:1: Attached scsi generic sg3 type 13
> > > [    2.887992] sd 3:0:0:0: [sdc] 1000148992 512-byte logical blocks: (512 GB/477 GiB)
> > > [    2.888191] sd 3:0:0:0: [sdc] Write Protect is off
> > > [    2.888192] sd 3:0:0:0: [sdc] Mode Sense: 47 00 10 08
> > > [    2.888390] sd 3:0:0:0: [sdc] No Caching mode page found
> > > [    2.888407] sd 3:0:0:0: [sdc] Assuming drive cache: write through
> > > [    2.920227]  sdc: sdc1 sdc2 sdc3 sdc4 sdc5 sdc6
> > > [    2.921006] sd 3:0:0:0: [sdc] Attached SCSI disk
> > > [    3.451998] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> > > [    3.452097] input: Intel HID events as /devices/platform/INT33D5:00/input/input9
> > > [    3.453624] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> > > [    3.600822] Intel(R) Wireless WiFi driver for Linux
> > > [    3.600824] Copyright(c) 2003- 2015 Intel Corporation
> > > [    3.602078] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-Qu-b0-jf-b0-52.ucode failed with error -2
> > > [    3.602101] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-Qu-b0-jf-b0-51.ucode failed with error -2
> > > [    3.602113] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-Qu-b0-jf-b0-50.ucode failed with error -2
> > > [    3.602124] iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-Qu-b0-jf-b0-49.ucode failed with error -2
> > > [    3.630164] intel-lpss 0000:00:19.0: enabling device (0000 -> 0002)
> > > [    3.640356] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 43.2.23.17
> > > [    3.640589] iwlwifi 0000:00:14.3: loaded firmware version 48.4fa0041f.0 op_mode iwlmvm
> > > [    3.644546] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
> > > [    3.644547] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> > > [    3.644548] RAPL PMU: hw unit of domain package 2^-14 Joules
> > > [    3.644549] RAPL PMU: hw unit of domain dram 2^-14 Joules
> > > [    3.644549] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> > > [    3.644550] RAPL PMU: hw unit of domain psys 2^-14 Joules
> > > [    3.645243] Bluetooth: Core ver 2.22
> > > [    3.645254] NET: Registered protocol family 31
> > > [    3.645254] Bluetooth: HCI device and connection manager initialized
> > > [    3.645257] Bluetooth: HCI socket layer initialized
> > > [    3.645259] Bluetooth: L2CAP socket layer initialized
> > > [    3.645261] Bluetooth: SCO socket layer initialized
> > > [    3.706357] cryptd: max_cpu_qlen set to 1000
> > > [    3.708087] usbcore: registered new interface driver btusb
> > > [    3.709142] Bluetooth: hci0: Bootloader revision 0.1 build 0 week 30 2018
> > > [    3.710132] Bluetooth: hci0: Device revision is 2
> > > [    3.710133] Bluetooth: hci0: Secure boot is enabled
> > > [    3.710134] Bluetooth: hci0: OTP lock is enabled
> > > [    3.710134] Bluetooth: hci0: API lock is enabled
> > > [    3.710135] Bluetooth: hci0: Debug lock is disabled
> > > [    3.710136] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> > > [    3.823101] AVX2 version of gcm_enc/dec engaged.
> > > [    3.823103] AES CTR mode by8 optimization enabled
> > > [    3.823420] Bluetooth: hci0: Found device firmware: intel/ibt-19-0-1.sfi
> > > [    3.828019] checking generic (b0000000 7f0000) vs hw (c0000000 1000000)
> > > [    3.828020] checking generic (b0000000 7f0000) vs hw (b0000000 10000000)
> > > [    3.828020] fb0: switching to inteldrmfb from EFI VGA
> > > [    3.828185] Console: switching to colour dummy device 80x25
> > > [    3.828243] i915 0000:00:02.0: vgaarb: deactivate vga console
> > > [    3.846495] iwlwifi 0000:00:14.3: Detected Intel(R) Wireless-AC 9560, REV=0x354
> > > [    3.880650] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> > > [    3.880651] [drm] Driver supports precise vblank timestamp query.
> > > [    3.880745] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> > > [    3.947819] [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
> > > [    3.951103] mc: Linux media interface: v0.10
> > > [    3.961354] scsi 3:0:0:1: Wrong diagnostic page; asked for 1 got 8
> > > [    3.961358] scsi 3:0:0:1: Failed to get diagnostic page 0x1
> > > [    3.961360] scsi 3:0:0:1: Failed to bind enclosure -19
> > > [    3.961374] ses 3:0:0:1: Attached Enclosure device
> > > [    3.961910] videodev: Linux video capture interface: v2.00
> > > [    3.968463] [drm] Initialized i915 1.6.0 20191101 for 0000:00:02.0 on minor 0
> > > [    3.986469] fbcon: i915drmfb (fb0) is primary device
> > > [    4.069477] Console: switching to colour frame buffer device 240x67
> > > [    4.088387] i915 0000:00:02.0: fb0: i915drmfb frame buffer device
> > > [    4.188269] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
> > > [    4.198082] uvcvideo: Found UVC 1.00 device Chicony USB2.0 Camera (04f2:b649)
> > > [    4.205010] uvcvideo 1-7:1.0: Entity type for entity Extension 3 was not initialized!
> > > [    4.205013] uvcvideo 1-7:1.0: Entity type for entity Processing 2 was not initialized!
> > > [    4.205014] uvcvideo 1-7:1.0: Entity type for entity Camera 1 was not initialized!
> > > [    4.205069] input: Chicony USB2.0 Camera: Chicony  as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/input/input12
> > > [    4.205122] usbcore: registered new interface driver uvcvideo
> > > [    4.205123] USB Video Class driver (1.1.1)
> > > [    4.206547] dw-apb-uart.1: ttyS4 at MMIO 0xfe032000 (irq = 34, base_baud = 115200) is a 16550A
> > > [    4.333762] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC293: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
> > > [    4.333764] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> > > [    4.333765] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
> > > [    4.333766] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
> > > [    4.333767] snd_hda_codec_realtek hdaudioC0D0:    inputs:
> > > [    4.333768] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
> > > [    4.333769] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
> > > [    4.339298] intel_rapl_common: Found RAPL domain package
> > > [    4.339301] intel_rapl_common: Found RAPL domain core
> > > [    4.339302] intel_rapl_common: Found RAPL domain uncore
> > > [    4.339303] intel_rapl_common: Found RAPL domain dram
> > > [    4.561350] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
> > > [    4.561382] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
> > > [    4.561420] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
> > > [    4.561451] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
> > > [    4.561480] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
> > > [    4.561507] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input18
> > > [    4.561533] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input19
> > > [    4.826744] psmouse serio2: synaptics: queried max coordinates: x [..5718], y [..4908]
> > > [    4.871101] iwlwifi 0000:00:14.3: Collecting data: trigger 15 fired.
> > > [    4.871194] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
> > > [    4.871219] iwlwifi 0000:00:14.3: Status: 0x00000000, count: 64440511
> > > [    4.871241] iwlwifi 0000:00:14.3: Loaded firmware version: 48.4fa0041f.0
> > > [    4.871264] iwlwifi 0000:00:14.3: 0xBC0C8B90 | ADVANCED_SYSASSERT          
> > > [    4.871287] iwlwifi 0000:00:14.3: 0x8BB5013B | trm_hw_status0
> > > [    4.871307] iwlwifi 0000:00:14.3: 0x3782DEDA | trm_hw_status1
> > > [    4.871326] iwlwifi 0000:00:14.3: 0xB2693FEE | branchlink2
> > > [    4.871345] iwlwifi 0000:00:14.3: 0xF2827B49 | interruptlink1
> > > [    4.871365] iwlwifi 0000:00:14.3: 0x847E55B8 | interruptlink2
> > > [    4.871385] iwlwifi 0000:00:14.3: 0x7D9EFB86 | data1
> > > [    4.871402] iwlwifi 0000:00:14.3: 0xCA6DF7D7 | data2
> > > [    4.871419] iwlwifi 0000:00:14.3: 0xBBA4E8FF | data3
> > > [    4.871442] iwlwifi 0000:00:14.3: 0x05D7D912 | beacon time
> > > [    4.871461] iwlwifi 0000:00:14.3: 0x3E988BC8 | tsf low
> > > [    4.871479] iwlwifi 0000:00:14.3: 0xFBF4CBDD | tsf hi
> > > [    4.871496] iwlwifi 0000:00:14.3: 0xA77169BD | time gp1
> > > [    4.871514] iwlwifi 0000:00:14.3: 0xFB901860 | time gp2
> > > [    4.871532] iwlwifi 0000:00:14.3: 0x5CFCAA70 | uCode revision type
> > > [    4.871553] iwlwifi 0000:00:14.3: 0x5F085914 | uCode version major
> > > [    4.871574] iwlwifi 0000:00:14.3: 0x795F9B7B | uCode version minor
> > > [    4.871600] iwlwifi 0000:00:14.3: 0x2C781766 | hw version
> > > [    4.871619] iwlwifi 0000:00:14.3: 0xBDB0CB0F | board version
> > > [    4.871638] iwlwifi 0000:00:14.3: 0xFF00CCF1 | hcmd
> > > [    4.871655] iwlwifi 0000:00:14.3: 0x2C71EBDF | isr0
> > > [    4.871672] iwlwifi 0000:00:14.3: 0x7EBED69F | isr1
> > > [    4.871689] iwlwifi 0000:00:14.3: 0x0A4A0EC2 | isr2
> > > [    4.871706] iwlwifi 0000:00:14.3: 0x9527018B | isr3
> > > [    4.871723] iwlwifi 0000:00:14.3: 0xA9AE681D | isr4
> > > [    4.871740] iwlwifi 0000:00:14.3: 0x7DC4F7F4 | last cmd Id
> > > [    4.871759] iwlwifi 0000:00:14.3: 0x9AE7B6DC | wait_event
> > > [    4.871778] iwlwifi 0000:00:14.3: 0x6F3E8495 | l2p_control
> > > [    4.871797] iwlwifi 0000:00:14.3: 0x6FA4177E | l2p_duration
> > > [    4.871816] iwlwifi 0000:00:14.3: 0x9FAC4C30 | l2p_mhvalid
> > > [    4.871835] iwlwifi 0000:00:14.3: 0xF785BA8D | l2p_addr_match
> > > [    4.871854] iwlwifi 0000:00:14.3: 0xDA555345 | lmpm_pmg_sel
> > > [    4.871874] iwlwifi 0000:00:14.3: 0xED6318B4 | timestamp
> > > [    4.871892] iwlwifi 0000:00:14.3: 0x1AF65EBE | flow_handler
> > > [    4.871965] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
> > > [    4.871984] iwlwifi 0000:00:14.3: Status: 0x00000000, count: 7
> > > [    4.872004] iwlwifi 0000:00:14.3: 0x201013F1 | ADVANCED_SYSASSERT
> > > [    4.872025] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
> > > [    4.872045] iwlwifi 0000:00:14.3: 0xC008CF5C | umac branchlink2
> > > [    4.872065] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink1
> > > [    4.872091] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
> > > [    4.872112] iwlwifi 0000:00:14.3: 0x00000003 | umac data1
> > > [    4.872131] iwlwifi 0000:00:14.3: 0x20000302 | umac data2
> > > [    4.872149] iwlwifi 0000:00:14.3: 0x01300202 | umac data3
> > > [    4.872168] iwlwifi 0000:00:14.3: 0x00000030 | umac major
> > > [    4.872187] iwlwifi 0000:00:14.3: 0x4FA0041F | umac minor
> > > [    4.872205] iwlwifi 0000:00:14.3: 0x00005D02 | frame pointer
> > > [    4.872225] iwlwifi 0000:00:14.3: 0xC0887F58 | stack pointer
> > > [    4.872244] iwlwifi 0000:00:14.3: 0x00000000 | last host cmd
> > > [    4.872263] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
> > > [    4.872298] iwlwifi 0000:00:14.3: Fseq Registers:
> > > [    4.872325] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_ERROR_CODE
> > > [    4.872356] iwlwifi 0000:00:14.3: 0x00000000 | FSEQ_TOP_INIT_VERSION
> > > [    4.872919] iwlwifi 0000:00:14.3: 0xD744ED07 | FSEQ_CNVIO_INIT_VERSION
> > > [    4.873477] iwlwifi 0000:00:14.3: 0x0000A384 | FSEQ_OTP_VERSION
> > > [    4.874033] iwlwifi 0000:00:14.3: 0xAAD04292 | FSEQ_TOP_CONTENT_VERSION
> > > [    4.874602] iwlwifi 0000:00:14.3: 0xF5842307 | FSEQ_ALIVE_TOKEN
> > > [    4.875174] iwlwifi 0000:00:14.3: 0x1D7BFF8E | FSEQ_CNVI_ID
> > > [    4.875755] iwlwifi 0000:00:14.3: 0x8141BAF3 | FSEQ_CNVR_ID
> > > [    4.876333] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
> > > [    4.876889] iwlwifi 0000:00:14.3: 0x01300202 | CNVR_AUX_MISC_CHIP
> > > [    4.877429] iwlwifi 0000:00:14.3: 0x0000485B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
> > > [    4.877986] iwlwifi 0000:00:14.3: 0xA5A5A5A2 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
> > > [    4.878588] iwlwifi 0000:00:14.3: SecBoot CPU1 Status: 0x5c72, CPU2 Status: 0x3
> > > [    4.879130] iwlwifi 0000:00:14.3: Failed to start RT ucode: -110
> > > [    4.879672] iwlwifi 0000:00:14.3: Firmware not running - cannot dump error
> > > [    4.892174] iwlwifi 0000:00:14.3: Failed to run INIT ucode: -110
> > > [    4.947713] psmouse serio2: synaptics: queried min coordinates: x [1238..], y [956..]
> > > [    4.947716] psmouse serio2: synaptics: Trying to set up SMBus access
> > > [    5.036141] psmouse serio2: synaptics: SMbus companion is not ready yet
> > > [    5.099898] psmouse serio2: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1, caps: 0xf00223/0x840300/0x26800/0x0, board id: 3175, fw id: 2330500
> > > [    5.141823] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio2/input/input11
> > > [    5.242101] Adding 4194300k swap on /dev/sdb3.  Priority:-2 extents:1 across:4194300k SSFS
> > > [    5.324710] Bluetooth: hci0: Waiting for firmware download to complete
> > > [    5.325071] Bluetooth: hci0: Firmware loaded in 1579102 usecs
> > > [    5.325093] Bluetooth: hci0: Waiting for device to boot
> > > [    5.341145] Bluetooth: hci0: Device booted in 15659 usecs
> > > [    5.351285] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-19-0-1.ddc
> > > [    5.366164] Bluetooth: hci0: Applying Intel DDC parameters completed
> > > [    5.368204] Bluetooth: hci0: Firmware revision 0.0 build 62 week 31 2019
> > > [    5.503158] audit: type=1400 audit(1575836979.579:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-senddoc" pid=956 comm="apparmor_parser"
> > > [    5.505512] audit: type=1400 audit(1575836979.579:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-xpdfimport" pid=958 comm="apparmor_parser"
> > > [    5.538210] audit: type=1400 audit(1575836979.615:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-oopslash" pid=953 comm="apparmor_parser"
> > > [    5.548369] audit: type=1400 audit(1575836979.623:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=951 comm="apparmor_parser"
> > > [    5.549215] audit: type=1400 audit(1575836979.623:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=951 comm="apparmor_parser"
> > > [    5.550491] audit: type=1400 audit(1575836979.627:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=951 comm="apparmor_parser"
> > > [    5.607915] audit: type=1400 audit(1575836979.683:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/ippusbxd" pid=967 comm="apparmor_parser"
> > > [    5.655897] audit: type=1400 audit(1575836979.731:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/cups-browsed" pid=961 comm="apparmor_parser"
> > > [    5.707706] audit: type=1400 audit(1575836979.783:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/tcpdump" pid=971 comm="apparmor_parser"
> > > [    5.736079] audit: type=1400 audit(1575836979.811:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/sbin/dhclient" pid=965 comm="apparmor_parser"
> > > [    7.527204] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> > > [    7.527205] Bluetooth: BNEP filters: protocol multicast
> > > [    7.527209] Bluetooth: BNEP socket layer initialized
> > > [    7.619467] Generic FE-GE Realtek PHY r8169-2601:00: attached PHY driver [Generic FE-GE Realtek PHY] (mii_bus:phy_addr=r8169-2601:00, irq=IGNORE)
> > > [    7.746296] r8169 0000:26:00.1 enp38s0f1: Link is Down
> > > [   10.763645] r8169 0000:26:00.1 enp38s0f1: Link is Up - 1Gbps/Full - flow control rx/tx
> > > [   10.763655] IPv6: ADDRCONF(NETDEV_CHANGE): enp38s0f1: link becomes ready
> > > [   17.297381] broken atomic modeset userspace detected, disabling atomic
> > > [   18.387578] Bluetooth: RFCOMM TTY layer initialized
> > > [   18.387585] Bluetooth: RFCOMM socket layer initialized
> > > [   18.387593] Bluetooth: RFCOMM ver 1.11
> > > [   19.106240] rfkill: input handler disabled
> > > [   20.517546] EXT4-fs (sdc6): mounted filesystem with ordered data mode. Opts: (null)
> > > [   20.540132] EXT4-fs (sdc4): mounted filesystem with ordered data mode. Opts: (null)
> > > [   20.543050] EXT4-fs (sdc3): mounted filesystem with ordered data mode. Opts: (null)
> 
