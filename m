Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BB56BFA0E
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Mar 2023 13:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjCRMb7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Mar 2023 08:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCRMb6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Mar 2023 08:31:58 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B083D43900
        for <linux-wireless@vger.kernel.org>; Sat, 18 Mar 2023 05:31:53 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id y5so8322096ybu.3
        for <linux-wireless@vger.kernel.org>; Sat, 18 Mar 2023 05:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679142713;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pKzBdXMWa9cnE1GdXbpVVKMnsyiqY03UsLn2lJfk8Jk=;
        b=nogdILOlbLsy/tSWJuXxXIgcdF8sBPmY1OvxYe6jeUdQ5+Xb4X5PVy7zrYeNW5b8gz
         7ik8Oi/Z8YR4zmMnrrOamlUkEmKGSDJ/o5C3e0IsHldkSKSox1EvB2GO6YSH5tDI6DJP
         CEnPSv0Rg0TJB3S/wbXwqIkCuaaOa0LTahyAFfUUybHcEUweJcXGwZvkU6ZfyObalQkX
         hGK21AhwSIBcs7ItQG98XMBMnXXVLvQRefLM1oPIt7EhD5tw7FVWi/0GLDlFsVCfc3MJ
         8Ofry216bWBL31jBNgKVz9CfPYjk04BXqezlFuR7OilNpb1Q0Dt7ITKRK4nDIeYONUi6
         MNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679142713;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pKzBdXMWa9cnE1GdXbpVVKMnsyiqY03UsLn2lJfk8Jk=;
        b=td+WFSqN7EH/C0P5YWE64N9Y14PPxIeNdjxnuXHoWzaU6v3d5lIpeY4G2ufgR8qwc7
         ruyiuSrkg22EWi7OJNTCu/tnKFTJncgnbZktUFVz69Jz4K7+iCQGZFNN9a1/SrgM+tpX
         0D3XBr8nU6jpqsnB4G6tM4RNIVuaRzVb9y5uL6x70DsovgA1zCGELSrGlzc2SVCB7vuF
         RzmP5iP1GCDxatamLyIlyvXMwzUMXoOakwb7iRUnnx3vEeuSIFSixjTrNP+Uy8oVrsym
         2qXbvsjOZ0NMdnSod3QLegUxbkI8GNJoP93ITlP2vYeYkREfMbXn8yaglPqONgVmSIoz
         gaSw==
X-Gm-Message-State: AO0yUKXk955caSeQCUHr1MiwwPyvlqBmQItqDZjwdr/ZY2eE1Yp3CNuT
        B+kQTPkcGZD+528AgWOV9bosrzDygwxPpWFs0F0=
X-Google-Smtp-Source: AK7set+KY13AM9MZzlPHx0qW8uh42wpXNHmFpOycxfOILRXtWT8n4+BDxVGVKAswTohKkwD3wDkC8YXMMuTFzuh3bV0=
X-Received: by 2002:a05:6902:1025:b0:b3b:d433:b063 with SMTP id
 x5-20020a056902102500b00b3bd433b063mr954019ybt.4.1679142712742; Sat, 18 Mar
 2023 05:31:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:a05a:b0:484:8381:f8d2 with HTTP; Sat, 18 Mar 2023
 05:31:52 -0700 (PDT)
From:   Mohammed Hamid <ccapctg@gmail.com>
Date:   Sat, 18 Mar 2023 13:31:52 +0100
Message-ID: <CAFsXCBNNt+MpR3wBDks7E3PcOoBYkctp6qwRErKec9K3kWcZ7w@mail.gmail.com>
Subject: Mohammed Hamid-Ali
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello.
This is Said Mohammed Hamid-Ali, a Syrian. I am contacting you to seek
your support to invest my family fund under your good supervision &
monitor. You'll be compensated with 35% of the net sum.
I look forward to your swift response.
Best regards,
Mohammed Hamid-Ali
