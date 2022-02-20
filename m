Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4946D4BCE0D
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Feb 2022 11:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbiBTKzw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Feb 2022 05:55:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbiBTKzu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Feb 2022 05:55:50 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E10B3CA70
        for <linux-wireless@vger.kernel.org>; Sun, 20 Feb 2022 02:55:29 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id i14so22060444wrc.10
        for <linux-wireless@vger.kernel.org>; Sun, 20 Feb 2022 02:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=T28r8IcApmahqshNb89Vq7Sss5daNXvHX2RvLjpVFBs=;
        b=F+Bfp+1a/g29CX9gK81wuuWoams/5g98x9O+SLFtF0Du+Gn0ahPXQDZ5hFmNLB0g0F
         BH+8s23QWIVTAR4mmsu2qzhOneOeP24nEc/lfTG7c0vsDI+vVj0I7uNllTjQLH3+Ynah
         Ec7InZHUBTl4DdvvwRgElx4LMTaEuz8fqMHNl7dV5tmWTmFmTXjziYF/B2vFIln5ECHp
         Sz/Cy/5oJuzDBldvMglvqUUUgxhwPLq9SxpbXC9oZfK+rx+njuyzG9pdtIs09sahA70K
         TQlQThoNdeR0pofFElj1FJBqSrKw7L+CYttpueKkv4PO9cUiH51KqZspHxNgR/Ei2dDT
         MHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=T28r8IcApmahqshNb89Vq7Sss5daNXvHX2RvLjpVFBs=;
        b=bSw9wmLyDw2JyNNsF4efelkolyB35C80ukJIOBe+MeEuqhklq7JjzoM+Rl/LPvyvd5
         qAgVO92bFqWwEcKLY0OPopXmz7nuFSaowakQRSW9a53Ygh5hhuGv/3FdX1sjFiYkqCTz
         vga0Flq9xjMelg20oPYjvCgn3rQHJyUmdrpZLlGYtnsDD5HGbW1WEWRJDPdWlmPr056f
         55Z8hZAnZVgDN1TczFBIVzvO8vnIYnkpvLyHHTv/ufMS2U6uYWdZBR1KyD5TS+QFL4LG
         QOAiBq0Ztl3sEGmPieMNQPrkdqtgniKl8xkWxIWFtMAyas/+SKiAJf/i7hlAW5VO/Fqb
         o15A==
X-Gm-Message-State: AOAM532/wsOEH5KhBS+qfyRgFkj5eBXmZW7DVBDfsXMXziYZLFyy8/kk
        kvCB/gxIgQgIADwm6URwXPk=
X-Google-Smtp-Source: ABdhPJxzHF3j/H3Qmc6RbkECmM91kyUw9oS3mTaU/blS5h7dKZt8fBfQIAHkGT6Tuu1k3MLuTXxPDA==
X-Received: by 2002:a5d:624d:0:b0:1e6:f18c:d264 with SMTP id m13-20020a5d624d000000b001e6f18cd264mr12371385wrv.546.1645354527951;
        Sun, 20 Feb 2022 02:55:27 -0800 (PST)
Received: from [192.168.0.133] ([5.193.8.34])
        by smtp.gmail.com with ESMTPSA id p2sm40175496wrt.101.2022.02.20.02.55.24
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 20 Feb 2022 02:55:27 -0800 (PST)
Message-ID: <62121e1f.1c69fb81.30309.0424@mx.google.com>
From:   Mrs Maria Elisabeth Schaeffler <wilsonjames4521@gmail.com>
X-Google-Original-From: Mrs Maria Elisabeth Schaeffler
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Spende
To:     Recipients <Mrs@vger.kernel.org>
Date:   Sun, 20 Feb 2022 14:55:21 +0400
Reply-To: mariaeisaeth001@gmail.com
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,TO_MALFORMED,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hallo, =


Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Wirtschaftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen, die restlichen 25% dieses Ja=
hr 2022 an Einzelpersonen zu verschenken. Ich habe mich entschlossen, Ihnen=
 1.500.000,00 Euro zu spenden. Wenn Sie an meiner Spende interessiert sind,=
 kontaktieren Sie mich bitte f=FCr weitere Informationen.

Sie k=F6nnen auch =FCber den folgenden Link mehr =FCber mich lesen
https://en.wikipedia.org/wiki/Maria-Elisabeth_Schaeffler

Gr=FC=DFe
Gesch=E4ftsf=FChrer Wipro Limited
Maria-Elisabeth_Schaeffler
E-Mail: mariaeisaeth001@gmail.com
