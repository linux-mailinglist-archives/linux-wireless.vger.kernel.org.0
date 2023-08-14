Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC18077B5C9
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Aug 2023 11:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjHNJxF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Aug 2023 05:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbjHNJw7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Aug 2023 05:52:59 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312C6A3
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 02:52:59 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1c2bf6bb0c0so1926869fac.1
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 02:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692006778; x=1692611578;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2s7I+Q0c17IJ/xIF1umxjjBFhJoEcH/gOtGkrvqe2/k=;
        b=SHtDid/evm8vVbCxI5enAtb/mZlL6k51WeW1RxNZ9CBfvd33D4Zos1rkdnM9h8L9Gc
         NZ+ApF88tqIOFjjPdRxTUIv5LLxTH9NcCBoL6K+stAO9fzVMEvsKF2X1iDt8n6zNQiR1
         lNECVs0lBHD2bkqywnV9ysS6McZRknp9rtkZvywFSpO7MwiStv2+pAxulXt7bnHlL0KK
         f1ZXZkvZLshhvWYjhjmJuQozwNqnD69N3kAFLlvX0qKu2zvr2NfJqjh1iOUDRM7oGqcc
         x0Lf/ve3626zTZuyODqSSXK9QN9ds2hk/xuOMskZLPRiSjT/pkZnqnwv6UqROVBOTeqW
         CE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692006778; x=1692611578;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2s7I+Q0c17IJ/xIF1umxjjBFhJoEcH/gOtGkrvqe2/k=;
        b=X+dUHstLbRIqbJKxXJ8pS750W28qFGrrDeQt8cYuyXKQ1BJej6qvQcet6JtiGdJPLJ
         bPYZKlSi2MHZmAjsWLPxFXdgA09nYBtK80988Yw/P5dMtznt279fNxoEZPXDcdK4wn0T
         hjvnBwHDAJoUHAOfumpuim29leU7GQorusfvzqGRsuE51R/7ep6+kVkWtSDueukSRhcn
         0kdJO0O9fwR/Ka1yDan9Vz2gnIIFBShzko6obiF42/6q8TeGS5zZTmwZdJG24Mf4QZ04
         0IZQi/MJ64x0fDCGAFZi12toYgkSVxFRlAzokBRtnNMbyNQgVKYirvff8jH3hqy/p749
         H8yQ==
X-Gm-Message-State: AOJu0YxLk8QMRDQ/8y7u0Ww22kkTbU8/v7WmnuNvh9h6N2rXew5XQbMg
        sPHaud35fPzcduWGphoCzbA2GTuqjeXM3ko01zW8Q9pd5a5YrA==
X-Google-Smtp-Source: AGHT+IHCxrXuhOHGLNBlV1nTTT9NYqUSJ4bNuo2HVwnY3EMYo4wEIB+hIXruHL51wLcfh+Bkg5Iv4ZfO1MRYRYzafwE=
X-Received: by 2002:a05:6870:9343:b0:1b0:7078:588b with SMTP id
 j3-20020a056870934300b001b07078588bmr8236929oak.34.1692006778405; Mon, 14 Aug
 2023 02:52:58 -0700 (PDT)
MIME-Version: 1.0
From:   Emmanuel Mazurier <emmanuel.mazurier@gmail.com>
Date:   Mon, 14 Aug 2023 11:52:47 +0200
Message-ID: <CAOc87ak7jOQDR5njcM-qTn6XFq_w6p64uVaiXpNtBhLp-_NGeg@mail.gmail.com>
Subject: rtw89_8852ae : failed to recognize firmware elements
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,
After a Debian 11 update, new header was installed : 5.10.0-24-amd64,
and after upgrading rtw89 firmware, the driver was not recognized by
the system.

Dmesg error :
rtw89core: loading out-of-tree module taints kernel.
rtw89_8852ae 0000:09:00.0: not mfw format
rtw89_8852ae 0000:09:00.0: failed to recognize firmware elements
rtw89_8852ae 0000:09:00.0: failed to setup chip information
rtw89_8852ae: probe of 0000:09:00.0 failed with error -22

I have installed the firmware-realtek package too.

Do you have any idea about the problem ? I can't use wifi for the moment.
Thank you for your help.

PS : I've created an issue into your Github project
https://github.com/lwfinger/rtw89/issues/266

Regards,
Emmanuel
