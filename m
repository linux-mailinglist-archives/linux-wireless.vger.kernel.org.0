Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE8B5E5AA6
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 07:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiIVF0d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 01:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiIVF0b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 01:26:31 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715D4A1D28
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 22:26:29 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id l65so8175657pfl.8
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 22:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=1AAj0jz/3WOf/ZinmBg4e5WZyKIExnDIP+4ApRXDWXk=;
        b=E6vw8sjIHY/i68R43dGnMLa/5LLUaNZd7XsoFQWcc3w5wUJdtXNsxsEfsPht7kxdNG
         JJ1tXBTf3XQqnlgOex/RZ+o0XMhSMgfcjsVoIr6koV6H3KyiaZ1lUXPNyODzP4yferwZ
         bLRSqfuB8yrx2QNr5YGtL8EgG0hPZHJq7V7xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1AAj0jz/3WOf/ZinmBg4e5WZyKIExnDIP+4ApRXDWXk=;
        b=kjCEeWd7dFNtaeiuxM/AXCADcCHXz/EWKt3KICKyerzQFddOWpTCjEaYlR3jB2JAYk
         uduHtSEoE01wwR5B9JUTX062NGWnzWtaKlOqp6hJlG+uIMc6Q+SYawf2NgdwGdkp6mPZ
         ocZBCAhr5dG79SnH3K2pbA2uiW9ntjo3ofzwkhPz0OtxFV2avDO0Fc2kKN+meErxxBrY
         wLIV+mO7Z+QeEcb1DueCS+/rL8/q/4466nx/QKSDbSg3YNrjDNyOgYaOEh9WT0j+9G6h
         ufYrUMwkmeosb+baSPHymZkCHGRGedBqjLGU7U6RJZ93AVVDkf6PYBEuwrnO/2kFPgm2
         3n8Q==
X-Gm-Message-State: ACrzQf15aIbKa/xGwuVfh8IC/I1y1AxVggP1DUckyppIdkAR82oEgq9H
        ooU3Gq8dkyyiLKhfGTZAbpYWoQ==
X-Google-Smtp-Source: AMsMyM4a+GHcnQt0UeqKstHRefYZ2pfi5aegxBG+GRLeLtm77LwF22DDWI605QZJjTDKHxZFsdcd6w==
X-Received: by 2002:a63:cf56:0:b0:439:41ed:78fc with SMTP id b22-20020a63cf56000000b0043941ed78fcmr1597609pgj.419.1663824388949;
        Wed, 21 Sep 2022 22:26:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903120a00b0016f196209c9sm3102876plh.123.2022.09.21.22.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 22:26:28 -0700 (PDT)
Date:   Wed, 21 Sep 2022 22:26:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alex Elder <elder@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Yonghong Song <yhs@fb.com>, Marco Elver <elver@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jacob Shin <jacob.shin@amd.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, dev@openvswitch.org,
        x86@kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 10/12] iwlwifi: Track scan_cmd allocation size explicitly
Message-ID: <202209212224.A2F1DB798@keescook>
References: <20220922031013.2150682-1-keescook@chromium.org>
 <20220922031013.2150682-11-keescook@chromium.org>
 <87fsgk6nys.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsgk6nys.fsf@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Sep 22, 2022 at 07:18:51AM +0300, Kalle Valo wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > In preparation for reducing the use of ksize(), explicitly track the
> > size of scan_cmd allocations. This also allows for noticing if the scan
> > size changes unexpectedly. Note that using ksize() was already incorrect
> > here, in the sense that ksize() would not match the actual allocation
> > size, which would trigger future run-time allocation bounds checking.
> > (In other words, memset() may know how large scan_cmd was allocated for,
> > but ksize() will return the upper bounds of the actually allocated memory,
> > causing a run-time warning about an overflow.)
> >
> > Cc: Gregory Greenman <gregory.greenman@intel.com>
> > Cc: Kalle Valo <kvalo@kernel.org>
> > Cc: Johannes Berg <johannes.berg@intel.com>
> > Cc: linux-wireless@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Via which tree is this iwlwifi patch going? Normally via wireless-next
> or something else?

This doesn't depend on the kmalloc_size_roundup() helper at all, so I
would be happy for it to go via wireless-next if the patch seems
reasonable.

-- 
Kees Cook
