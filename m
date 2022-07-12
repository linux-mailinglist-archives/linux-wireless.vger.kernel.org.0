Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FDC5722A2
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jul 2022 20:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiGLS3y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Jul 2022 14:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiGLS3y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Jul 2022 14:29:54 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C0B655B5
        for <linux-wireless@vger.kernel.org>; Tue, 12 Jul 2022 11:29:53 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso9320452pjo.0
        for <linux-wireless@vger.kernel.org>; Tue, 12 Jul 2022 11:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=IKQRoTpvciiOZG38MjG2yPSM9CEF0vsQRXAea/HyePQ=;
        b=evcVq0VMaXL6dqtMjzHx00v2wUKyiu6804pd9D6/NBHF+AajGfdBUZoSAXVTomR17X
         PgFn5aeMzXBJ/AxCm0NY+pZenebyUFWSTCqWEJqzxE6VuQjoVCFWYDnS4ODTTgRlRQeE
         u3zoGmv+7G7YrCEC3wQCDRglR/Isrc0uQW2lCPL+BLO/tyL2X2eqgcM0tuV8MoZ+fjwn
         f5dQjAlvDYlm81DOOn2OW3P8Cj7NmpMsH9LECQ40lMmc+G4/3TXHLz/tH0UWZ27Ni6FL
         f/m/jXYQ/pYkDI97dsXIEYj988nA6oxOTsx7drOsHLQSGtIMk+PcKKLXwOOy6yZYT+ZZ
         2Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IKQRoTpvciiOZG38MjG2yPSM9CEF0vsQRXAea/HyePQ=;
        b=bH3/uTVdrXkDBGrJ6EEMM22mwXTUJvkadQZdKTmCRIhDM5Rc4W2BU0QcFWOZjL9cN7
         cCgB9+ZxmFifFVz4yq/Fugmg7LpRixf/MK0+LHm12sJLczKbgu6PrBDdZUsHJIs0X26K
         8W0ndkvA6lx/z4jJRHFu6iNWJU0mDUTjf3zjP+o8g1BPGOENunLKkf9+TxlEzP+wlgLU
         UuuLdO0XWey+9fN5Acm1X+GiLeBn5AGeOIJnjkCW7dHDOcI+D+ZzUoh//0H6xVFCs9DP
         NukgTfOATzMLEf8qZTJfO0YVPB5SqbAq0AHbgJLGqLDA5sN0SUbbgDCPF2pQfZ5GNv/0
         V+BA==
X-Gm-Message-State: AJIora+Fz2shFuMo6TsmcZ3kv3ibmxoBdMA68OTkqJnDrdE6v55lRJvJ
        RAim8VVsNoSvlN9nM5ALoIx6wgx/KBE=
X-Google-Smtp-Source: AGRyM1s1Z1VnIHeV43hAcQliVJwGNQAr0Oq0udfAeGmlC616vbQvDOXR24NVqBtxoiND/054c38nTA==
X-Received: by 2002:a17:902:a586:b0:16c:3182:a9b with SMTP id az6-20020a170902a58600b0016c31820a9bmr19670769plb.44.1657650592895;
        Tue, 12 Jul 2022 11:29:52 -0700 (PDT)
Received: from [192.168.68.52] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902e88800b00168dadc7354sm7253365plg.78.2022.07.12.11.29.52
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 11:29:52 -0700 (PDT)
Message-ID: <9d5741aab6ce44416549071b9506076d26c4a426.camel@gmail.com>
Subject: Re: Expected behavior with co-located 6GHz APs?
From:   James Prestwood <prestwoj@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Tue, 12 Jul 2022 11:29:52 -0700
In-Reply-To: <1c1a0a2c454dafcfaa19995974448ee5836fd9f7.camel@gmail.com>
References: <1c1a0a2c454dafcfaa19995974448ee5836fd9f7.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update on this. I narrowed the issue down to the fact that its the
AX210 firmware which changes the regulatory domain, and this is not
being done for very limited scans on a few frequencies. There is
apparently some beacon/probe threshold to trigger a regdom change in
the firmware. Unclear exactly what this threshold is.

This poses a problem, at least for IWD, because we rely on scanning
just a few frequencies of our last known networks when starting up.
This allows us to connect very quickly. But now with this behavior we
are both unable to scan 6ghz from the start, and furthermore its not
guaranteed the regdom will get updated from this limited scan, (or even
a full scan for that matter) preventing 6ghz from being used.

I'm not too sure this can be worked around in userspace with any sort
of reliability. It seems like the FW needs to loosen the policy on
setting the regulatory domain for situations where a scan resulted in
only a few BSS's. In this case if all the beacons contain the same
country IE its a very high likelyhood that is the country. Otherwise,
if differing country IEs are found handle that however it does now.

Does this sound reasonable?

Thanks,
James

On Fri, 2022-07-08 at 11:22 -0700, James Prestwood wrote:
> Hi,
> 
> I am playing around with a 6ghz AP and noticed some behavior I didn't
> expect.
> 
> The first issue I ran into was the regulatory domain. I'm in the US
> so
> 6GHz should be enabled but "iw reg get" initially doesn't show any
> 6GHz
> frequencies. Its my understanding these frequencies get enabled by
> received beacons, and indeed if I do a full passive scan the
> regulatory
> domain gets updated, e.g.
> 
> iw wlan0 scan passive
> 
> After this, I can active scan and see my 6GHz AP. Which I'm assuming
> was based on the RNR element since active scanning on 6GHz is
> disallowed.
> 
> BUT, if the interface goes down, the regdom reverts back to country
> 00
> requiring a full passive scan again to unlock 6GHz. This basically
> prevents a supplicant from using 6GHz without doing a time intensive
> passive scan.
> 
> I would make more sense that the regdom should be updated based on
> finding an RNR element in addition to the beacon itself right?
> 
> Thanks,
> James
> 


