Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86725E67F3
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 18:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiIVQAc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 12:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiIVQAb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 12:00:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A9CA99F7
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 09:00:29 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id b21so9188253plz.7
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=e+3VYhs+DuwH7bu+QHtV1rjWq3mJNnHisCvMMFS3bAw=;
        b=XxhEWZKeaIg8g+YPuHc57mvNIPPhpigg738nM9wsLJjiUYpKwjJNzBKKGjefZOhAzi
         0KqHQ1P/cHiMmQgsO3z2jt2+D0oCcG8Ck+pj5sopXZOTE33QKhSQ8Lb6DWDYvG77ZJIc
         GQLx6jVnYAJuMY3HV3uGUN51p3PNgpWkx9A1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=e+3VYhs+DuwH7bu+QHtV1rjWq3mJNnHisCvMMFS3bAw=;
        b=7VoTCbGpJ+ividgij733qkO031mTBpinS9cFMQAd/DZfjfx3gchoL12skujbEgGRwF
         AurQ1Fqi1vSMFo5vjOGj8pEnmBM7HCIIaMnrfgpbpPgQ6ACASdsPKPFXk56x5Ib71Dak
         bzllAlankY3nHP8zicriLZ55KUfs1erRdoHu4O/dWUGzH42/yeQZrvgeKf5qgBC5d0MF
         yP/plEUSzYUjMdvUKexUsXpxlix6d7T/vCzY12kXkOxsuVioohR2bwRswQxN2oYbmeUi
         G/hywZ1gJtKkiTn3t+GB3D3bTbEX5Wy9CeDgC7SVbvPr/U43ARsZ/I37bRdn0n18cvhH
         tGEA==
X-Gm-Message-State: ACrzQf0fD4GZhfDa+AILl3cB3q2PBbh00jDw4y4CUybV8gPygpXAk4Zh
        ILZA5iWIF/oUNEeQymek8bfoSA==
X-Google-Smtp-Source: AMsMyM6q4mhFYq39gGoVyx6Hnh47y8QFV1PKitfWXVTUQGpGwPy/JbIncPBlq3WqciXD78b9y3HP3A==
X-Received: by 2002:a17:90b:164d:b0:202:69b3:1002 with SMTP id il13-20020a17090b164d00b0020269b31002mr4362502pjb.86.1663862428935;
        Thu, 22 Sep 2022 09:00:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ms3-20020a17090b234300b002005c3d4d4fsm4007085pjb.19.2022.09.22.09.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 09:00:28 -0700 (PDT)
Date:   Thu, 22 Sep 2022 09:00:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "dev@openvswitch.org" <dev@openvswitch.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        David Rientjes <rientjes@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, Yonghong Song <yhs@fb.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Pekka Enberg <penberg@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 07/12] igb: Proactively round up to kmalloc bucket size
Message-ID: <202209220859.DA21F91EAE@keescook>
References: <20220922031013.2150682-1-keescook@chromium.org>
 <20220922031013.2150682-8-keescook@chromium.org>
 <DM5PR11MB13241226F3AACC81398F7E8EC14E9@DM5PR11MB1324.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR11MB13241226F3AACC81398F7E8EC14E9@DM5PR11MB1324.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Sep 22, 2022 at 03:56:54PM +0000, Ruhl, Michael J wrote:
> >From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of Kees Cook
> [...]
> >diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> >b/drivers/net/ethernet/intel/igb/igb_main.c
> >index 2796e81d2726..4d70ee5b0f79 100644
> >--- a/drivers/net/ethernet/intel/igb/igb_main.c
> >+++ b/drivers/net/ethernet/intel/igb/igb_main.c
> >@@ -1196,6 +1196,7 @@ static int igb_alloc_q_vector(struct igb_adapter
> >*adapter,
> >
> > 	ring_count = txr_count + rxr_count;
> > 	size = struct_size(q_vector, ring, ring_count);
> >+	size = kmalloc_size_roundup(size);
> 
> why not:
> 
> 	size = kmalloc_size_roundup(struct_size(q_vector, ring, ring_count));
> 
> ?

Sure! I though it might be more readable split up. I will change it. :)

-- 
Kees Cook
