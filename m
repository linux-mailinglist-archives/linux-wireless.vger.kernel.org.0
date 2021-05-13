Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B6037F4CC
	for <lists+linux-wireless@lfdr.de>; Thu, 13 May 2021 11:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhEMJ02 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 May 2021 05:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhEMJ00 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 May 2021 05:26:26 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249E9C061574
        for <linux-wireless@vger.kernel.org>; Thu, 13 May 2021 02:25:17 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so16776730oth.8
        for <linux-wireless@vger.kernel.org>; Thu, 13 May 2021 02:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=s8vDi8IacwsAjoxAt+TwpipYivdLvkNuOuJDoPMgoHM=;
        b=e0gD7iMHV/4937xoUWGoUVE4hUm/xAjCMOWqm+tTF8oEuHL4gSyAELGCKVJmI6P75o
         eDt3gOozIwylyDj/+PMVgAGA3iNKJI9kUMRLlfZTaYJe7yT9DB5o5a+h1qdvBIiS0Rgw
         KPkXEu5/JhVrUlzpYQJUO2ZVU1MMZPQlMZusG2LZi24XmqeZp1/FSjQDaQZns9vMfZVz
         S4szZWI9joUsQCJvxvAH6uGdpk8CdgnEYVa5dD30bjqSp79MzxFec3zzscVKO/zpykq+
         8JENh2NiOHmlhRqk1TXKGvcjHpTcAcxGbvVkuso3Q434o6VCQA1Z//1ZjVfpB/500iUp
         d4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=s8vDi8IacwsAjoxAt+TwpipYivdLvkNuOuJDoPMgoHM=;
        b=iu5vSNQCCavqoKoJjpmQCBoycoRXrJ4UYGDW6u4eOlzg49mltkA1OLLnZk6j5w8c3C
         pze1kt7XLBUK0TplfSYI5qsReoEHlvXgsIi34yGX6FUllSGeRju2AVwAv14sGTS+d7aR
         lYCwjLHCpf1+ywSJCff9Vxr1s5WF6NYV3HuMM4o8Cw/GzlPs99jz/AacKlTkUo4nVikz
         PVfvr9uzxbL8ZPMQdF7025MqjZx1WPDwEbDxenfsg4Y5NfY+WRaA2JsZ/zR1iEsuVV+W
         Z+p22e6hyxvgSnYBnpgMvDwmidTpXgDF/KNbqMYzV0QAsPoJrQ3Vgmpv8MsUj1b7c4iF
         hJMA==
X-Gm-Message-State: AOAM53269P8OU9vnvnL7ht/qz2pfPMDG1Cg5vRNphN9lpV56Qdwar1Gx
        iuwTHNCUaTBRaEwqhbWGgK2onU9hy0LfD//vgeUNupniEaU=
X-Google-Smtp-Source: ABdhPJxjCG6lvyuGZKH9LVu6ZjKKtuMsJMc2GJZn0yKG3ROVDInCm14RPTGeOMrV0P4YwaA4jvmK67K/veH/unj26eg=
X-Received: by 2002:a9d:674e:: with SMTP id w14mr20403417otm.309.1620897916511;
 Thu, 13 May 2021 02:25:16 -0700 (PDT)
