Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8339371583C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 May 2023 10:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjE3IT6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 May 2023 04:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjE3ITp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 May 2023 04:19:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA50410C
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 01:19:35 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5147e8972a1so6635266a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 01:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh.com; s=google; t=1685434774; x=1688026774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yct+blJyddmlgzq/6V7/zpY66Xis2osuomoldczLeo0=;
        b=Qe4IR/d/014/xzh6ZLl19csHPxEnzgylVEmxzpbuIThRwYTfyWAGb+xq9WaSCPUtxP
         DG5cS1LWHYaoZIEFZUSJo7gPmScfZfh4irQRIqQzINbUTPs45qvH40SHBOt/O51vYg4f
         Pt9OTX303MnyLX+yFDS7uPfix7m+400U91m7tyHs9DKDiUDpqhRixjqfqTRA3AEc5LSg
         1T3l1+vlCICQ+X9wl6Ps8Fu/l5V8n4gDSdxIYq1WeAQo+29GF8tatgM7QFMd1Tmu6+SS
         XMdzsPIco6oAR+6RGiT8B15geipOINXkje7TlZRxZ1O6QnuWenm+lcmp3R4N7bUGindV
         UXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685434774; x=1688026774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yct+blJyddmlgzq/6V7/zpY66Xis2osuomoldczLeo0=;
        b=gkdbIzro9j7PEprp19hJBUXl6Vt19jX8BsAaApTS/5FsHL8loWlwK0iSTlbx1p9RQh
         2m5HNrOHVnnJL7lszqvRRHNGiWRWoHXNk3JetF06XwQB7U/gbQvw6p24dDE4vNWAfn43
         4CiUcr2Nb+BTkFbrbEoXWSlZysNqIRu1/niWYL2KcZy0t6f2UFJd/Yv08/8cI0XoD325
         g1cydo2S/BAmyIwXyFzutmQdWAUC4ENgutMjiS67g06QlwpZNNkgAbos05NxLHZ1QqYW
         0+tEFH822WyWFJaoL5VjbaW3UrT4LWFjWqT7yxCJgaz9oHJo706Fw1SQo5s5unZ/CF6h
         wsAw==
X-Gm-Message-State: AC+VfDzZW+SMkjHN1ziC0b+s7+LPdsDoeSRUUWxkpDUCdg36KTIB98g2
        QTYfB+aFPPLrGLzD+YI0HUlntyWp55GQjQotxH4eSh29uKRkiHJZ
X-Google-Smtp-Source: ACHHUZ5pcF6ydtdCIcjYsop1XcXbeF3wrQj/fQCRRw4Z6c7/4aCBuDqZonUNtez1Y18GYu6xLv+JwHDKRxf9g5K127A=
X-Received: by 2002:a17:907:3e01:b0:970:1a15:62d1 with SMTP id
 hp1-20020a1709073e0100b009701a1562d1mr1774343ejc.34.1685434774110; Tue, 30
 May 2023 01:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAPh3n823v205C-_JAYz84MqUiEVPe8rsAy2Cpc39f_MsJrsnYA@mail.gmail.com>
In-Reply-To: <CAPh3n823v205C-_JAYz84MqUiEVPe8rsAy2Cpc39f_MsJrsnYA@mail.gmail.com>
From:   Koen Vandeputte <koen.vandeputte@citymesh.com>
Date:   Tue, 30 May 2023 10:19:23 +0200
Message-ID: <CAPh3n83NZFXh25-KN8XQ8VGuPqWOiBx6Qg_HNSWkm9Sf_EnovQ@mail.gmail.com>
Subject: Re: ipq4019 - Coverage Class not supported??
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Ben Greear <greearb@candelatech.com>, quic_kvalo@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 30, 2023 at 10:10=E2=80=AFAM Koen Vandeputte
<koen.vandeputte@citymesh.com> wrote:
>
> Hi all,
>
> To my surprise I noticed that IPQ4019 wireless (802.11 AC Wave 2)
> does not seem to support setting coverage class.
>
> According to Ben Greear, the qca firmware seems to support the
> PDEV_PARAM_TX_ACK_TIMEOUT wmi command.
>
> Does anyone have a patchset hidden somewhere that adds support for
> this WMI command?
>
> Thanks!
>
> Koen

fixup Kalle's old e-mail address
