Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51E76D6E03
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 22:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjDDU2w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Apr 2023 16:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDDU2v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Apr 2023 16:28:51 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F0E4214
        for <linux-wireless@vger.kernel.org>; Tue,  4 Apr 2023 13:28:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b20so135612036edd.1
        for <linux-wireless@vger.kernel.org>; Tue, 04 Apr 2023 13:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680640129;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5Ai8ftFGf/7qrHxBDCebvM00XXHdhtlOXD7WyAX9HQ=;
        b=NinAo7Q0gqjfveStoFSYKrA1C7yngObtds4g8+Sq5liJv9aLDdyjrG0J0C4RBMcCKp
         2rytjChzYw5cXadG5ldsLtgsxUafJbPsGLlzR4Xmg+2glRqCyuMnxcXh6zDw4W5ut0W0
         vrhwmz/0ChaVQQx9LmPwVyUOF9KMwBF5MdZgSsv0stGQ17PDw4xi5PK0oefE1YiMDkjU
         vSIr19GudN5U1jEiyDn/wsS088X6JLHZ7ozP58bwPHR/zDN4I3vx8L24hWL+q36rTDhJ
         De+RnS44H44CZrfZa1hvwflBGsZEN9G+Nuu8jMPLzqg19fFD2M5lhaK0z+eOYVBVZifh
         7dUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680640129;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5Ai8ftFGf/7qrHxBDCebvM00XXHdhtlOXD7WyAX9HQ=;
        b=bxvGK01W4QVsVAhzdN5gX3c7WSBsZcM51CoCykJk5uSUhMvLLmHbX5fkHp8l2bEF0J
         3i3kDljquSIteZOrYzyb4HVTDuttXdosfx9hxwFnwNuThgLRed7lBXU0Z+SrQA02fXnC
         3SQtfDhqIL7gAXLopwnil9Fz2yxG/PU91l9DkoFarbBecTTuCyJIrJieHEAH1jmZQ0vo
         5HkoG/KPqEbVna7wRQQ+efFGvdCL8u3NQCN1R07YyAOjP9Wmv2GYadDwJy6A/VNvpBR2
         2GjTqY33ejYlhAsfbbaB3PNwdzzATQ1z3PybSD7MBVfIdC2XIo3CFODs/GDCcp7JgUPm
         ypeg==
X-Gm-Message-State: AAQBX9dxjXSFPXCT/Lba7qLnZMXiuvb3ktO2t/jvbEr7gH2HkJrXHvY4
        cO+7JoLeSEvZSsVSauwCvmNpNuYXLZq/13HJefU=
X-Google-Smtp-Source: AKy350YbFou77oPZfvEJxzAi44gjuPdFEloWluPP1qjEscD0dKExtwV+Wz+tiK9ReaXXdbkhs+/mi4Y4ZYgWwJPzg44=
X-Received: by 2002:a50:bac2:0:b0:501:c965:33bd with SMTP id
 x60-20020a50bac2000000b00501c96533bdmr374208ede.6.1680640129463; Tue, 04 Apr
 2023 13:28:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:aba6:0:b0:200:7591:7c83 with HTTP; Tue, 4 Apr 2023
 13:28:48 -0700 (PDT)
Reply-To: nepk08544@gmail.com
From:   Leihservice <abdulwahabgrba@gmail.com>
Date:   Tue, 4 Apr 2023 13:28:48 -0700
Message-ID: <CA+KqsdPkwy_9gjcuOHcGmz2H_xQ99FarLR8bN6WLR=BxQV1cdw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
Holen Sie sich ein einfaches Darlehen mit einem Zinssatz von 2 %
