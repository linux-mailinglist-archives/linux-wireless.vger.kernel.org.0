Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5106C6EAB37
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 15:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjDUNGN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Apr 2023 09:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjDUNGM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Apr 2023 09:06:12 -0400
Received: from mx1.uni-rostock.de (mx1.uni-rostock.de [139.30.22.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0525D44A8
        for <linux-wireless@vger.kernel.org>; Fri, 21 Apr 2023 06:06:09 -0700 (PDT)
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1682082368; bh=pEpUpbzHHUHZM4VTO6hKwBs+o52TBDBzxm6VAChQE/U=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 DyH9Qy0HYPhcq7spTB4sqFYqMLivN1Y2yVLY9vdaMaaaxkdmg+wOhksV/7UjkY8h9VOKhVcgvQzftgp3AfFwDQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1682082368; bh=pEpUpbzHHUHZM4VTO6hKwBs+o52TBDBzxm6VAChQE/U=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 f/2BxMP7m8/F8icyghNQOsFzXq89N0uqxaaQLhCu9XxFt7rAA0AnWkvzgK9HAK6SFkSxujquAf93IF5mBVxvTudliEYgql20JElSv3UYRwEC7M4TcjD7aBnJ5vMKR6+i4KKrqm+u1wmdLs3kTRUOOZcBlFpQfPbolMukZc2sb6Q=
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 21 Apr 2023 13:06:08 GMT
Received: from [172.16.0.2] (104.28.223.198) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 21 Apr
 2023 15:06:06 +0200
Message-ID: <72e1ed9c-9400-da54-71ce-ecd7ad97c174@uni-rostock.de>
Date:   Fri, 21 Apr 2023 15:06:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC] average: rewrite for clearity
Content-Language: de-DE
To:     <nbd@nbd.name>, <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20230421130022.191045-1-benjamin.beichler@uni-rostock.de>
From:   Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=c3=a4t_Rostock?=
In-Reply-To: <20230421130022.191045-1-benjamin.beichler@uni-rostock.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-Originating-IP: [104.28.223.198]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: DD860B6D9CF54701CD24BE45FB2052E9BE1667D12665D06C0CC9F8A43E97C55F2000:8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sorry for the crappy formatting of line endings, I have some tab/space 
issues with my editor, I will fix this ...

Am 21.04.2023 um 15:00 schrieb Benjamin Beichler:
> Move the former *=5Fadd function with its implicit initialization into a
> separate function, when the user explicitly wants to init with the first
> added value, altough this creates issues, when 0 is a expected value for
> the internal value.
>
> Add a separate init function with value parameter to allow init with
> distinct value, which was formerly done by the implicit init of old
> *=5Fadd function.
>
> Move the compile time checks into a separate macro, as they are used
> multiple times and noise up the functions.
>
> Also fix some formatting issues.
>
> Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
> ---
>   include/linux/average.h | 98 ++++++++++++++++++++++++-----------------
>   1 file changed, 57 insertions(+), 41 deletions(-)
>
> diff --git a/include/linux/average.h b/include/linux/average.h
> index a1a8f09631ce..2e70224b84a8 100644
> --- a/include/linux/average.h
> +++ b/include/linux/average.h
> @@ -25,47 +25,63 @@
>    * that this parameter must be a power of two for efficiency.
>    */
>   
> -#define DECLARE=5FEWMA(name, =5Fprecision, =5Fweight=5Frcp)=09=09=09\
> -=09struct ewma=5F##name {=09=09=09=09=09=09\
> -=09=09unsigned long internal;=09=09=09=09=09\
> -=09};=09=09=09=09=09=09=09=09\
> -=09static inline void ewma=5F##name##=5Finit(struct ewma=5F##name *e)=09\
> -=09{=09=09=09=09=09=09=09=09\
> -=09=09BUILD=5FBUG=5FON(!=5F=5Fbuiltin=5Fconstant=5Fp(=5Fprecision));=09\
> -=09=09BUILD=5FBUG=5FON(!=5F=5Fbuiltin=5Fconstant=5Fp(=5Fweight=5Frcp));=09\
> -=09=09/*=09=09=09=09=09=09=09\
> -=09=09 * Even if you want to feed it just 0/1 you should have=09\
> -=09=09 * some bits for the non-fractional part...=09=09\
> -=09=09 */=09=09=09=09=09=09=09\
> -=09=09BUILD=5FBUG=5FON((=5Fprecision) > 30);=09=09=09\
> -=09=09BUILD=5FBUG=5FON=5FNOT=5FPOWER=5FOF=5F2(=5Fweight=5Frcp);=09=09\
> -=09=09e->internal =3D 0;=09=09=09=09=09\
> -=09}=09=09=09=09=09=09=09=09\
> -=09static inline unsigned long=09=09=09=09=09\
> -=09ewma=5F##name##=5Fread(struct ewma=5F##name *e)=09=09=09\
> -=09{=09=09=09=09=09=09=09=09\
> -=09=09BUILD=5FBUG=5FON(!=5F=5Fbuiltin=5Fconstant=5Fp(=5Fprecision));=09\
> -=09=09BUILD=5FBUG=5FON(!=5F=5Fbuiltin=5Fconstant=5Fp(=5Fweight=5Frcp));=09\
> -=09=09BUILD=5FBUG=5FON((=5Fprecision) > 30);=09=09=09\
> -=09=09BUILD=5FBUG=5FON=5FNOT=5FPOWER=5FOF=5F2(=5Fweight=5Frcp);=09=09\
> -=09=09return e->internal >> (=5Fprecision);=09=09=09\
> -=09}=09=09=09=09=09=09=09=09\
> -=09static inline void ewma=5F##name##=5Fadd(struct ewma=5F##name *e,=09\
> -=09=09=09=09=09     unsigned long val)=09=09\
> -=09{=09=09=09=09=09=09=09=09\
> -=09=09unsigned long internal =3D READ=5FONCE(e->internal);=09\
> -=09=09unsigned long weight=5Frcp =3D ilog2(=5Fweight=5Frcp);=09=09\
> -=09=09unsigned long precision =3D =5Fprecision;=09=09=09\
> -=09=09=09=09=09=09=09=09=09\
> -=09=09BUILD=5FBUG=5FON(!=5F=5Fbuiltin=5Fconstant=5Fp(=5Fprecision));=09\
> -=09=09BUILD=5FBUG=5FON(!=5F=5Fbuiltin=5Fconstant=5Fp(=5Fweight=5Frcp));=09\
> -=09=09BUILD=5FBUG=5FON((=5Fprecision) > 30);=09=09=09\
> -=09=09BUILD=5FBUG=5FON=5FNOT=5FPOWER=5FOF=5F2(=5Fweight=5Frcp);=09=09\
> -=09=09=09=09=09=09=09=09=09\
> -=09=09WRITE=5FONCE(e->internal, internal =3F=09=09=09\
> -=09=09=09(((internal << weight=5Frcp) - internal) +=09\
> -=09=09=09=09(val << precision)) >> weight=5Frcp :=09\
> -=09=09=09(val << precision));=09=09=09=09\
> +#define EWMA=5FBUILD=5FTIME=5FCHECKS(=5Fprecision, =5Fweight=5Frcp)        =
                \
> +=09=09BUILD=5FBUG=5FON(!=5F=5Fbuiltin=5Fconstant=5Fp(=5Fprecision));=09=09=
=09=09=09   \
> +=09=09BUILD=5FBUG=5FON(!=5F=5Fbuiltin=5Fconstant=5Fp(=5Fweight=5Frcp));=09 =
                  \
> +=09=09/*=09=09=09=09=09=09=09                                           \
> +=09=09 * Even if you want to feed it just 0/1 you should have=09           =
    \
> +=09=09 * some bits for the non-fractional part...=09=09                    =
   \
> +=09=09 */=09=09=09=09=09=09=09=09=09=09=09=09=09=09=09=09=09   \
> +=09=09BUILD=5FBUG=5FON((=5Fprecision) > 30);=09=09=09=09=09=09=09=09=09   \
> +=09=09BUILD=5FBUG=5FON=5FNOT=5FPOWER=5FOF=5F2(=5Fweight=5Frcp);=09=09
> +
> +
> +#define DECLARE=5FEWMA(name, =5Fprecision, =5Fweight=5Frcp)=09=09=09       =
            \
> +=09struct ewma=5F##name {=09=09=09=09=09=09                               \
> +=09=09unsigned long internal;=09=09=09=09=09                               =
\
> +=09};=09=09=09=09=09=09=09=09                                           \
> +=09static inline void ewma=5F##name##=5Finit=5Fval(struct ewma=5F##name *e,=
           \
