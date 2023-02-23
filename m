Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE986A0D2B
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 16:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjBWPjV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 10:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbjBWPjT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 10:39:19 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C532ED54
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 07:38:39 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id o6so16355223vsq.10
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 07:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677166715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmPUQkQTbE8eRJKaiDBS9EG9WYoYRiytveYx8LKoV3Q=;
        b=eC3Xq+PKE/1Xhh+6mZeylQQ2L/0kWT5o/XbnSjFULf81MnfwQ/E0dJ9t8fClZsI5u3
         TBA/4oGPo38DkVRRbnYZffmgqQUHfYaA2yY4ApjWmzLf29G1pMwgng2gUTFoMrHu/yS9
         pzqiCP6Mm11GnF/q4BhslqIYNSQTLT1TH5s+JSl5/ypyY5CuZVagdJV/pz2b+biznsrA
         HlgzfyZ1kmU2+xFeUwSd44VYbTf+FvyvZmLYdJkYXdy+misCXD//he4O+q/05Q0FKaH9
         n6EzHDiJ1AjbXoV+zfcIoW9hPOyh4iybrSyyuY0yhDe4e7mwj9jn1L9WiPdBArbZ0IRB
         5CQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677166715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmPUQkQTbE8eRJKaiDBS9EG9WYoYRiytveYx8LKoV3Q=;
        b=n2ShAR2KTEVKrLvq0g5hKzQpEFpN6ksJ3WhG0i04PKOZTF/bQrZgFIMvoejlGkrm4y
         fqb1mNLBT9Q6nNs30klKQfox1XSTdQl4v1d6r7s7Ptyt7j9pZ4tvdfR8uxMsKfG3BmYd
         hlgW8uZdoI1qrwBhUgjrCPvE6L0kurRN3ArVBZEGpoHKrvw6p0tskRyx1QwYHsdgGgvY
         e341u5MFIve+G1FMg0DUYZeeWIdF9jPZt3oWHPk5di8pV25ZsXIc6Px7H6AG6Uh5lu2w
         FFlNpI7XO2MjC8wCqu7VgwO4JdTY7o5iAhSe3VakEmO9EA1ox+zmNpFm1SN4M0M5+VDK
         cnRA==
X-Gm-Message-State: AO0yUKVDDhYXkdTvw5+GIZb60v84S57o3QldX7e4HDMP1yXWXxPlejCp
        OifXWXQXN9hGlqB8lA+2lc2tVQJIuejMkxTwkj6BjQ==
X-Google-Smtp-Source: AK7set+2jVgMlqvrsX+qtMb0HOJvBdtKIBTkcI8RrHtsRc+tbTPnsB9EnSG/jCvq/C9kne60ReStws5XBm0ZUEohRu4=
X-Received: by 2002:a05:6102:1485:b0:414:90d8:5be7 with SMTP id
 d5-20020a056102148500b0041490d85be7mr2681616vsv.75.1677166714910; Thu, 23 Feb
 2023 07:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20230207085400.2232544-1-jaewan@google.com> <20230207085400.2232544-3-jaewan@google.com>
 <fbe6f8eb820b29f0cc932a63ad84253d0cef93c3.camel@sipsolutions.net>
