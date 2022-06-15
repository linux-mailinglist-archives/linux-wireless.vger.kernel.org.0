Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFB254D15B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jun 2022 21:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350293AbiFOTKn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jun 2022 15:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239653AbiFOTKk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jun 2022 15:10:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3091C3EAB2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jun 2022 12:10:40 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v17-20020a17090a899100b001ead067eaf9so3055473pjn.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jun 2022 12:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=mOUcsCvIrFy8tiWWoh4CrRNkMo/aNJOiYjh2Xe/NoPo=;
        b=ZyvY9GLgghTu+s7LTgjUu80KTUgxbWHQ3WNEbwm+4Cr3YFrH9pwCWvASVo5DAFs23U
         rU4vtCcUuOI4FsXQO593hga6nZFELwYlubgOD+bGubncN0sxoZZt905ulOtV1gb4n+CY
         j7s/HgZVLLVzBW1Xo6p2PnwOwlBQ7ARLSNMmcV+IQbKiaeJpMzFh+PooKYO6jGPHWtDV
         gy8dXjrqyYdsH5XoJ+YdtLdT5CUf4foQ5BBPvV5HHJ4RPzw0JmILLIzMBdOKN0gAQW+0
         XL6Ci+/698S7w7SqU6Uk+Mg8wPWAGmgwCWAxYzxZVDLwEhCeR3gHTriukDJqm60L599G
         aGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=mOUcsCvIrFy8tiWWoh4CrRNkMo/aNJOiYjh2Xe/NoPo=;
        b=X3GImg6/8xIBbx6lTZzv8FOeV+JgbqYOrBBqWWzYjjBXtdpMm1y1RL3Eqh3EmO5eNh
         b75L9vYwT84GkWRDr22PGXCx8z6rU2uVVj3CE0UB+uGyVycAMWEJ0VQEepeTUK3Y3jfw
         cvGAs+6nVVAenANfnVX+GYGX5LbrZWuak70eKuRm/IhbEpuJv8qrj6zue9MnZtaLpWHm
         JskNT2vR+XWvTpGHfQD66cP5heGH8NSrhJvO2TYLz5IglxqYMrXHceTQpAaWvO7gTm3g
         +qtPlHBYWRjcDfAWQjnbka/nNfY5Pi5VhMjSiPYg1Hp/u/Pcz1GJYrqZdfId1i//t30N
         QUEg==
X-Gm-Message-State: AJIora9V1cqQBiyAb4cpNlrU8vP7mNe+jZJkFiHlryxfN4LpwdVLGlLj
        E5mk+yGKiguUGU7dZaVhp6QeKcdhEpv1RKGKGPk=
X-Google-Smtp-Source: AGRyM1uIUJEq8P7ErmLOpUInB4EQ9aPakj6wcLIyPl23PCelF/Dcvqb8nT5790hO/3TqdLoVTqJoyMMVpxWOgmfil4g=
X-Received: by 2002:a17:902:d490:b0:167:49df:6e37 with SMTP id
 c16-20020a170902d49000b0016749df6e37mr1131389plg.50.1655320239445; Wed, 15
 Jun 2022 12:10:39 -0700 (PDT)
MIME-Version: 1.0
Reply-To: salkavar2@gmail.com
Sender: jabbarqasim809@gmail.com
Received: by 2002:a05:6a10:afc9:0:0:0:0 with HTTP; Wed, 15 Jun 2022 12:10:38
 -0700 (PDT)
From:   "Mr.Sal kavar" <salkavar2@gmail.com>
Date:   Wed, 15 Jun 2022 12:10:38 -0700
X-Google-Sender-Auth: qQ6CDrqd1vOmg9u9yT82Xxg6MLE
Message-ID: <CADq0RaWaZsZY+NvNor49Wh4MF4=bKsZf8NrVbGu91zCMcWFFeQ@mail.gmail.com>
Subject: Yours Faithful,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MILLION_HUNDRED,
        MONEY_FRAUD_5,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I assume you and your family are in good health. I am the foreign
operations Manager

overdue and unclaimed sum of $15.5m, (Fifteen Million Five Hundred
Thousand Dollars Only) when the account holder suddenly passed on, he
left no beneficiary who would be entitled to the receipt of this fund.
For this reason, I have found it expedient to transfer this fund to a
trustworthy individual with capacity to act as foreign business
partner.

You will take 45% 10% will be shared to Charity in both countries and
45% will be for me.

Yours Faithful,
Mr.Sal Kavar.
