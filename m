Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC315A6EDA
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 23:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiH3VGc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Aug 2022 17:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiH3VGa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Aug 2022 17:06:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B02177548
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 14:06:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z3-20020a17090abd8300b001fd803e34f1so10581916pjr.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 14:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc;
        bh=eNDsUqw90np6kZlFLoDzziOjYmszfwMWCx1ejWzxFHM=;
        b=cFLJ/rbsGdccm447KLKmS+BUhlAFbj8JushK4jqbA4NgLKY3NdMfwB79NDywG+QrmG
         syvkaypTy4mT2LpQf9sWvqIl1zotRLGdSZyY6xffc0eMGDOv/BdYuroVDBDxTtBb6njE
         0gI/8+GzXEuHCbPujcbzITLXT+GR39Cdi3s4U6HPEkqlxAQVB52nW6L7Qn7Pv3dBWoUK
         NqDYjljrSz+bRceUa80ocu9Oo5o+sxXVmr5bFWVY23fX1vEr5jXsxKcsMLVcsPT3mvck
         eFExWn/9qX2My0fPYL1NY1zdxl2FuCKTgM2fVAy6jIRjgIXW6iTiQlpvbZ0jpVq3Oxt0
         bXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc;
        bh=eNDsUqw90np6kZlFLoDzziOjYmszfwMWCx1ejWzxFHM=;
        b=RcJSEwgfcNdQKeAJVyrZXm4I8hCBbpxI7OKhfoge8QO7jCg9jIYtfrQ+sePYsv9fb/
         rHURItyjgo3ZyXQBSN57fD3w+KRhSWAuMmqlI3NnFFDlbKry9E34Bv1i6Pgb87bSMwB1
         KJtC/7FsRpyTN2E7zMgWClcfvbMytddbnw8Zk7sE/k1eOoT5QBDoUF1AMab3YB8G61ix
         qgVYcEXKfhCPM2k0xRrWLBnGSA4WZuWSAbyd33TZ1HbVRDdosaiodsnWssu83BnJ85ja
         Zm8Idz0yOZlZCe8eeIdPFQwqYdWYC8SiL7ghQ025YkuS5C0i6M+fohF1uM1c1Li632I5
         ZBTA==
X-Gm-Message-State: ACgBeo3fhn9y1ME5xuwWSf3/dBqtLZzgGoiwtBJ6gu72ejo8adwebW9i
        kCGRfVJUcAUF1YTUcCzCXcHW56oPISw=
X-Google-Smtp-Source: AA6agR4Lishs6UXv54sRQrXa4H2+8h2nxMelBW29D6KN1usRKGxK9HNXi4nQNwFKFs9Kr8yK9fbkhw==
X-Received: by 2002:a17:902:eccb:b0:174:5227:ace6 with SMTP id a11-20020a170902eccb00b001745227ace6mr19281816plh.18.1661893589103;
        Tue, 30 Aug 2022 14:06:29 -0700 (PDT)
Received: from [192.168.254.16] ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id f17-20020aa79691000000b00538405dfe4asm4725455pfk.111.2022.08.30.14.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:06:28 -0700 (PDT)
Message-ID: <33e23355cd8cfcf2296bba1272df814af32b003f.camel@gmail.com>
Subject: Re: Automatically adding OCI in mac80211
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Tue, 30 Aug 2022 14:06:27 -0700
In-Reply-To: <cba322cbf992067e843114ab53da610978768d64.camel@gmail.com>
References: <432703ce83ac979ba06e2b85d6dc500f246c6a76.camel@gmail.com>
         <199f2ac280a1e1a195add45290411a9c1dc519fc.camel@sipsolutions.net>
         <cba322cbf992067e843114ab53da610978768d64.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
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

Hi Johannes,

> > 
> > I don't understand. You already have to know the channel in order
> > to
> > even *do* this (off-channel TX)? The kernel doesn't really know
> > much
> > about operating classes, so that part seems a bit tricky.
> > 
> > Also note that this is not going to work so well with MLO due to
> > the
> > link and MLD addresses, and the kernel currently inserting the ML
> > element, so not sure you're going to want to go this route now.
> 
> Yeah, true the kernel doesn't have the tables for operating
> classes... 
> 
> Basically the critical info we need is the channel width and center1
> frequency (plus center2 freq for 80+80) values for the offchannel
> operation.
> 
> So maybe another API for getting this? Give it a channel/freq and a
> BSS
> MAC, and run roughly the same derivation as
> ieee80211_determine_chantype().
> 
> The only problem here is when picking the channel the kernel tries
> one
> configuration, and if it fails it downgrades the width... So this
> would
> need to be fixed to know ahead of time, if thats possible.
> 
> Note, adding something like this would also benefit FT-over-DS since
> currently you cannot do OCV with it.

So thinking about it more I think we have two options:

1. Improve CMD_ASSOCIATE to be non-destructive on failure and allow the
API to accept a channel definition directly i.e. enough info for
nl80211_parse_chandef() to work. Then use this chandef rather than
derive its own. If this fails (e.g. due to a downgrade) return an error
and userspace could downgrade the width itself and try again. What I'm
thinking here is not modifying any values in sdata, link, ifmgd etc.
until the channel switch returns successfully.

2. Build the OCI element all in the kernel. As far as figuring out the
operating class I'm happy to contribute that (IWD already does this).
And I'm not sure what you mean about it not working with MLO, I don't
know much about it.

Also I do think there would be some value doing (1) in general as far
as it being non-destructive. ieee80211_mgd_assoc() starts modifying
state almost immediately making any failure (even -EBUSY) result in a
disconnect AFAICT. This seems kinda bad...

Thanks,
James


> 
> Thanks,
> James
> 
> > 
> > johannes
> 
> 


