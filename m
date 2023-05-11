Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195D96FEE80
	for <lists+linux-wireless@lfdr.de>; Thu, 11 May 2023 11:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbjEKJRJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 May 2023 05:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbjEKJRI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 May 2023 05:17:08 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5DEAD18
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 02:16:28 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f13d8f74abso9387972e87.0
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683796586; x=1686388586;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=W4ijP0WCsURdUxANIREmclypPKCGC1MUfs5OjyImC/hcpcxeK1/kXOvsTrwEJv/uKQ
         7HOPu8KCBDmUJjSZdwkVBmKMLj8vKaPpVufG0xslpmalh5A9G3/ywDJGUN9YyXyQU54e
         4GLsjHNatTV6ZbgaS2Dl1g484VHkROKIkNJwoiAYlguGFcvC6LEjTRCnoF8nl1ghh+01
         ZaDPtGQvxXeE1+6+17/d8j32HoilHlIyQNOlcnLGIMYLm5SqU2TOCP9gwSm/mA25XVtt
         eCIG2FV8opVgms9tXuPiSB9P5+G6GLT91Frsvk/OFW4LcL/CSTxdhqvjKdp49xStWlNR
         3oHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683796586; x=1686388586;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=VMaisFts+pX1LssZQe0uaol9wgPYIrxookwdeCxLvHP1xCYllGG8l+Mq8TAsvWuPK6
         m8OgfY8X5OEVnbR8yzcxUNmzScW76P2DV5VXcEjqCub5WpL7MktUKSOWwFAd2ZKyb4Sj
         IVHwF+UIGbx3O5IzVBc9FxA7x/m4paJBydRDJn+vfINvcQi7TQ3R9mR42dJsFMCkRn1+
         K0yVQNtDIPbLE6IDWsS7ynlkVOx/vOOBIxg+PYunCtFJ/fzZjZTXGewJ2jZ2PkbO80AN
         QOdgDfNOCxan6+xG6Y4skV1q41lYbMTpJO7D4Im8SqQ70Di/7cCpRZQjq6RbxP6DGxLq
         IL2Q==
X-Gm-Message-State: AC+VfDwyhrwRjnBznYhMsPa46lfFijBqRoFwB4F+qAQhQ6gzO/u3NdMT
        yVVQiENPD0HevzHNyytwGfHcMnzfxC0cY/v2IDYDwQG8dD0b6Q==
X-Google-Smtp-Source: ACHHUZ6MzKrsgCg7b5g/jMP++4h8Opw3TxRh0cKMvE82y30/SXMUXNre1WO6MtokukwRuTZtq6Xuuxb8kkZ+hkC/+Jo=
X-Received: by 2002:a17:907:9712:b0:967:b02c:b06a with SMTP id
 jg18-20020a170907971200b00967b02cb06amr13626962ejc.27.1683796565707; Thu, 11
 May 2023 02:16:05 -0700 (PDT)
MIME-Version: 1.0
Sender: welsondahou@gmail.com
Received: by 2002:a17:907:3188:b0:961:b0:3e0f with HTTP; Thu, 11 May 2023
 02:16:04 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Thu, 11 May 2023 02:16:04 -0700
X-Google-Sender-Auth: eyBKHwOv9NjOKu5H-pufWEf59xs
Message-ID: <CALG3sDU_o4gOwv-npnEKnmNDEPOLp_xvHgNMi8p_PszvpnNpQg@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

My name is Dr. Lisa Williams, from the United States, currently living
in the United Kingdom.

I hope you consider my friend request. I will share some of my photos
and more details about me when I get your reply.

With love
Lisa
