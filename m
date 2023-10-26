Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D687D7A36
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 03:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjJZBff (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 21:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJZBfe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 21:35:34 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D952A3
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 18:35:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso342326b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 18:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698284131; x=1698888931; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtxBFwLBF7za+nT95yQRjeeCz5xZOSDivFlhlka7bx8=;
        b=VG1JwZ5k/gm5gOnNTo5x+ol9XF01oLfoLIjY2BoXsEGB4js9VC9eKCKTK80exLb2Av
         mhgkHRQiYmwksUt97aeTfekl8ua6J3l8hi0yJ5/orGXmzASUuwuLwvxVkP+BY+fFiYsM
         L3bCmBHb1RcuTM0eiiLrwV2uriEAv0bGJ4vADkA1Aametjt4r8WZrT2aO0/YpKLi7wJ3
         4xGXs6LelDXBY1nEiAnQ60CmaLHGZSzDcUcNC4+fqL0a7udjPi30LR+agebWFJp5E4gB
         DP0iVrwfdhwxO8b4EjISjYHE8Cl4QgRomFrpjydFJWLfi+LCP0FqzK+n5GW6T3qmvuxJ
         KLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698284131; x=1698888931;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtxBFwLBF7za+nT95yQRjeeCz5xZOSDivFlhlka7bx8=;
        b=CvQhUt4QcKVXB0Mg+gJ1GFwXGpkF0R/u2vqJP5HPGDI3JGXZc0GYfl73z79JuxkPQy
         aIOTfbbA2BNcx12abPvsSS0gGC+P6VBAX2vuQYUNvX8ddarilUeygXiMaQA3URATIM6u
         c34PDaBaAbgMU5UM+GAwcP+Py4hPeYZreobdVXm6NYOm4CJeMDocIXqLMRWExHJaAGlc
         ULyizh9wtQFVG7ya9goZoZmMZYeLcjoVL/wWAS+2AQiCs+WQChMO81jSiKhIeCN36Fyy
         ZqGn105T4+l3xsZsIIq1h1GfMcS/DLTnDNekwetzdj1m8P9lNwswTyWieasTJ1gQtc7E
         vRsQ==
X-Gm-Message-State: AOJu0YzvhXl5FT9QHLHUsqHLbK0L1eJ5ZWvFweD3pkYjsQGQaBx8Cou7
        fvzCPrZ7egOrtyMTsVz3h9U=
X-Google-Smtp-Source: AGHT+IGvV0CAMC3/cWVT0zwZOt/u7Y3aTd6YcOCTEWmr6oA3CrjRzu+y6GnNVzKRbXk2yZ4XvSUM0g==
X-Received: by 2002:a05:6a21:6d94:b0:157:1b5:61ce with SMTP id wl20-20020a056a216d9400b0015701b561cemr8310369pzb.4.1698284131011;
        Wed, 25 Oct 2023 18:35:31 -0700 (PDT)
Received: from localhost ([103.40.76.4])
        by smtp.gmail.com with ESMTPSA id a13-20020a63e40d000000b0059d219cb359sm9483565pgi.9.2023.10.25.18.35.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Oct 2023 18:35:30 -0700 (PDT)
Date:   Thu, 26 Oct 2023 09:35:28 +0800
From:   Jiazi Li <jqqlijiazi@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jiazi Li <jiazi.li@transsion.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: cfg80211: fix bss rbn double erase issue
Message-ID: <20231026013528.GA24122@Jiazi.Li>
References: <20231025103304.22082-1-jiazi.li@transsion.com>
 <b1358d256500d5bb6b3bbc312673c24b54b3674e.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1358d256500d5bb6b3bbc312673c24b54b3674e.camel@sipsolutions.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 25, 2023 at 12:36:24PM +0200, Johannes Berg wrote:
> Huh.
> 
> On Wed, 2023-10-25 at 18:33 +0800, Jiazi Li wrote:
> > If cfg80211_update_assoc_bss_entry call rb_insert_bss re-insert bss
> > failed because cmp_bss return 0,
> > 
> 
> Ok that's bad - so you hit the WARN_ON there? How that? We should fix
> that too?
> 
Yes, hit this WARN_ON in the test of direct connection between mobile
phones and PC. Here is the log:
[ 2741.982362] -----------[ cut here ]-----------
[ 2741.982446] WARNING: CPU: 6 PID: 2175 at net/wireless/scan.c:1496 cfg80211_update_assoc_bss_entry+0x350/0x378 [cfg80211]
[ 2741.983274] Call trace:
[ 2741.983343] cfg80211_update_assoc_bss_entry+0x350/0x378 [cfg80211]
[ 2741.983413] cfg80211_ch_switch_notify+0x7c/0x1b4 [cfg80211]
[ 2741.983487] kalP2pIndicateChnlSwitch+0x520/0xa34 [wlan_drv_gen4m_6895]
[ 2741.983558] p2pRoleFsmRunEventChnlGrant+0x358/0x5c0 [wlan_drv_gen4m_6895]
[ 2741.983629] p2pFsmRunEventChGrant+0x12c/0x16c [wlan_drv_gen4m_6895]
[ 2741.983699] mboxRcvAllMsg+0x198/0x23c [wlan_drv_gen4m_6895]
[ 2741.983770] kalProcessTxReq+0x50/0x340 [wlan_drv_gen4m_6895]
[ 2741.983840] main_thread+0x410/0x1730 [wlan_drv_gen4m_6895]
[ 2741.983846] kthread+0x150/0x200
[ 2741.983849] ret_from_fork+0x10/0x30
I don't know why this is happening yet.
> > this bss->rbn will continue to hold
> > expired data, such as __rd_parent_color.
> 
> Does that matter in any way?
> 
It caused a null pointer issue in rb_erase:
[ 2781.560091][T502248] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[ 2781.560115][T502248] Mem abort info:
[ 2781.560128][T502248]   ESR = 0x96000005
[ 2781.560143][T502248]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 2781.560156][T502248]   SET = 0, FnV = 0
[ 2781.560168][T502248]   EA = 0, S1PTW = 0
[ 2781.560178][T502248] Data abort info:
[ 2781.560187][T502248]   ISV = 0, ISS = 0x00000005
[ 2781.560196][T502248]   CM = 0, WnR = 0
[ 2781.560207][T502248] user pgtable: 4k pages, 39-bit VAs, pgdp=00000001cb653000
[ 2781.560216][T502248] [0000000000000000] pgd=0000000000000000
[ 2781.560222][T502248] , p4d=0000000000000000
[ 2781.560230][T502248] , pud=0000000000000000
[ 2781.560238][T502248]
[ 2781.560254][T502248] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[ 2781.568590][ T2176] [wlan][2176]halSetFWOwn:(INIT INFO) FW OWN:1, IntSta:0x08000000
[ 2781.591991][T502248] Kernel Offset: 0x22e2600000 from 0xffffffc008000000
[ 2781.591998][T502248] PHYS_OFFSET: 0x40000000
[ 2781.592002][T502248] pstate: 60400005 (nZCv daif +PAN -UAO)
[ 2781.592010][T502248] pc : [0xffffffe2eb0698e4] rb_erase+0x1c8/0x354
[ 2781.592123][T502248] lr : [0xffffffe2edef93b4] __cfg80211_unlink_bss+0xac/0x1a0 [cfg80211]
[ 2781.592127][T502248] sp : ffffffc02ce43720
[ 2781.592130][T502248] x29: ffffffc02ce43720 x28: 0000000000000014
[ 2781.592133][T502248] x27: ffffff812e343e00 x26: 0000000000000000
[ 2781.592135][T502248] x25: ffffff81cb89c100 x24: fffffffefff6a5f0
[ 2781.592138][T502248] x23: ffffff80f58b0000 x22: 0000000000000001
[ 2781.592140][T502248] x21: ffffff809fbe8da0 x20: ffffff80f58b0000
[ 2781.592143][T502248] x19: ffffff809fbe8d00 x18: ffffffc02c4a7080
[ 2781.592146][T502248] x17: 000000000000012b x16: 0000000000000000
[ 2781.592148][T502248] x15: 000000000000001f x14: ffffff81b372c628
[ 2781.592151][T502248] x13: ffffff80c3298b28 x12: 0000000000000000
[ 2781.592154][T502248] x11: 0000000000000000 x10: ffffff80c3298b20
[ 2781.592156][T502248] x9 : 0000000000000000 x8 : ffffff80c3298b20
[ 2781.592159][T502248] x7 : 000000000000012a x6 : ffffff818755a000
[ 2781.592161][T502248] x5 : 000000008020001c x4 : ffffffff02541020
[ 2781.592164][T502248] x3 : 000000008020001c x2 : ffffff809fbe8da0
[ 2781.592166][T502248] x1 : ffffff80f58b00e8 x0 : ffffff809fbe8d20
[ 2781.592649][T502248] CPU: 5 PID: 2248 Comm: wpa_supplicant Tainted: P        W  O      5.10.177-android12-9-00002-g593c61caffd9-ab10731447 #1
[ 2781.592652][T502248] Hardware name: MT6896 (DT)
[ 2781.592656][T502248] Call trace:
[ 2781.592665][T502248]  dump_backtrace.cfi_jt+0x0/0x8
[ 2781.592669][T502248]  dump_stack_lvl+0xdc/0x138
[ 2781.592672][T502248]  dump_stack+0x1c/0x2c
[ 2781.592698][T502248]  mrdump_common_die+0x3a8/0x544 [mrdump]
[ 2781.592710][T502248]  ipanic_die+0x24/0x38 [mrdump]
[ 2781.592717][T502248]  die+0x358/0x680
[ 2781.592723][T502248]  die_kernel_fault+0x84/0x94
[ 2781.592726][T502248]  __do_kernel_fault+0x240/0x28c
[ 2781.592735][T502248]  do_page_fault+0xb4/0x770
[ 2781.592738][T502248]  do_translation_fault+0x48/0x64
[ 2781.592741][T502248]  do_mem_abort+0x6c/0x164
[ 2781.592745][T502248]  el1_abort+0x44/0x68
[ 2781.592748][T502248]  el1_sync_handler+0x58/0x88
[ 2781.592751][T502248]  el1_sync+0x8c/0x140
[ 2781.592754][T502248]  rb_erase+0x1c8/0x354
[ 2781.592838][T502248]  nl80211_dump_scan+0x564/0x634 [cfg80211]
[ 2781.592845][T502248]  netlink_dump+0x1b0/0x414
[ 2781.592848][T502248]  __netlink_dump_start+0x224/0x478
[ 2781.592852][T502248]  genl_rcv_msg+0x434/0x5c0
[ 2781.592855][T502248]  netlink_rcv_skb+0xf0/0x170
[ 2781.592858][T502248]  genl_rcv+0x3c/0x58
[ 2781.592861][T502248]  netlink_unicast_kernel+0xb8/0x248
[ 2781.592864][T502248]  netlink_unicast+0x18c/0x2fc
[ 2781.592867][T502248]  netlink_sendmsg+0x4c8/0x6f8
[ 2781.592873][T502248]  ____sys_sendmsg+0x240/0x3cc
[ 2781.592876][T502248]  __sys_sendmsg+0x21c/0x320
[ 2781.592880][T502248]  __arm64_sys_sendmsg+0x28/0x38
[ 2781.592886][T502248]  el0_svc_common+0xd4/0x270
[ 2781.592890][T502248]  el0_svc+0x28/0x98
[ 2781.592893][T502248]  el0_sync_handler+0x8c/0xf0
[ 2781.592896][T502248]  el0_sync+0x1b4/0x1c0
The one currently eraseing is the bss re-insert failed earlier.
The status of this bss is as follows after re-insert fail:
1. color is black
2. no child
After 40s, nl80211_dump_scan want to erase this bss, because it's
color is black, need rebalance, but it's parent(from expired
__rb_parent_color) now doesn't have any children, so we encountered a
null pointer issue in ____rb_erase_color.
> > And this bss still in rdev->bss_list, maybe double erase in
> > __cfg80211_bss_expire later.
> > Double erase a rbtree node(with expired parent and color data) maybe
> > corrupt rbtree, so add a in_rbtree flag to fix this issue.
> 
> This seems overly complex - couldn't we just remove it from the list too
> or something? It's already a case that "should never happen" so ... not
> sure we need to do something "good"?
> 
Will remove it from list when re-insert fail cause confusion in it's
refcount? Which could lead to leakage or use-after-free?
> johannes
> 
