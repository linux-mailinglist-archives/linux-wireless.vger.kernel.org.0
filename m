Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B5A4B17DB
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 22:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344597AbiBJVyL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 16:54:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbiBJVyK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 16:54:10 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1C9EA5
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 13:54:10 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cf2so13232623edb.9
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 13:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=gae0iqrJma0ubJGx+korPq/UL8n+mTcx7+m98ESw/To=;
        b=Ryl9qv8pKeEy3cbCmPKqJjPNPvEz0bpz9IlDlBk67XVR2jzr9c/FZ9p4fcWd+mLK3y
         LVSEFRF6BfOBg3Wy28DNU2yGmLJonmpoFfccnvg/Xe3g+Nx9ek+7nxqEsCn+SaB0ArTw
         KC3T0t1XlaZexrKbT+3d44uZQmIcoNAAh115jjEynoRfFcx6tJMqzsF+sYkvC051hNBG
         Hy9ptkLAIdGrSz8gXnI7y/KN/dx573gRQKmHm2qTlw+tOLcNz5vMBcZGj+6clvz24/OA
         Q3cBEQfRZfFg9Rx22MMZ1jpRICNyR4FDCFJJrBF9subJk1qRbAyGf+Z/rcgk3fRlYuYe
         m6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=gae0iqrJma0ubJGx+korPq/UL8n+mTcx7+m98ESw/To=;
        b=QQnqpT9TvjT5RoO8qmynXnXJ1jwsFck/KPNCJKd+kihZ2REWduk3CvOoPZBNeIM0fE
         8QkfvX1Og9dcRr2qkAoRaEsy8G5YQxj5SI2o+HwkFWDxta18Ss99qF1LR+a4N9pZqZO9
         ylFDvL7zZCCC78gPc5+BriTNL7f6Jy9D5tkpd3z6zVhGFmYQ/3rcKODdrzGUke3Cu0y/
         Owsdj/VB9VLjxIoeSM6aUE66X26a2v+usKNMC4HXzJ7Nla+pae70O6WJRqdIFt/G+Ikh
         38589hb2bc5dxIHM23lznEFRJgbnUTaz5PIkDw95x8KHg2/JxjN2QMagmm1CcKsZD9oo
         qJaA==
X-Gm-Message-State: AOAM532nswXOekG4VGj3/dFO36u+f+Ue6ggdaZ6GgAdpE6bjB8db3/gl
        2ivPfKGU2j4JN8khv6pg+9JzHET+TCky54J9JLE=
X-Google-Smtp-Source: ABdhPJxY2nyPpGfdDIwbiLV4XrJsgtGlvAHvnfway+kRugWFG1GFREQu+mClUFq8G9cgl9KLQhS4Xw5lVDftNBuMdW8=
X-Received: by 2002:a05:6402:5cf:: with SMTP id n15mr10303915edx.245.1644530049361;
 Thu, 10 Feb 2022 13:54:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:907:7b98:0:0:0:0 with HTTP; Thu, 10 Feb 2022 13:54:08
 -0800 (PST)
Reply-To: tiffanywiffany@gmx.com
From:   Tiffany Wiffany <klouboko@gmail.com>
Date:   Thu, 10 Feb 2022 13:54:08 -0800
Message-ID: <CA+Adgp47PCGXZQXwjApjsfin9p9buEon3_JdgeY+rkB8oi9iOw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 

Hi, please with honest did you receive our message ? we are waiting
for your urgent respond.
