Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C723F655D6A
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Dec 2022 15:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiLYOt2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 25 Dec 2022 09:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiLYOt1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 25 Dec 2022 09:49:27 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB282727
        for <linux-wireless@vger.kernel.org>; Sun, 25 Dec 2022 06:49:26 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i15so13101666edf.2
        for <linux-wireless@vger.kernel.org>; Sun, 25 Dec 2022 06:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=shsigjtb9dRU+8AvOmwCeo99R9QRCTxMNMi5Xyf1dGI=;
        b=BQIfP9O8QJPdtjScs25CDP1bsKG2Z4vTt4xlGJd59JwbtiYZTQmROrF0kbm2pJYRyx
         nNDFFjGJzgZ2NaMYo2sNobjdLVPujWNLPDiKgtGOOFoKuVVY7E9RvtRy2QR4j0mNbXxg
         j/vgAfJB7YM4WLS01pUfd/gfQkEN+2jNLqRg8EdAuJqa4zIIy04fyqrwMLEYYSSdUqg8
         TZrEfbK8vTwcAcHB5TvqOLP/fiG41q6+eXfB1xU/lmos+Sb632WYYiisoeHsAQoAmD/+
         s2ApjIFi1+gTwWEZ+ttsPLojWmafVfWo+nLEApssvl1V925Y9TXaLR4UutKLoJZW46K3
         LgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=shsigjtb9dRU+8AvOmwCeo99R9QRCTxMNMi5Xyf1dGI=;
        b=xG9StsBN9y5+6nxN3//we0G88yZwxdUM61L+vjs8R6W1GOpf8KD8J1v2czbMVlbzpS
         db8cjFIlK+mDX5q/qu9g7dQbjISucKm7zhHdpKdiN0rR+AjvT7y08LwMRbm/FKUxWrlT
         CmcPZ8LbxxpSH4HwWsAXub6VmIjt0XZSVIST9RmjGv8s163FhaQRa14fqWRUxk22m1Wt
         qEssKHgdMPgQK2jxYBU0gORwNNgyeDZnZwjQ/bXRUutLUikbA/3SSjIDsh/O4xluUvkl
         GucIrwP7T0uMn6sjT8SIJHi0myE6D8j2Rvx4Br3oAwIMcTA9EJTzJSvUfWl9/ivWD9q9
         QO5A==
X-Gm-Message-State: AFqh2ko9VoQfQ5wzDNDFIRgjXKCTrQVo/M7ZpsatnTesJOyRt5abAodU
        eWpFqenCufOgvw9+W43re2Sruiuf1l9SWQYGI4dTLd2V9W2q
X-Google-Smtp-Source: AMrXdXsb/gHe4oKI3J1ldSRJjySGB7VgG5uMJQX4VUPNnEGRqyR1RmK4RExuya4uvRZpDmALz9HJ6CXIuqXbK4wtQOg=
X-Received: by 2002:aa7:c6c7:0:b0:46d:8e85:170e with SMTP id
 b7-20020aa7c6c7000000b0046d8e85170emr1780952eds.422.1671979765308; Sun, 25
 Dec 2022 06:49:25 -0800 (PST)
MIME-Version: 1.0
From:   Vishal Rao <vishalrao@gmail.com>
Date:   Sun, 25 Dec 2022 20:19:15 +0530
Message-ID: <CAMWtyy1sSHc_DYQ3kq+FWMJKK5Wo3QEgO1yd6wQXx3x0Lp4Uog@mail.gmail.com>
Subject: Wifi 6E 6ghz not working on MediaTek MT7922 (AMD RZ616)
To:     linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello!

Using Ubuntu 22.04 LTS based distro elementary OS 7 with the latest
available Ubuntu mainline kernel 6.1 RC5 build the wifi does not
connect to the 6GHZ band (Wifi 6E) and it only even shows the 6ghz
SSID name *after* I have connected to the 5ghz wifi band.

This is on a new ASUS ZenBook laptop model UM5302TA with the AMD Ryzen
6800U CPU platform which includes the AMD-Mediatek co-developed RZ616
wifi chip I believe.

Pastebin of lspci -vvnn output: https://pastebin.ubuntu.com/p/QwM58ZkptG

Let me know what further information I should provide - happy to do so!

Regards,
Vishal Rao