MIME-Version: 1.0
Reply-To: bisma.abdulmagidbreish@gmail.com
Sender: lindalaboso2@gmail.com
Received: by 2002:a9d:c43:0:0:0:0:0 with HTTP; Thu, 13 May 2021 02:25:16 -0700 (PDT)
From:   Bisma Abdul magidbreish <bisma.abdulmagidbreish@gmail.com>
Date:   Thu, 13 May 2021 11:25:16 +0200
X-Google-Sender-Auth: 0rdJblx6skZjjuqeFVPZx1d9Lg0
Message-ID: <CAAG+hxOMb+79FO0YaedOQwdrDiqmpMb1BGWtuOngM8TqwpE6Qg@mail.gmail.com>
Subject: Greetings
To:     lauceulibre@gmail.com, laudeney@hotmail.com, laumach@hotmail.com,
        laure.prat@hotmail.com, lauren.machado@hotmail.com,
        laurentnobili@yahoo.fr, laurie.isacco@uca.fr,
        lck.machado@gmail.com, le.folhago@gmail.com,
        leesmemorialservice@gmail.com, lekanoye@hotmai.com,
        lembostache.felix@gmail.com, lenalmmachado@hotmail.com,
        lennart_weiss@hotmail.com, leonardobaremleite@hotmail.com,
        leonardoccon@gmail.com, leonardomachado.adv@hotmail.com,
        leonardopfuita@hotmail.com, leonel.machado@hotmail.com,
        leroyedozien@yahoo.com, lesmielsdhelene@gmail.com,
        lewis.machado@hotmail.com, lezor_aco@hotmail.com,
        lfelipemontoya@hotmail.com, liammacgibbon@hotmail.com,
        lianniser82@yahoo.com, librarian@sau.edu.bd,
        lic_borquez@hotmail.com, lic_ramirezrobles@hotmail.com,
        licitacaopmmachado@hotmail.com, lilliemarck@hotmail.com,
        lim.felix@gmail.com, limberthmv@hotmail.com,
        Lina.meijer@hotmail.com, linafootrdc@gmail.com,
        linelangeroed@hotmail.com, linux-wireless@vger.kernel.org,
        Lizscott48@hotmail.com, llomb89363@aol.com, llzolikll@gmail.com,
        locust_jeddah@yahoo.com, lokarchiv@mail.bg, loomepalmik@gmail.com,
        lorova32@hotmail.com, losttalentghana@gmail.com,
        louisarthur.felix@gmail.com, loveandquality@aol.com, lrfdg@aol.com,
        lu.souza.machado@gmail.com, luc.ag.dubois@hotmail.fr,
        lucampiglia@aol.com, lucdibog@yahoo.com,
        lucianaschoeps@yahoo.com.br, lucy-machado@hotmail.com,
        lucy.prop@hotmail.com, Lucy13_marseille@hotmail.com,
        ludyfranky@hotmail.com, luis.ca.machado@gmail.com,
        luis.s.machado@tecnico.ulisboa.pt, Luis32789@aol.com,
        luismachadodirector@gmail.com, luma.machado@yahoo.com.br,
        Luziene-felix@hotmail.com, lycee.paulpoiret@yahoo.fr,
        m-nii1984@clin.medic.mie-u.ac.jp, m.elizabethpinto@ig.com.br,
        m.lavoie@aiic.net, mab.roosendaal@gmail.com, MACHADO@aol.com,
        machado@gmail.com, machado@hotmail.com, machado@yahoo.com,
        machado@yahoo.com.br, machado.aeill@gmail.com,
        machado.avocat@gmail.com, Machado.elise@hotmail.fr,
        machado.humberto2010@gmail.com, machado617@gmail.com,
        machado_1000@hotmail.com, machadoallan@aol.com,
        machadojose117@yahoo.fr, machadoleiloeiro@hotmail.com,
        machadoluis75@gmail.com, machmas@free.fr, madda.felix@gmail.com,
        maddie.machado@yahoo.com, madracing1@hotmail.com,
        mafle.asbl@hotmail.com, maggimachado@gmail.com,
        magno100@hotmail.com, mahmaoudahmed104@hotmail.com,
        mail2me.sumith@yahoo.com, mailrich2012@aol.com,
        mairiee.cussac@gmail.com, majahaals@hotmail.com,
        malikab.photographe@gmail.com, malmodockteater@gmail.com,
        mandemi2000@yahoo.com, manish7march1972@yahoo.com,
        marbrerie.guivarch29@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--=20
MUTUAL UNDERSTANDING !!!

I am Mrs.Bisma Abdul magidbreish

Please forgive me for stressing you with my predicaments as I know
that this letter may come to you as big surprise. Actually, I came
across your E-mail from my personal search afterward I decided to
email you directly believing that you will be honest to fulfill my
final wish before I die. Mean while, I am bisma.abdulmagidbreish, from
paric france
childless and I am suffering from a long-time cancer and from
all indication my condition is really deteriorating as my doctors have
confirmed and courageously advised me that I may not live beyond two
months from now for the reason that my tumor has reached a critical
stage which has defiled all forms of medical treatment.

Since my days are numbered, I=E2=80=99ve decided willingly to fulfill my
long-time promise to donate the sum of six million eight hundred
thousand dollars $6.800, 000 remaining in my foreign bank account over
9 years due to my health problem. This fund was obtained by me when I
was dealing on Gold. My promise is to help the widows, handicapped,
orphans, underprivileged, to build technical school and hospital for
their well-being. If you will be obedient to assist me fulfill my
promise as I said here kindly show me your first obedience by
providing me your personal details to enable me introduce you to my
lawyer as the person that will help you to procure any document if
requested possible to transfer or deliver my fund to you.

I have been trying to handle this project for the past 4 years by
myself when I will get better, but I have seen that it won=E2=80=99t be
possible anymore due to my condition. Please get back to me if you can
handle the project for more details
Thank you
God bless you.
