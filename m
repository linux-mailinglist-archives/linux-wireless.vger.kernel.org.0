Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F504E7BE5
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Mar 2022 01:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiCZAOI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 20:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiCZAOH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 20:14:07 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13501175859
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 17:12:33 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id c2so7681844pga.10
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 17:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Iovdo5gFW3lzHAF30oHCSlnhp9HGhN02yXG4gTQEzBo=;
        b=IFxbrtw6MX2TzbzPUVW0OZVJ60JT3UsTUf7o84Lwn974qsIPRA2qCnz2AIm3i7ESQ8
         AnkP997VGJGbxPrru5B+NrOjHm1pxfwjmGmXLN58bOL6b07IqcO91WmgoMoAmPFWddaH
         TY5AbGT/zqRrPa9VdHwPq3ebX7UVVx4eZpkEP4nVSMq3bagk1iqieC1TBgJc9hEFdT0e
         bf1/9DM3ZpDF5+mr1ImJYtt+e1Qo5CJvIJAf6SSEJ5eI2YgahFOcmIveR2IhUtrjiv7y
         T8MsRFfG/uVLki2FNxm0zZV6afAvOzMYFgt2DVHL0ttdcqAWcKhR80mOobAOwid26BtA
         U2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iovdo5gFW3lzHAF30oHCSlnhp9HGhN02yXG4gTQEzBo=;
        b=SOn5+y2/4cshOUS3bR6mu0KaJNtDxusuuOlDpo1pexNa4U1n2JxWzgdUAQn7mlx0Nm
         SmzOJhwEKmOc9Rx+eLrsWo+M8TQh51+XjeWdUQu51xxzPVJmVvB4UxmnwWUy1zTETiQw
         Gt4QCHg8JPv9XrpkYkIZgS/0oPW9BaRxfwB3XxwGuoSdjs0/SnUW/iSqhZCHKKTjVpXG
         PWm3uNrpfrTGTTt29drfUEqAsLvvtvdMFyNNrsl27RPJdcpl580A4GH2qeNmhnSnLa4o
         FpglOJvNqG6LjBPJmddZYK7GCk9Bhs+WNDWgFj8zn7MdIOANzhROGQLe8SU9eKbNtfdo
         0bDw==
X-Gm-Message-State: AOAM531qtzOvGr+C4EOd50OZQ5RltLCcsoEj3H02fHUvHMg3Yb1Lhvmq
        SElgsxR5A9lCWpgu+AnrGyLOtA==
X-Google-Smtp-Source: ABdhPJxb+QHc1qDnE+bUQ6UG68K0+VneJg5AtSaOi5mGuIUAaFCbZcanO833Lxs5xzdX6+b4ZdaKeQ==
X-Received: by 2002:a05:6a00:4198:b0:4fa:8591:5456 with SMTP id ca24-20020a056a00419800b004fa85915456mr12630644pfb.81.1648253552353;
        Fri, 25 Mar 2022 17:12:32 -0700 (PDT)
Received: from google.com (249.189.233.35.bc.googleusercontent.com. [35.233.189.249])
        by smtp.gmail.com with ESMTPSA id o3-20020a056a0015c300b004fb24adc4b8sm1269851pfu.159.2022.03.25.17.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 17:12:31 -0700 (PDT)
Date:   Sat, 26 Mar 2022 00:12:28 +0000
From:   William McVicker <willmcvicker@google.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>, kernel-team@android.com,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [BUG] deadlock in nl80211_vendor_cmd
Message-ID: <Yj5abNAYJEDdoJNg@google.com>
References: <dc556455-51a2-06e8-8ec5-b807c2901b7e@quicinc.com>
 <Yjzpo3TfZxtKPMAG@google.com>
 <19e12e6b5f04ba9e5b192001fbe31a3fc47d380a.camel@sipsolutions.net>
 <20220325094952.10c46350@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <f4f8a27dc07c1adaab470fde302ed841113e6b7f.camel@sipsolutions.net>
 <Yj4FFIXi//ivQC3X@google.com>
 <Yj4ntUejxaPhrM5b@google.com>
 <976e8cf697c7e5bc3a752e758a484b69a058710a.camel@sipsolutions.net>
 <Yj5W7VEij0BGwFK0@google.com>
 <20220325170712.69c2c8d3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325170712.69c2c8d3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
X-Spam-Status: No, score=-15.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 03/25/2022, Jakub Kicinski wrote:
> On Fri, 25 Mar 2022 23:57:33 +0000 William McVicker wrote:
> > Instead of open coding it, we could just pass the internal_flags via struct
> > genl_info to nl80211_vendor_cmds() and then handle the rtnl_unlock() there if
> > the vendor command doesn't request it. I included the patch below in case
> > there's any chance you would consider this for upstream. This would at least
> > add backwards compatibility to the vendor ops API so that existing drivers that
> > depend on the RTNL being held don't need to be fully refactored.
> 
> Sorry to step in, Johannes may be AFK already. There's no asterisk next
> to the "we don't cater to out of tree code" rule, AFAIK.  We change
> locking often, making a precedent like this would be ill-advised.

Yeah I understand. I'll talk to Broadcom about this to see why they didn't use
the existing upstream NAN interface. This sounds like it's going to be
a problem for all the Android out-of-tree drivers.

Thanks for the help!

--Will
