Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E502D31AEEE
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Feb 2021 05:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhBNEvp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Feb 2021 23:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhBNEvn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Feb 2021 23:51:43 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECF9C061574;
        Sat, 13 Feb 2021 20:51:02 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n8so4661098wrm.10;
        Sat, 13 Feb 2021 20:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=QWltJyjSukm6dD9CtsghbdIltEUfUbDDMp2ulH7Ot1A=;
        b=WIJGa5RmN2k28pdCdgxK491hBJJgzkMCC5XreKPXnPpEy3E9W3v0BOQObfGLInq8Od
         gsCEn2OYI1w3OIhqvGW4hr/7w+en96YfXAvIN6tcFc6O7PgVeZ44Orxzw5dziI2wXr9+
         oUBAigUFYPshQ75/gFHgsreR3z288VS4tLf1DJKEoFWbJ9QYU81JCszH5r37jSVFbdfW
         6Qd0EhtuEDT7dfSL6hnEJOq3OgfSfPK3fqC70fpB6XfG524TlI0mAeIICGx2iMudWKch
         kQfqIuXbaj3i08hnwO+ZMRoQCefCDerwdpMFwbhckgtbKBLykocJ2ozTIcKJmU8cXtox
         Pa5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=QWltJyjSukm6dD9CtsghbdIltEUfUbDDMp2ulH7Ot1A=;
        b=ozJagcWXR9C7FHE3fWtgJmmWAgs179H+edgP4h5i23yuX+6iAB65hD8pWIhu3fnVbU
         GQAIjbJy9jCV7jV6BrPUiFPWsnEb72imOOzsxb5nIWdiZUJVAfY7h6OGVOBV3K5o2HTG
         XILdQKiAsnxcLDeeWvV88DbpnxNVpNLgjhUURY76O0RZspIyc1XzE3RcFDjRWGtYCw4A
         QW3SqAAD+lux/HdKisQdfnCCzxIfK8Iqa7LG1WkVNKERDEV59KNE9RHlR3E+4DIlTYEz
         kPHlxHHr4pBNns6PHZSdP0saA26QhGo8XHFtc+KU5Hlj9vFRLc0b+WBcwwrlVbjz/53j
         /djg==
X-Gm-Message-State: AOAM532IQtyMKDb7T+qxCtFYKxXC5cszRyz4C6KCLeHW00JL7llYVakT
        KUtetHmRxan2gNwiIJ2jhQ==
X-Google-Smtp-Source: ABdhPJwRvf+AqBIKI62H0+KXP1e26dDVlwDrJ21jmn1P80WLBvbsMnE7QuQhsoXHui8dpFsDI9wTnQ==
X-Received: by 2002:adf:f905:: with SMTP id b5mr11574719wrr.129.1613278261394;
        Sat, 13 Feb 2021 20:51:01 -0800 (PST)
Received: from [192.168.1.5] ([154.124.31.147])
        by smtp.gmail.com with ESMTPSA id j23sm17473242wmo.18.2021.02.13.20.50.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 13 Feb 2021 20:51:00 -0800 (PST)
Message-ID: <6028ac34.1c69fb81.61833.32c2@mx.google.com>
Sender: skylar anderson <calanthcamara@gmail.com>
From:   CALANTHA CAMARA <sgt.andersonskylar0@gmail.com>
X-Google-Original-From: CALANTHA CAMARA
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hi dear
To:     Recipients <CALANTHA@vger.kernel.org>
Date:   Sun, 14 Feb 2021 04:50:56 +0000
Reply-To: calanthac20@gmail.com
X-Mailer: cdcaafe51be8cdb99a1c85906066cad3d0e60e273541515a58395093a7c4e1f0eefb01d7fc4e6278706e9fb8c4dad093c3263345202970888b6b4d817f9e998c032e7d59
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

do you speak english or what