In-Reply-To: <fbe6f8eb820b29f0cc932a63ad84253d0cef93c3.camel@sipsolutions.net>
From:   Jaewan Kim <jaewan@google.com>
Date:   Fri, 24 Feb 2023 00:38:23 +0900
Message-ID: <CABZjns4r_CJ-paj1FQ-SMFJMQW7rkXnvx5w98zYRgf6UQSnfkw@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] mac80211_hwsim: add PMSR request support via virtio
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     gregkh@linuxfoundation.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, kernel-team@android.com, adelva@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Feb 16, 2023 at 3:07 AM Johannes Berg <johannes@sipsolutions.net> w=
rote:
>
> On Tue, 2023-02-07 at 08:53 +0000, Jaewan Kim wrote:
> >
> >
> > +static int mac80211_hwsim_send_pmsr_ftm_request_peer(struct sk_buff *m=
sg,
> > +                                                  struct cfg80211_pmsr=
_ftm_request_peer *request)
>
> this ...
>
> > +{
> > +     struct nlattr *ftm;
> > +
> > +     if (!request->requested)
> > +             return -EINVAL;
> > +
> > +     ftm =3D nla_nest_start(msg, NL80211_PMSR_TYPE_FTM);
> > +     if (!ftm)
> > +             return -ENOBUFS;
> > +
> > +     if (nla_put_u32(msg, NL80211_PMSR_FTM_REQ_ATTR_PREAMBLE, request-=
>preamble))
> > +             return -ENOBUFS;
> > +
> > +     if (nla_put_u16(msg, NL80211_PMSR_FTM_REQ_ATTR_BURST_PERIOD, requ=
est->burst_period))
> > +             return -ENOBUFS;
>
> and this ... etc ...
>
> also got some really long lines that could easily be broken
>
> > +     chandef =3D nla_nest_start(msg, NL80211_PMSR_PEER_ATTR_CHAN);
> > +     if (!chandef)
> > +             return -ENOBUFS;
> > +
> > +     err =3D cfg80211_send_chandef(msg, &request->chandef);
> > +     if (err)
> > +             return err;
>
> So this one I think I'll let you do with the export and all, because
> that's way nicer than duplicating the code, and it's clearly necessary.
>
> > +static int mac80211_hwsim_send_pmsr_request(struct sk_buff *msg,
> > +                                         struct cfg80211_pmsr_request =
*request)
> > +{
> > +     int err;
> > +     struct nlattr *pmsr =3D nla_nest_start(msg, NL80211_ATTR_PEER_MEA=
SUREMENTS);
>
> I'm not going to complain _too_ much about this, but all this use of
> nl80211 attributes better be thoroughly documented in the header file.
>
> > + * @HWSIM_CMD_START_PMSR: start PMSR
>
> That sounds almost like it's a command ("start PMSR") but really it's a
> notification/event as far as hwsim is concerned, so please document
> that.
>
> > + * @HWSIM_ATTR_PMSR_REQUEST: peer measurement request
>
> and please document the structure of the request that userspace will get
> (and how it should respond?)
>
> > +++ b/include/net/cfg80211.h
> > @@ -938,6 +938,16 @@ int cfg80211_chandef_dfs_required(struct wiphy *wi=
phy,
> >                                 const struct cfg80211_chan_def *chandef=
,
> >                                 enum nl80211_iftype iftype);
> >
> > +/**
> > + * cfg80211_send_chandef - sends the channel definition.
> > + * @msg: the msg to send channel definition
> > + * @chandef: the channel definition to check
> > + *
> > + * Returns: 0 if sent the channel definition to msg, < 0 on error
> > + **/
>
> That last line should just be */
>
> > +int cfg80211_send_chandef(struct sk_buff *msg, const struct cfg80211_c=
han_def *chandef);
>
> I think it'd be better if you exported it as nl80211_..., since it
> really is just a netlink thing, not cfg80211 functionality.

Sorry about the late response but could you elaborate to me in more
detail on this?
Where header file would be the good place if it's exporting it as nl80211_.=
..?

Here are some places that I've considered but don't seem like a good candid=
ate.

- include/net/cfg80211.h: proposed by current patch with name
cfg80211_send_chandef.
- include/uapi/linux/nl80211.h: only contains enums. doesn't seem like
a good place.

net/wireless/nl80211.h seems like your suggestion, but I can't find
how to include this from mac80211_hwsim.c.

I may need to EXPORT_SYMBOL(nl80211_send_chandef) and also declare it
to the cfg80211.h,
but I'm not sure because I can't find any existing example.

>
> It would also be good, IMHO, to split this part out into a separate
> patch saying that e.g. hwsim might use it like you do here, or even that
> vendor netlink could use it where needed.
>
> johannes



--=20
Jaewan Kim (=EA=B9=80=EC=9E=AC=EC=99=84) | Software Engineer in Google Kore=
a |
jaewan@google.com | +82-10-2781-5078
