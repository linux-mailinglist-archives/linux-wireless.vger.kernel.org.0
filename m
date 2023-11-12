Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C7B7E8FB1
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Nov 2023 13:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjKLMAi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Nov 2023 07:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLMAh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Nov 2023 07:00:37 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0EC2702
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 04:00:34 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50a71aac023so2686285e87.3
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 04:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscv-rocks.de; s=google; t=1699790432; x=1700395232; darn=vger.kernel.org;
        h=organization:user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:mail-followup-to
         :reply-to:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4YO7pahHy8z/ml7CGvEAQ/lL1P7lJl1yWl36X5gqcs=;
        b=ONvY01TRNtja4KCgRqVhdXM9hCIDfWeSfB8aiAg5knopil05nKdyfVFSAuPJLDzN3L
         uBPGqQY7K7Do9HPi7fhTFKs8eWSJ/hfvNZIXajLUTljl89x0QMg/Ad5e6rNf8JHVXtfw
         u22BXrAB5fKMgpL7i/p93Ya257DPntKkNF99aY0TCoixpIoxRLvJx3w+E2PPIYEplACH
         i/YsEIBhJHoeaArBlQ6zEluC6BDi++MncAlOIBtgLvpLyMjAAAk+EVlvZQQDzDaa6IO7
         RV8BjHi4gxwTlVGGVIDC+iWTGGM6C51B25tgISy6DpQRLEBFSZGSKWEIAmXUCUrgC7bt
         qWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699790432; x=1700395232;
        h=organization:user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:mail-followup-to
         :reply-to:message-id:subject:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B4YO7pahHy8z/ml7CGvEAQ/lL1P7lJl1yWl36X5gqcs=;
        b=lqCmVaBPeQ5eOVbl6+RwZTT+Yhrr/Xn+G5iDP6kLqU14wG0uA5n31fY5u95M8eyvgG
         DU5XmxRpCha9SEiNOv6mMNocA+NWfA/Lw9d1mRymjVWEE5wVkC6FAoDndaM7ktswhctx
         ez8LAgJi3Fcg8cQHCn3KDMI2cEOYq/RETlxhDWxy0NZnQRh0hv4sS6BEC3dyiLqVhoVS
         R10Y84Fqn/izd7yKoZz266VWvMYzqUtrsYWitZmqx76rbZCk/uE1NKaPzZlzLwuU8pKz
         qY6H/Q/FXsbdudJ8lBJ+GDGCmSpwd3hnuJns5FX/LapbE1iEsdXcR+LUOvcORd+2vl52
         7OQQ==
X-Gm-Message-State: AOJu0YyUcw42wr0JQHWb4O3Z6J+FRtCPNbKAhOiWhZOeonpEBgnLKVHM
        4DthxK+Lbf2N8vY0ScGyaX+Y9Q==
X-Google-Smtp-Source: AGHT+IGUmf8yafIlZ/up8+SrD0RozWcyJOEJP9U0XPpAluBt0s/h9Kv7HC4MlHmGQUv41RXsRzjZmg==
X-Received: by 2002:a05:6512:12c4:b0:507:cd39:a005 with SMTP id p4-20020a05651212c400b00507cd39a005mr2881053lfg.39.1699790431860;
        Sun, 12 Nov 2023 04:00:31 -0800 (PST)
Received: from fedora.fritz.box (p5494469c.dip0.t-ipconnect.de. [84.148.70.156])
        by smtp.gmail.com with ESMTPSA id b30-20020a509f21000000b0053d9f427a6bsm2274543edf.71.2023.11.12.04.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 04:00:31 -0800 (PST)
Date:   Sun, 12 Nov 2023 13:00:29 +0100
From:   Damian Tometzki <damian@riscv-rocks.de>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        =?utf-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= 
        <pinkflames.linux@gmail.com>,
        Fabio Comolli <fabio.comolli@gmail.com>,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: Fwd: iwlmvm: Linux 6.7 pre-rc1 prints stack trace of
 iwl_op_mode_mvm_start; caused by commit b6e3d1ba4fcf
Message-ID: <ZVC-XW0Yf4kNL05y@fedora.fritz.box>
Reply-To: Damian Tometzki <damian@riscv-rocks.de>
Mail-Followup-To: Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        =?utf-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= <pinkflames.linux@gmail.com>,
        Fabio Comolli <fabio.comolli@gmail.com>,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
References: <2fa930bb-54dd-4942-a88d-05a47c8e9731@gmail.com>
 <ZVC0iq1FS02FjeTX@archie.me>
 <ZVC8RbKEmulf2MsD@fedora.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZVC8RbKEmulf2MsD@fedora.fritz.box>
