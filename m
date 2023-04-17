Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F656E4F91
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 19:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjDQRrI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 13:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjDQRrH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 13:47:07 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0E86E93
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 10:47:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id q23so56887783ejz.3
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681753623; x=1684345623;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftUK28jNeVbZI1YwnxbSCR+OUeG4rzKxSuPLKinIHUU=;
        b=rGQ+7vUD/ahMLXanrMPXH1HprNU/cZEbztflAzWShO9fgFun9OaHI5LBHP7jbix6jk
         L3Ed5cZcvWzqhiJmAkb6H/H/4aSd1s+XyjBVZHGKZwjU4l+4J8dz2FPr8sOV8xxFuEOa
         0u0OseRsNufJBy1YpR1jupLeJfdMR3JfRP2YQTTQZSBc457oo8omEKUcktMYCBsZ61kH
         zEbHhspbg/dJ9WKKBeSEZdgLYCu7L3yOHe4nNyh9IwPBgWPIB/RtC0ZaOhybx4+SpDaD
         7duJoCa8fitSwg/sQVRfD6C9YPgfVbe4F+fAOJ8ZvyuKA+o7nKY4Wpcdbr3O+klND1Ns
         PrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681753623; x=1684345623;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftUK28jNeVbZI1YwnxbSCR+OUeG4rzKxSuPLKinIHUU=;
        b=BU5GTS5Yp8Zy7BoUR/gxGKHBfx4u03MMgGiESm2SxAft6nWZ5MReVC8xAVN2gv9Jhu
         ekS+cwCWjUXNQT0Z0iYCRpO0w3dayQOClLhoL7fxYiD2A+pmNQLpFqsP/A/J27OC6fye
         RhH0adYH4/39weHXjCJIS7ZFz2iI0phPfr1MHPp83+RKPoRTznyP/nwMgopPVsjt1VBf
         0tA7mT0EXUAkqKXkfw8c4hn6r1W0WfFmlMFSjaKW5ipwcDzOSbc3Q42o1K/X3SsUY6Oe
         b2zoSd44hzUIorWOC45pDnodgCca11Yi5eoo8Murq5pL3TQuyKsNzIhFYgGqPaT9qLBk
         v1sQ==
X-Gm-Message-State: AAQBX9es0jzMkuWFG6sd94uRDTNuquYsQ/eFHYZ9c6admA4474mjbQLa
        IJ5qlmU5U2jigmURqOULzq+oJrVDDzlhVdYWGkU=
X-Google-Smtp-Source: AKy350Yllvj8kI8iCCbPaPRdxSeiRmIye2XtCjaBxnecaa9g5xfkxOyf0KghyfCy7x1dwZU9rlTfjR9gxo1ZRZjuSyw=
X-Received: by 2002:a17:907:6e24:b0:94f:8aff:c8ab with SMTP id
 sd36-20020a1709076e2400b0094f8affc8abmr1554990ejc.10.1681753622751; Mon, 17
 Apr 2023 10:47:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a98:8c84:0:b0:1c6:885b:bb8d with HTTP; Mon, 17 Apr 2023
 10:47:01 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   Wormer Amos <koumbandiayekouba@gmail.com>
Date:   Mon, 17 Apr 2023 17:47:01 +0000
Message-ID: <CAMcBcCVbrdYKJstsVCSAZPOAwmhKGhZoLDJhyDwSQC+NHpQyXw@mail.gmail.com>
Subject: FRIEND
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Good friend i want to know if you are capable for investment project in
your country. please i
need a serious partner with good background, kindly reply
me to discuss details immediately. Thanks and awaiting your quick respond,

Amos?
