Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2657E8281
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 20:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbjKJT2Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 14:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbjKJT2N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 14:28:13 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E7938E9C
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 06:25:43 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9d2d8343dc4so355389766b.0
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 06:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscv-rocks.de; s=google; t=1699626342; x=1700231142; darn=vger.kernel.org;
        h=organization:user-agent:in-reply-to:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XgnL7VlJtzOOrkSm/R98WrlaKMBqVaJEX9Xl8VhaNVw=;
        b=KZ9jDtyOKaUekN+nt0Uf8lTry5/cPiig6+Ew6D2oKGH169jOYLaA3hbHGIH8+7tEby
         RcSlvtMUY94D34scsYV4/Qw+oMddWqV+Wlr3jdG6jyXNKcE4TQ5FMPHjCIGOnjKR0zij
         TDnbfDffEiw2bEsI7EOtm09GaoB0nr3hLUJ3Nki/ihhaZGbnFgd2vly3jjiFWGFfZ9CF
         gXP1zKQ0O0Ul802qAfwCVvaFiLmopaX1njaFsaxCcOr9ZeLneHnNzinRqf6U+lfgpxdl
         NQLht5eiB9yVASnz4H6H0DXECOlIX8UIzraPfWME6iXXqqY77jg/QrqACqXgsDcPSWWh
         XB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699626342; x=1700231142;
        h=organization:user-agent:in-reply-to:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgnL7VlJtzOOrkSm/R98WrlaKMBqVaJEX9Xl8VhaNVw=;
        b=S536NwHplrmoMfYem3LelrDIopQMx13pnAert89R1kkmF+SQEeW3mY6BivIRtFIATB
         xfbae8hy32B/V1s0Y8lp90yrMFw1lMUFCcAzFCRcI4AuKv0NkefAHgwTwhcnHBUSuoK5
         n11Rnzj6qnYXTkrvUdiBFcfmCkbezvTEead6kgsR7KuNKFKX+AiS74ucGgrUDkruA+kl
         kuTNVIhMY+cywEIx5IalWeRH2OOHQYgjBQ5R3F/ZOfKK9DBREzbo3a6XpUC0j9poHQCg
         EuiibXTjKzRdjp1mrIdmNLorR4iefJ9CxG9Of7fywEBoY8eh6Y9NfgwlS/RUpiQjeUFG
         JuEg==
X-Gm-Message-State: AOJu0YzSXOPszlU3EIJmg+hwK32DJl8ziaYI37BxslrQfScMKdg+zxGO
        l2DyjKCc2OMr4mRkubY+s74ZikvBzrcgbGIlsP1H70/0
X-Google-Smtp-Source: AGHT+IF/7jBn/+3HaliKyAUk+2zBtFqwJNpWa1BL4PBoA7S8t54S5mH/so5Tk4ZiI5yM42nwsTpiOg==
X-Received: by 2002:a17:907:2cc6:b0:9da:ee00:a023 with SMTP id hg6-20020a1709072cc600b009daee00a023mr7327461ejc.30.1699626341817;
        Fri, 10 Nov 2023 06:25:41 -0800 (PST)
Received: from fedora.fritz.box (p5494469c.dip0.t-ipconnect.de. [84.148.70.156])
        by smtp.gmail.com with ESMTPSA id y4-20020a170906524400b009cc1e8ed7c5sm3985184ejm.133.2023.11.10.06.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 06:25:41 -0800 (PST)
Date:   Fri, 10 Nov 2023 15:25:39 +0100
From:   Damian Tometzki <damian@riscv-rocks.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     gregory.greenman@intel.com, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: Re: [PATCH 01/10] wifi: iwlwifi: mvm: implement new firmware API for
 statistics
Message-ID: <ZU49Y0Nhf5XVfxPm@fedora.fritz.box>
Reply-To: Damian Tometzki <damian@riscv-rocks.de>
References: <20231022145556.244202-1-gregory.greenman@intel.com>
 <20231022173519.8cc7df0ebff2.If1dcb57145841c5b3c68ed112bbfcd0201f7acc3@changeid>
 <20231103031705.GA947@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103031705.GA947@sol.localdomain>
User-Agent: Mutt
X-Operating-System: Linux Fedora release 39 (Thirty Nine) (Kernel 6.6.0)
Organization: Linux hacker
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 02. Nov 20:17, Eric Biggers wrote:
> Hi Gregory and Anjaneyulu,
> 
> On Sun, Oct 22, 2023 at 05:55:47PM +0300, gregory.greenman@intel.com wrote:
> > From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
> > 
> > The new firmware API uses a new command and notification,
> > the command configures in which statistics types driver is
> > interested and the notification is sent periodically.
> > An additional change in the API is that most of the statistics
> > data is accumulated and reported by the firmware per MLO link.
> > Implement new command and notification handlers and adjust to
> > per-link statistics.
> > 
> > Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
> > Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> 
> I'm seeing a warning at boot time due to this patch.  See below.  It's from
> 'WARN_ON(iwl_cmd_groups_verify_sorted(trans_cfg));'.  Looks like there's an
> array that is supposed to be sorted that isn't sorted anymore.
>
Hello together,

