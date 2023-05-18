Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8A770849A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 May 2023 17:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjERPFs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 11:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjERPEz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 11:04:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1007912E
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 08:04:30 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-510b4e488e4so3842293a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 08:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684422258; x=1687014258;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vgyyCi8tJLPzAHMcTGzr1hdEUMqdZmekNUwmKIEbLWw=;
        b=pl6rsy9PE8JWvUgxE0R7I5wWECkhXspBpSKWo2vcbiiKDJLttP+XMN/PLUgceCVy2n
         Dw5gP1JW20kdpIJpg5hVsM1GK/5XRXmIEG4ybJybxt8MCl/SVN5wq9wVImh+Fsgh4yYe
         hG23RN/3UjE8DBYRoXvfyuw7izqNYSekMlSPZYFPDCssPGc+mqPJFXFfXFhbu8Ven2Qv
         SddLVJoCNbwTqgBjNr07Np0sWSYxcrESe5Kx4Yl/2piE+590iirPns7MW5ZvpznwAl4m
         /4brl/STXYhLadAfMeSrUpw8B/NLRFeBZaH7c5sK61cNRXyb9DJm9SlhFydG4lFBDO06
         skMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684422258; x=1687014258;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgyyCi8tJLPzAHMcTGzr1hdEUMqdZmekNUwmKIEbLWw=;
        b=Vj5pnGIOh6x1kJUhc8vFLLIHJe4f/7wPQ0SAAHXMlPKY09wyhcEKI+JFan4Od5rQfu
         wMlQca3r/CN2tdbYxYMF1nyIi8EOPB+2QWSs3SyQJq3nE6Srz032YHdI5wlWLwzqdQ6W
         gFx41gTYLjrpXPtKX003hXyTlx0FrbCoabnIEdPR9AV5PHaVL0wsGz63j/+yDA+0gZTD
         kUJhIJzUhhxoLIy0o0Se5uWpzAyACCUcGSFfl3y5W7V1ac9eioYVDBbcwgtEKmS+DDi3
         SjjSmnmnbMDp9QW/QDfX5xjE4PHNqrCm898FsMaLzau9t9ZLaUYxpDGJDzZ5LsTBAmwU
         cB7w==
X-Gm-Message-State: AC+VfDzXQG4UXl8j1No9q+ZFCP6Dk2AcJGORxd6UVD/hNIShpuEageD5
        cmeG/DJBDbg0QFd4V4zOF4febC0V6KknIcOD4Ui9k/k0W60=
X-Google-Smtp-Source: ACHHUZ4IYFt0uz8+tza/aIHhSCeywECUwa1/9uJMB4LSAzXKH9mhtpzGUr+u8B8sdTa/mQ3oYUcUhYHHWfqvrih+ezs=
X-Received: by 2002:aa7:c710:0:b0:506:fcd5:6159 with SMTP id
 i16-20020aa7c710000000b00506fcd56159mr5683003edq.21.1684422258413; Thu, 18
 May 2023 08:04:18 -0700 (PDT)
MIME-Version: 1.0
From:   Fabrizio del Tin <devotedmystic@gmail.com>
Date:   Thu, 18 May 2023 17:04:05 +0200
Message-ID: <CAMzNfvPpi9GiFHf0UcBpS8oozg6o_s3wwzOAPJ0FzGy7LaC4pw@mail.gmail.com>
Subject: Realtek RTL8832CU compatibility
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,
I got a recent RTL8832CU
(https://es.aliexpress.com/item/1005005544770386.html?spm=3Da2g0o.productli=
st.main.1.78ff96c6qceFKn&algo_pvid=3D9ee2eb8d-9883-4709-90f5-0dc6d98c40da&a=
lgo_exp_id=3D9ee2eb8d-9883-4709-90f5-0dc6d98c40da-0&pdp_npi=3D3%40dis%21EUR=
%2161.26%2130.62%21%21%21%21%21%402145277316844042289821012d07b5%2112000033=
481930568%21sea%21IT%211918944861&curPageLogUid=3DOMcZ7AW58cDB).
It's a very affordable tri band usb wifi 6 card, which is sold as AXE3000.

I tested it on Arch Linux, kernel 6.3.2, to no avail.

Once inserted, it gives:
0bda:1a2b Realtek Semiconductor Corp. RTL8188GU 802.11n WLAN Adapter
(Driver CDROM Mode)

After an eject cdrom, it gives:
0bda:c832 Realtek Semiconductor Corp. 802.11ax WLAN Adapter

I wonder if there will be any plan to make a Linux driver for it. The
only tri band in kernel solution seems to be the Netgear A8000, which
is widely available, but very expensive. The ALFA AWUS036AXML cannot
be found in my country. And there is no other option.

Thank you,
Fabrizio Lanza