> +=09=09=09=09=09=09=09=09=09=09  unsigned long init)=09               \
> +=09{=09=09=09=09=09=09=09=09                                           \
> +=09=09EWMA=5FBUILD=5FTIME=5FCHECKS(=5Fprecision, =5Fweight=5Frcp)          =
              \
> +=09=09e->internal =3D init << =5Fprecision;=09=09=09=09=09                 =
  \
> +=09}=09=09=09=09=09=09=09=09                                           \
> +=09static inline void ewma=5F##name##=5Finit(struct ewma=5F##name *e)      =
         \
> +=09{=09                                                                    =
   \
> +=09=09=09ewma=5F##name##=5Finit=5Fval(e, 0);=09=09=09=09=09=09             =
  \
> +=09}                                                                       =
   \
> +=09static inline unsigned long=09=09=09=09=09                              =
 \
> +=09ewma=5F##name##=5Fread(struct ewma=5F##name *e)=09=09=09                =
       \
> +=09{=09=09=09=09=09=09=09=09                                           \
> +=09=09EWMA=5FBUILD=5FTIME=5FCHECKS(=5Fprecision, =5Fweight=5Frcp)          =
              \
> +=09=09return e->internal >> (=5Fprecision);=09=09=09                       =
    \
> +=09}=09=09=09=09=09=09=09=09                                           \
> +=09static inline void ewma=5F##name##=5Fadd(struct ewma=5F##name *e,=09    =
           \