is there an update on this kernel dump below ?

Many Thanks for an update and a nice weekend

Damian

 
> [    5.342367] Intel(R) Wireless WiFi driver for Linux
> [    5.342405] iwlwifi 0000:04:00.0: enabling device (0000 -> 0002)
> [    5.342978] iwlwifi 0000:04:00.0: Detected crf-id 0xbadcafe, cnv-id 0x10 wfpm id 0x80000000
> [    5.342993] iwlwifi 0000:04:00.0: PCI dev 24fd/1010, rev=0x230, rfid=0xd55555d5
> [    5.343131] xhci_hcd 0000:01:00.0: xHCI Host Controller
> [    5.343137] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
> [    5.346469] iwlwifi 0000:04:00.0: loaded firmware version 36.ca7b901d.0 8265-36.ucode op_mode iwlmvm
> [    5.346502] ------------[ cut here ]------------
> [    5.346503] WARNING: CPU: 1 PID: 20 at drivers/net/wireless/intel/iwlwifi/mvm/../iwl-trans.h:1158 iwl_op_mode_mvm_start+0x995/0x9b0
> [    5.346511] CPU: 1 PID: 20 Comm: kworker/1:0 Not tainted 6.6.0-11999-gae7b1149d4fb #1
> [    5.346514] Hardware name: Gigabyte Technology Co., Ltd. X399 AORUS Gaming 7/X399 AORUS Gaming 7, BIOS F2 08/31/2017
> [    5.346516] Workqueue: events request_firmware_work_func
> [    5.346520] RIP: 0010:iwl_op_mode_mvm_start+0x995/0x9b0
> [    5.346524] Code: 41 5e 41 5f 5d e9 2b 4c 59 00 cc 48 c7 c7 10 58 a2 ba 48 c7 c6 8a 0c a3 ba e8 87 f1 57 00 e9 b6 fb ff ff 0f 0b e9 b2 fe ff ff <0f> 0b e9 aa fc ff ff e8 6f 96 58 00 66 66 66 66 66 66 2e 0f 1f 84
> [    5.346526] RSP: 0018:ffffa87d402e7bf8 EFLAGS: 00010286
> [    5.346529] RAX: 00000000ffffffff RBX: ffffa87d402e7c00 RCX: ffffffffba721630
> [    5.346531] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffffffffba721cc0
> [    5.346532] RBP: ffff8ba7c72e0028 R08: 0000000000000090 R09: 0000000000000070
> [    5.346534] R10: 0000000000000070 R11: 00000000000000ff R12: ffff8ba7c7241f88
> [    5.346536] R13: ffff8ba7c6fff814 R14: ffff8ba7c7241f80 R15: 0000000000000000
> [    5.346537] FS:  0000000000000000(0000) GS:ffff8baf1e840000(0000) knlGS:0000000000000000
> [    5.346540] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.346541] CR2: 0000000000000000 CR3: 0000000056228000 CR4: 00000000003506f0
> [    5.346543] Call Trace:
> [    5.346546]  <TASK>
> [    5.346548]  ? __warn+0xa7/0x140
> [    5.346551]  ? iwl_op_mode_mvm_start+0x995/0x9b0
> [    5.346554]  ? report_bug+0xe8/0x180
> [    5.346557]  ? handle_bug+0x3d/0x90
> [    5.346560]  ? exc_invalid_op+0x1a/0x60
> [    5.346562]  ? asm_exc_invalid_op+0x1a/0x20
> [    5.346566]  ? iwl_op_mode_mvm_start+0x995/0x9b0
> [    5.346568]  ? iwl_op_mode_mvm_start+0x63e/0x9b0
> [    5.346571]  _iwl_op_mode_start+0x4e/0xa0
> [    5.346575]  iwl_req_fw_callback+0x2501/0x2610
> [    5.346579]  ? srso_return_thunk+0x5/0x5f
> [    5.346582]  ? __switch_to+0x80/0x480
> [    5.346586]  request_firmware_work_func+0x62/0xa0
> [    5.346589]  process_scheduled_works+0x263/0x3d0
> [    5.346593]  worker_thread+0x222/0x300
> [    5.346595]  ? __cfi_worker_thread+0x10/0x10
> [    5.346598]  kthread+0xf4/0x110
> [    5.346602]  ? __cfi_kthread+0x10/0x10
> [    5.346604]  ret_from_fork+0x43/0x50
> [    5.346608]  ? __cfi_kthread+0x10/0x10
> [    5.346610]  ret_from_fork_asm+0x1b/0x30
> [    5.346614]  </TASK>
> [    5.346615] ---[ end trace 0000000000000000 ]---
> [    5.346617] iwlwifi 0000:04:00.0: Detected Intel(R) Dual Band Wireless AC 8265, REV=0x230