User-Agent: Mutt
X-Operating-System: Linux Fedora release 39 (Thirty Nine) (Kernel 6.6.0)
Organization: Linux hacker
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 12. Nov 12:51, Damian Tometzki wrote:
> On Sun, 12. Nov 18:18, Bagas Sanjaya wrote:
> > Hi Niklāvs and Fabio,
> > 
> > On Fri, Nov 03, 2023 at 08:13:39PM +0700, Bagas Sanjaya wrote:
> > > Hi,
> > > 
> > > I notice a regression report on Bugzilla [1]. Quoting from it:
> > > 
> > > > When testing the branch that will become Linux 6.7-rc1, ever since commit b6e3d1ba4fcf02176846d03a930203d8133c0aaf I have observed the following abbreviated kernel stack trace (please see attachments for the full trace):
> > > > 
> > > > ```
> > > > [    6.733281]  ? __warn+0xc3/0x1d0
> > > > [    6.733284]  ? iwl_op_mode_mvm_start+0x9c4/0x9d0 [iwlmvm]
> > > > [    6.733299]  ? report_bug+0x167/0x220
> > > > [    6.733301]  ? handle_bug+0x3d/0x90
> > > > [    6.733304]  ? exc_invalid_op+0x1a/0x60
> > > > [    6.733306]  ? asm_exc_invalid_op+0x1a/0x20
> > > > [    6.733309]  ? iwl_op_mode_mvm_start+0x9c4/0x9d0 [iwlmvm]
> > > > [    6.733325]  _iwl_op_mode_start+0x66/0xe0 [iwlwifi]
> > > > [    6.733338]  iwl_opmode_register+0x87/0xd0 [iwlwifi]
> > > > [    6.733350]  ? __cfi_init_module+0x10/0x10 [iwlmvm]
> > > > [    6.733364]  init_module+0x22/0xff0 [iwlmvm]
> > > > [    6.733378]  ? __cfi_init_module+0x10/0x10 [iwlmvm]
> > > > [    6.733392]  do_one_initcall+0x129/0x380
> > > > [    6.733395]  ? idr_alloc_cyclic+0x148/0x1e0
> > > > [    6.733397]  ? security_kernfs_init_security+0x41/0x80
> > > > [    6.733399]  ? __kernfs_new_node+0x1be/0x250
> > > > [    6.733401]  ? preempt_count_add+0x55/0xb0
> > > > [    6.733404]  ? up_write+0x4a/0xe0
> > > > [    6.733406]  ? preempt_count_add+0x55/0xb0
> > > > [    6.733408]  ? sysvec_call_function+0xa4/0xb0
> > > > [    6.733410]  ? asm_sysvec_call_function+0x1a/0x20
> > > > [    6.733411]  ? free_unref_page_prepare+0xf3/0x410
> > > > [    6.733413]  ? preempt_count_add+0x62/0xb0
> > > > [    6.733415]  ? _raw_spin_trylock+0x19/0x60
> > > > [    6.733417]  ? _raw_spin_unlock+0x11/0x30
> > > > [    6.733419]  ? __kmem_cache_free+0x29a/0x3c0
> > > > [    6.733421]  ? vfree+0xd2/0x150
> > > > [    6.733422]  ? slab_post_alloc_hook+0x76/0x3d0
> > > > [    6.733425]  ? do_init_module+0x3f/0x230
> > > > [    6.733427]  ? __kmem_cache_alloc_node+0x1fe/0x2f0
> > > > [    6.733430]  do_init_module+0x7a/0x230
> > > > [    6.733432]  __se_sys_init_module+0x1a0/0x220
> > > > [    6.733435]  do_syscall_64+0x7a/0x100
> > > > [    6.733438]  ? syscall_exit_to_user_mode+0x2d/0x1d0
> > > > [    6.733440]  ? do_syscall_64+0x89/0x100
> > > > [    6.733442]  ? do_user_addr_fault+0x4e7/0x680
> > > > [    6.733444]  ? exc_page_fault+0x61/0x150
> > > > [    6.733446]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > > > ```
> > > > 
> > > > I did try reverting the offending commit but the result did not compile and I did not want to dig deeper to identify any subsequent commits what would need reverting to fix compilation.
> > > > 
> > > > If it's relevant, I'm building the kernel with Clang 17.0.4 toolchain by setting the LLVM=1 variable. CFI is enabled but I'm not sure if it's actually functional.
> > > 
> > > See Bugzilla for the full thread.
> > > 
> > > Anyway, I'm adding this regression to regzbot:
> > > 
> > > #regzbot introduced: b6e3d1ba4fcf02 https://bugzilla.kernel.org/show_bug.cgi?id=218095
> > > #regzbot title: new iwlwifi firmware statistics API triggers stack trace
> > > 
> > 
> > Emmanuel had sent a proposed fix at [1]. Please test.
> Hello together,
> 
> i tested this fix and the dump is gone. It works. 
It is tested with wi-fi
> 
> Tested-by: Damian Tometzki <damian@riscv-rocks.de>
> 
> Many thanks
> Damian
> > 
> > Thanks.
> > 
> > [1]: https://lore.kernel.org/regressions/20231112100944.21177-1-emmanuel.grumbach@intel.com/
> > 
> > -- 
> > An old man doll... just what I always wanted! - Clara
> 
> 
