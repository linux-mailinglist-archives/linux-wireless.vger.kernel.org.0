Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA02A6526C3
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 20:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiLTTIF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Dec 2022 14:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiLTTID (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Dec 2022 14:08:03 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44955E0C3
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 11:08:03 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y16so12740674wrm.2
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 11:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=A+aO5+uSh0O7dpkxd56ACzLt18XNTvXLc6UxjycHhF6o82VqMhnPqmKQeMB/w60n7w
         mxjcO3FEOPq4+/cU9SGkalCcCqnO6zBQww+25D+3fQCOKm1+CvvRi+/yJpm40njecEtO
         mjyW07AEIt1wH/1UJonfD+StjDAoeVFlkLhlJenCqtRU8CT7UYLG1mkaM5BrFrt532uQ
         aCu4/Yrsr2COotCV7+QZQif/q7ygGs8LBd8lYlYOlDEgNBnCnu+7svr3ofi/t9iaEGy8
         dvBs8XRbH9aq5YRbnk7+zq1A+sWHS/Z7ESHX1b9+TDAa64m8bu7A9qaQ0P8daoeM8mzQ
         lzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=Z89crqtsXl5B80xkurBTRVCRJvJ/UnPbixh77MDZ6CSspd+A7oHp9BEVGC6g4Zoz0s
         0614rUOsw4YJPyUZv0s6ARl8/eZALeJhGxcTVyFZxLiyv/NHKOObNwZyjGRAuDLmXn40
         tOY8SHvAcQylwayNZNoY/+nJLw/iHohYGdn8y+KmJ7t7pP+G6p+/CVkPK3eeiHM2sZea
         fyajzZ7GXxLaM0zQCaVkHjCic5XFAiEsBe7EUb4vqgsyoToNRqVy+n1OAueIzsd0VMCg
         M6nSUFr2Igir8K0CeJqFDyPq/JkHHVEUUk+vglJvYDPH12ShksrSQelhtRk5S1RMRtut
         N/TQ==
X-Gm-Message-State: ANoB5pl9QnuTfTTvjbc0SUW53fZDd4/N+1Gxd2CPKIVJf5vCIAL1a2Dx
        oVdIcf35p00WXY0fVWoWZSiUQ17e9cEkT1AbNko=
X-Google-Smtp-Source: AA0mqf6QEditEKCwq3gTGUksuPgxN/lvtVZLybeXeQQt64QqV8iwAoTl2DGu9MVLCMhGQPAJo3C+a0PULOX0qJhWk2k=
X-Received: by 2002:a05:6000:787:b0:24e:ca7b:abcf with SMTP id
 bu7-20020a056000078700b0024eca7babcfmr1239070wrb.638.1671563281525; Tue, 20
 Dec 2022 11:08:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:adf:e30c:0:0:0:0:0 with HTTP; Tue, 20 Dec 2022 11:08:00
 -0800 (PST)
Reply-To: ava014708@gmail.com
From:   Dr Ava Smith <avavaava9090@gmail.com>
Date:   Tue, 20 Dec 2022 11:08:00 -0800
Message-ID: <CAL0WiVU14P1OW5PckPZ5S0aMXF_tU=Z3RUFa1JQh=T3q=-ELoQ@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
