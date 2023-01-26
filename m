Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C2067D225
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 17:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjAZQw5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 11:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjAZQw4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 11:52:56 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B6C2698
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 08:52:54 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qx13so6634436ejb.13
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 08:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABuWhvb9SeszbSZosuiCFsBdaufR0DeEmAek7hdmn4s=;
        b=mGhkJhVzIGYwV3qcsROFESt/NlN6/RA6B0wmrOPRkEAFpCAnQo8kekCTozaYvWCuC+
         9uZwDMsDz+RFFHsPSHkK5Hn9enRbaxgN3mweEXfHYJ7QtE7pQ1Ibtv+n/n36JUY6gzQi
         N4Qu6ZJR+L0xMckmv2V8XfM/RhsHl/o26HRgh4mAB99PadP/9HgLmjEFXtiLze652o8X
         L4zD/sCIvEAx1iHDxB4EhPEDgmUc+5f2Jd3hMYDfttSCTVBsUFHtLcj10ECTecItzicd
         NiN2ShdDBx1OYhjqEWXcctlMtkdd51uiIkTq0eV7cCAcMz0g/cnr0iYnKD25jNhQpRCv
         deFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABuWhvb9SeszbSZosuiCFsBdaufR0DeEmAek7hdmn4s=;
        b=zIMv6xXjwOIQ6A1wOMADdNYFjTSHj1FtCJbzPMZGISs9xWNGb0xu73gQ0Gl442lzX5
         v/6ybF1MDSwQJ+3XYR0e2pJphM2OBVj2IkFK8QKzelyQ2clzd0ZjKGMPPhU3+8NjFJhJ
         gbybA3oaDmKyqXEo5/ygfjrm6Hnd8OV5kS3I94uS47ttY1y1TnEibVdq5KZRF8N1T5nG
         Dmj3tjIagJbQz4bWgvnQZShEzI0FYRO3SiyRgQ4S2B9rvNaCWZCHrvr8zWRMCGUglXLL
         pINgoheWz71g1rgrQG7//9BRbQlZNKum8O1GgEIxfYGRQJ6EAsx9kzyq01dFSr6I4VBY
         rG7w==
X-Gm-Message-State: AFqh2kq4L8AS7tFDfFNFXjW2Ib2Pu1k8ogoOD2HRnibNZVL0saJzg2/9
        z+qzQNORbUDErkzMaLyjH4gqp8IQIsU=
X-Google-Smtp-Source: AMrXdXvCAHE8SKEe5lNMecqYwPPe2RwdzxYDKMomlv/LblovQcaSspqKloJMNNd6VPoxuLgaIPRVxw==
X-Received: by 2002:a17:907:d15:b0:862:e612:effe with SMTP id gn21-20020a1709070d1500b00862e612effemr54663567ejc.14.1674751972579;
        Thu, 26 Jan 2023 08:52:52 -0800 (PST)
Received: from smtpclient.apple ([2001:9e8:f12f:c200:289e:467c:f188:afa6])
        by smtp.gmail.com with ESMTPSA id og10-20020a1709071dca00b007be301a1d51sm830075ejc.211.2023.01.26.08.52.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jan 2023 08:52:52 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [RFC v2 5/6] mac80211_hwsim: add TPC per packet support
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <3e269bce8d73577fb1183697655d6ad66edf866f.camel@sipsolutions.net>
Date:   Thu, 26 Jan 2023 17:52:21 +0100
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E26F68F9-337D-4163-AA0F-A43E50864AEB@gmail.com>
References: <20220920104032.496697-1-jelonek.jonas@gmail.com>
 <20220920104032.496697-6-jelonek.jonas@gmail.com>
 <5d15d193c76dcc2cbd59b26912973e3bce34c776.camel@sipsolutions.net>
 <951FA42C-E52F-4FDB-AB73-AEF76435380C@gmail.com>
 <3e269bce8d73577fb1183697655d6ad66edf866f.camel@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> On 19. Jan 2023, at 16:09, Johannes Berg <johannes@sipsolutions.net> =
wrote:
>=20
> On Thu, 2023-01-19 at 15:32 +0100, Jonas Jelonek wrote:
>>>=20
>>> Not sure I like this either - I think we should probably create the
>>> wiphys dynamically for most features these days?
>>=20
>> just to make sure I got it correctly: so you propose that these
>> params, that are=20
>> currently done with module_param(), should be switched to a dynamic
>> netlink approach, or only for TPC and RCTBL for now?
>=20
> We do have dynamic parameters for all the module parameters I believe,
> but we've shied away from actually removing the existing module
> parameters for legacy/compatibility reasons.
>=20
> However, I think that for new parameters, there's really no good =
reason
> to provide module parameters, since the test scripting etc. can
> dynamically create wiphys with the necessary capabilities. Even the
> hostap/hwsim tests can and do already do that :)

=46rom what I=E2=80=99ve seen there is no dynamic parameter for RCTBL =
yet but I can combine
this with my additional TPC parameter. Then this can be set via netlink.

>> As a first step I focused on providing a proof-of-concept
>> implementation in hwsim for my
>> TPC proposal, implementing netlink to set tx power and other could be
>> part of the next step.
>> Do you think this could be fine or do you propose something =
different?
>=20
> I'm not quite sure what you mean by that, tbh. I guess I kind of =
thought
> you were going to adjust minstrel to do TPC automatically.
>=20
> We already have netlink support for setting per-station TX power which =
I
> guess this should then listen to? See =
NL80211_ATTR_STA_TX_POWER_SETTING
> and NL80211_ATTR_STA_TX_POWER etc. I think it's not supported in
> mac80211, but probably could easily be after your patches?

I guess that can be part of some follow-up patches after these patches =
here are upstream.
I would agree that this should somehow listen to the mentioned =
attributes then.

We want to do joint RC and TPC in minstrel, and to allow fine-grained =
TPC as it is already
possible with RC. Minstrel will also be adjusted in one of the next =
steps.
This RFC basically should =E2=80=9Cprepare=E2=80=9D mac80211 to be used =
for fine-grained TPC. I think,
driver support and Minstrel support should be the next steps after the =
structures are fixed.
But I include hwsim here to have at least a test-case. Hope you get what =
I mean :)

Jonas

