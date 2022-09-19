Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998AC5BC0CA
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 02:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiISAZO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Sep 2022 20:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiISAZN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Sep 2022 20:25:13 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ACAE00F
        for <linux-wireless@vger.kernel.org>; Sun, 18 Sep 2022 17:25:12 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id fv3so26252815pjb.0
        for <linux-wireless@vger.kernel.org>; Sun, 18 Sep 2022 17:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=YzJqPzVuilQeGohzdkMn+VGYUOZPh6MaV/QdCYS4vgU=;
        b=Jh8PjuoL5WIfWiERGjbbqckeMJA8QpvkBOH5AQSgWt/xUlaPDGZ66Dodl+W0+p622O
         qHU55g7NE2IjVhRFqBHgIEZM3oTfY6/tMBzuifaBLIxLTTOmen0CQxKW887q5oEQ4Gf3
         Pz2oZjmqVa5dcoJMAlKEUL0acQikq0eS2pLPJ82ZtojCMkVeQr6LbpqklPgiwBIh/npo
         CGwBbeL6xILefCcsL8IIPkO5K0r9OiQ0HAGsgnWTgBLCXj9MNXn4PiGIui7l+hkvDt4g
         I8qbktjGNcqGB2s4Rk5iuqmowuidggbmrMi4y2RNI623MA4hob230FXlFRU9Dzq2Irv2
         ZihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=YzJqPzVuilQeGohzdkMn+VGYUOZPh6MaV/QdCYS4vgU=;
        b=ScFGf/A0yUbk9+NiBRWohxmAw3cVgJ+KSty4qcX3f7lzESnFtQSruV5xkhMNWbxCVa
         +fxA6dLr/z4pk0baUj+yqvY2mqefUO/zrB+i43n5NI+HBY2JxsF5RpANDPFlZKE7fc2s
         QZvLHa3DQlDc5D6ZX7EvmefP5UPFMO1xdisFXQu9R5MDdKr+IWDAUgd1mW+6wWqT+oRA
         iRBuSJqY/jQVNLZmaIO9rzmaTR+uvcwtfoxRk8Oa/LTB9RGn+qzBzQqwqq0h2j0sM9zF
         Yy7bC8uGNlqcBqeh+mTKzFckouxaxXgBEa69wM0CWBCpWXUy+PsAuysWO8P+pedwSsqb
         bOeQ==
X-Gm-Message-State: ACrzQf3Q1DZgGYFL+Zj9dERNqgA9segh0lnn6idbrEX23FBOAAm7irxt
        GjNrWBkNPLAn0lbnESGq+CeCXklnMMDr+OpwBRfLx5Wx
X-Google-Smtp-Source: AMsMyM6Y9/Np5ywdqRYaqVFCN8dHUhq0Ym/UqVUKivQjIcAKQNYeuIMrKEpN8OcoYqccQJj4J8QKz9wkqgmQvtP5i8I=
X-Received: by 2002:a17:90a:be10:b0:202:cdf2:56a1 with SMTP id
 a16-20020a17090abe1000b00202cdf256a1mr27588397pjs.41.1663547111414; Sun, 18
 Sep 2022 17:25:11 -0700 (PDT)
MIME-Version: 1.0
From:   bommy985 <turkenlurken@gmail.com>
Date:   Sun, 18 Sep 2022 19:25:00 -0500
Message-ID: <CAPwNHCEZWzpW=Ov5ymuSnqipDwKQpyhq1D2+u6cyOaLbapqN-A@mail.gmail.com>
Subject: wifi problem
To:     linux-wireless@vger.kernel.org, Larry.Finger@lwfinger.net
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

over the last while, i have been using your rtw8852be linux driver
which started working again...
following an update to your driver on github, your driver started
acting wonky again
by that i mean it did the same as it did before your revert in the
makefile, require a virtual connection/hotspot(kde) to be made in
order to show networks, let along connect
previously this also made it extremely inconsistent, but now it just
seems to work fine, i just have to make the virtual connection thing
happen.
i am using endeavors on arch 5.19.9 and did a git pull following the
update, and also have a backup of the previous perfectly functioning
version, if this is important