> +=09=09=09=09=09     unsigned long val)=09=09                               =
\
> +=09{=09=09=09=09=09=09=09=09                                           \
> +=09=09unsigned long internal =3D READ=5FONCE(e->internal);=09              =
     \
> +=09=09unsigned long weight=5Frcp =3D ilog2(=5Fweight=5Frcp);=09=09         =
          \
> +=09=09unsigned long precision =3D =5Fprecision;=09=09=09                   =
    \
> +=09=09=09=09=09=09=09=09=09                                           \
> +=09=09EWMA=5FBUILD=5FTIME=5FCHECKS(=5Fprecision, =5Fweight=5Frcp)          =
              \
> +=09=09=09=09=09=09=09=09=09                                           \
> +=09=09WRITE=5FONCE(e->internal,=09=09=09                                   =
    \
> +=09=09=09(((internal << weight=5Frcp) - internal) +=09                     =
  \
> +=09=09=09=09(val << precision)) >> weight=5Frcp);=09=09                    =
   \
> +=09}                                                                       =
   \
> +=09static inline void ewma=5F##name##=5Fadd=5For=5Finit(struct ewma=5F##nam=
e *e,=09       \
> +=09=09=09=09=09     unsigned long val)=09=09                               =
\
> +=09{=09=09=09=09=09=09=09=09                                           \
> +=09=09unsigned long internal =3D READ=5FONCE(e->internal);=09              =
     \
> +=09=09unsigned long weight=5Frcp =3D ilog2(=5Fweight=5Frcp);=09=09         =
          \
> +=09=09unsigned long precision =3D =5Fprecision;=09=09=09                   =
    \
> +=09=09=09=09=09=09=09=09=09                                           \
> +=09=09EWMA=5FBUILD=5FTIME=5FCHECKS(=5Fprecision, =5Fweight=5Frcp)          =
              \
> +=09=09=09=09=09=09=09=09=09                                           \
> +=09=09WRITE=5FONCE(e->internal, internal =3F=09=09=09=09=09=09=09=09=09   \
> +=09=09=09(((internal << weight=5Frcp) - internal) +=09                     =
  \
> +=09=09=09=09(val << precision)) >> weight=5Frcp :=09                       =
    \
> +=09=09=09(val << precision));=09=09=09=09                               \
>   =09}
>   
>   #endif /* =5FLINUX=5FAVERAGE=5FH */


-- 
M.Sc. Benjamin Beichler

Universit=C3=A4t Rostock, Fakult=C3=A4t f=C3=BCr Informatik und Elektrotechnik
Institut f=C3=BCr Angewandte Mikroelektronik und Datentechnik

University of Rostock, Department of CS and EE
Institute of Applied Microelectronics and CE

Albert-Einstein-Str. 26
18059 Rostock
Deutschland/Germany

phone: +49 (0) 381 498 - 7278
email: Benjamin.Beichler@uni-rostock.de
www: http://www.imd.uni-rostock.de/
