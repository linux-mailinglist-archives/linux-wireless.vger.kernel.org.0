Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26146646F7
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jan 2023 18:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjAJRFt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 12:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjAJRFf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 12:05:35 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E5BBC0C
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 09:05:32 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id e10so8658368pgc.9
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 09:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P7VqYujN76bTRmrMaoEIHiHeEhQrUIdz6GC94wtp4J8=;
        b=oakdv63xlZhd+vcuUCU8xc0JKkQZ3pIx+6U4d3EjnHUwJSmH087Wffbk5LRMaRk1Gr
         P1oSg6d1Z5T2acqHnD1VgEWJprQPK+fmjFEK5H4uaVgpX2wBEo5OPvJwZ+zopI2DiRTL
         pkhw6NSvcs+pkqb0g2VVaPI/dQdqIfgiMtnz9Mvt7ANEVQO++yRpd5Mo/b1W2uNwzCPv
         4JRDleHMpUSbDdwm6gpGhvp6oGvkxEYOtdiWCYPGFyEmgvb1li794YYirYKKUw/6MTMy
         UXyWmbsyyK7dKWPq4iVQkwbQn2wGvrkr4FQIovTMTLrtpJUjUPcTXa5gzdH4EELuL3SB
         vQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P7VqYujN76bTRmrMaoEIHiHeEhQrUIdz6GC94wtp4J8=;
        b=OsHOtXlPNpJZfsICP+beLCwy8xQUdUGyyf+vOytuhUBpVE7Yjm556ZAaAv3gWcqz7R
         o31rYPx2IoNVPtt89c3hEBrdQt6VPV8nT225JBq01pfvwH7N4eK4MDJQBeBoXJh8tEox
         R3mCx6bnL5Y1t5g+U33YebIdy0U4csuHzduXE9waHht3c35OxSoyLio9YIot/FiqPXlC
         W35Toh0uSpuW8xnF3vQfUWp954YXK8w6DNeColMuI5A11OCzaqnsW7IfWNk9jqP5B814
         ntUbnlFy5d9Kh4Dk7cLd27CfYcfEYhEPtkD48WEFrWSCP5TGZcgxetyCmJEvDMFBxZJt
         uNRA==
X-Gm-Message-State: AFqh2kpZ5k3Mqa6RUA8JIq2lvImsVXh5+Ryp4CVWBr5FtOcJr94EPIlt
        ne4J+Pj63OQtJwXQaSW02zQ=
X-Google-Smtp-Source: AMrXdXs+VL0xrwwY1lY317Ko3FUXiqiprqFoQCSiYZmoRgaKA/w5pnLHFlxCog/EiNC00Wdzw/mU8A==
X-Received: by 2002:aa7:8209:0:b0:581:3328:b468 with SMTP id k9-20020aa78209000000b005813328b468mr48635107pfi.6.1673370331500;
        Tue, 10 Jan 2023 09:05:31 -0800 (PST)
Received: from [192.168.254.20] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id i8-20020a056a00004800b00576145a9bd0sm8302689pfk.127.2023.01.10.09.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 09:05:31 -0800 (PST)
Message-ID: <0e7644cbfa9e4ba0d534681166ca467ea1684719.camel@gmail.com>
Subject: Re: [PATCH] wifi: ath11k: Optimize 6 GHz scan time
From:   James Prestwood <prestwoj@gmail.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Tue, 10 Jan 2023 09:05:30 -0800
In-Reply-To: <0b06dea9-d5be-1edc-62ca-576398d1bcd8@quicinc.com>
References: <20221220043823.20382-1-quic_mpubbise@quicinc.com>
         <5DAEA8B2-2B44-4A91-9E57-12B6C6B6C1FC@holtmann.org>
         <2861463e-a097-7efe-bc75-f13c8faf9547@quicinc.com>
         <378a1d63b3752ace7384c44d6f5184753fa7795d.camel@gmail.com>
         <0b06dea9-d5be-1edc-62ca-576398d1bcd8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-01-10 at 10:49 +0530, Manikanta Pubbisetty wrote:
> On 12/29/2022 2:52 AM, James Prestwood wrote:
> > Hi Manikanta,
> > > By the way, userspace itself selects the frequencies to scan, not
> > > the
> > > driver.
> > > 
> > > If we see the split scan implementation in cfg80211, this is the
> > > how
> > > it
> > > is implemented. If NL80211_SCAN_FLAG_COLOCATED_6GHZ is set, it
> > > selects
> > > all PSC channels and those non-PSC channels where RNR IE
> > > information
> > > is
> > > found in the legacy scan results. If this flag is not set, all
> > > channels
> > > in 6 GHz are included in the scan freq list. It is upto userspace
> > > to
> > > decide what it wants.
> > 
> > 
> > This isn't your problem, but it needs to be said:
> > 
> > The nl80211 docs need and update to reflect this behavior (or
> > remove
> > the PSC logic). IMO this is really weird that the kernel selects
> > PSC's
> > based on the co-located flag. The docs don't describe this behavior
> > and
> > the flag's name is misleading (its not
> > SCAN_FLAG_COLOCATED_AND_PSC_6GHZ) :)
> > 
> 
> Sorry for the late reply, I was on vacation.
> 
> What you said make sense. The existing flag should not add PSC
> channels 
> according to the flag description.
> 
> We can add another flag something like you pointed out 
> SCAN_FLAG_COLOCATED_AND_PSC_6GHZ and include PSC channels if this
> flag 
> is set. What do you say?

I'm no authority here, just wanted to point this out. This is something
that would need to be in mac80211 though, not just a specific driver.
It would be up to the maintainers and would require changing the
behavior of the existing flag, which then changes behavior in
wpa_supplicant/hostapd. So its somewhat intrusive.

But personally I'd be for it. And just require userspace include PSC's
like any other channels if they need those.

Thanks,
James


