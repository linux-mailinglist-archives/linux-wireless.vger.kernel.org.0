Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE2C377913
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 00:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhEIWs5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 May 2021 18:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhEIWsz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 May 2021 18:48:55 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E9DC061573
        for <linux-wireless@vger.kernel.org>; Sun,  9 May 2021 15:47:52 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id j75so14133763oih.10
        for <linux-wireless@vger.kernel.org>; Sun, 09 May 2021 15:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7NacvmmuQOHw5zoGwZ7lj20sJBc+L1ultFqpD9YShWk=;
        b=D3+DDGPpw9nV41wFnsTtTxgfS6QpM59FCl/fRoAbQz9O8V0oGwluEP0+qSgRD/i7mZ
         Zl7hno907ffP18XOoCex7xCiFlnTJrCcowdBffC52bnTXOrm6FS5YrcqKgz/DaI/Gaeb
         YY4/x/Kp4kat/QFG2xfMoBIhuLK93n9QsjnzQ3JawWs3tTgvhhoINXwn3FlYJHRLqb0H
         1sQknX/IKgoPYbJObM6b2VcTbafXekpXnGZ98l7iQyN/qFjZdjiVMZHHhlR/KDThUTqL
         e8S1qEsiKwbWehNotvOWUAy6b1tafpIR+XY0Zyo/78xLDVXHfQyxtIqfwr7b7wqAOwVV
         Nihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=7NacvmmuQOHw5zoGwZ7lj20sJBc+L1ultFqpD9YShWk=;
        b=ktLWytQOf2w925UsBEhpZZsjBLkulzvi1yCf25/2IpSsHn6+3gK9w73fScFBmE7lMl
         mKJOl7PjWsUVRDnhzrpJ35nQ0j/8WBamikrN9PjSOoczWvYgQVMa+36rvCb4d8R9PqSk
         IOfJgC/RCCvXyYRPZUHtu5LV6A/Zo+USXuC7VBKlznm4YB+RHo5xM9F2cqd3aks09VSe
         3SUxlhJ4DVe/eAVvaYgaXlpxu/KNYtAR8GNXH6s50iwkKsK9gc4Ijgl6jCQsbaIaisCI
         N5HdZPe5rUqk/3neNXM+3syAWghmEgq8vVp1bpCmR0XDYxHo5a+03w4yuywsY5HoUd1V
         03oA==
X-Gm-Message-State: AOAM531S+18XnC8uVKC0J4YCfIguPnBMDqGeG02Yutrp4gNBHOa0DLIb
        Ex0L6oo5ZdibNhCqwcPPtdJRWkrx7VJkBmUs2l8=
X-Google-Smtp-Source: ABdhPJxXvc0WAJp6oVk1AUpIDv1e/t4y7T6Bip9pYN2gmkCYvFy/ZaKJjT0gHce9AWULARMnpyN1ZhtjIC0K8RjVSvI=
X-Received: by 2002:aca:da04:: with SMTP id r4mr23126372oig.123.1620600471525;
 Sun, 09 May 2021 15:47:51 -0700 (PDT)
MIME-Version: 1.0
Reply-To: bisma.abdulmagidbreish@gmail.com
Sender: lindalaboso2@gmail.com
Received: by 2002:a9d:c43:0:0:0:0:0 with HTTP; Sun, 9 May 2021 15:47:51 -0700 (PDT)
From:   Bisma Abdul magidbreish <bisma.abdulmagidbreish@gmail.com>
Date:   Mon, 10 May 2021 00:47:51 +0200
X-Google-Sender-Auth: VAwBwPUK7MkJRmPcg6OyRh6M_FY
Message-ID: <CAAG+hxMBkFN_BhE5vGV4iQgO9dH67W7wpA_J3P6+94SityV9MQ@mail.gmail.com>
Subject: Greetings
To:     lfelipemontoya@hotmail.com, liammacgibbon@hotmail.com,
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
        marbrerie.guivarch29@gmail.com, marc_carole@hotmail.com,
        marcelino.de.faveri@hotmail.com, marcelo.felix@yahoo.com,
        marciamachadoimoveis@yahoo.com.br, marco.daniel.machado@gmail.com,
        marcomachado1@aol.com, marcos_demelo@hotmail.com,
        marcosdiegomarrero@hotmail.com, maria.weinert@hotmail.com,
        mariaaraujon@sec.pb.gov.br, mariachiponi@hotmail.com,
        mariainesmachado@hotmail.com, marianatorreglosa@hotmail.com,
        mariaveronicagarcia@yahoo.com.ar, marilyn.machado@yahoo.com,
        marimm@aol.com, marina.felix@gmail.com, marina_lavoie@hotmail.com,
        marine.rayo@gmail.com, mariocovas.machado@gmail.com,
        marionchevaux@hotmail.com, marisanewbold@aol.com,
        marize-machado@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MUTUAL UNDERSTANDING !!!


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
