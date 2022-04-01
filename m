Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F984EFB73
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 22:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348282AbiDAUZl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 16:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352331AbiDAUZP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 16:25:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04F428D516
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 13:20:45 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r23so4320622edb.0
        for <linux-wireless@vger.kernel.org>; Fri, 01 Apr 2022 13:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=ukaFezxMjVHBPofWtHqqegH9HEBwuSTDAvfztYoh1mA=;
        b=jNef0vERtUnpnv3Lzj632pItsW9jxBFLGHk61mfYW9xhxPqggXayZVdGqI/qYiykGg
         BndCgst5s74+HtYKy3nivfm5tCcXtA3KiH50Qvt9H0V3S4onTjIokyYTmviFInfj/7m/
         xyJXx9yxA+R2OKGC0FR5DLe5tEmHq7KUu3kL97zzA0YsyIuKmM23n/AjpPuyYJHzzhzH
         CIihu9RHh2N+DHYxH4htgGnpGcSFXH2AZUNS/x1Bwa4qWl6/+VYgjxahSpF0mbQZZZfJ
         Nn7wsph7ELEI7+7zL8sIEiW92tq7KYiCqxZbCTVlAaY1PSO80giR3syoSnptOb4LwFko
         rOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=ukaFezxMjVHBPofWtHqqegH9HEBwuSTDAvfztYoh1mA=;
        b=GO8FoeJ7QVTPT6xXHXbyph/isaXdkDGTmWcMrWoSbZ/1xBD8b8rwwAzlvP/xP/H2HX
         ZKbZN/3fMdmw6hJSsHC3ayTyV44oFrd9aO1EkiD1RvqhR54jaXDj+VG2OjqstU4O/NnM
         PdI9PSea93wug3/nFFoCkXklHtVAF8pYE8GvXnewio6zHc0lO3KZpMI+t3ybZ3LT1n47
         aymNWiYFcuKVs27Z8eRvs/LFb1BQV/ejHzeNyIUMCPi0u20uGr6xC8BkNZTan2jd6O+F
         Yvr+eAgrGvlro/3/cRXQIQ0XXCfAGGAlmcV50FVNWB1sdLeVAC8oJcQ8KxznfZ1IYS+i
         T8aw==
X-Gm-Message-State: AOAM531RnYJgiYxESZaCTiXHez4PspQA8F2kqKuOxI9dFlg8XItvn5c/
        F3+yTL/aLyWr6oqb/100EacMIjfXim4S+Aqpoqc=
X-Google-Smtp-Source: ABdhPJyAtEjkJKpb2ONXhDsUe9RjhqKSSFJpxi3iqhBWDUFusMYdXK3f5ODvMDA5BEUUqH9lkkF+PG+RVtZ9s4rrxHI=
X-Received: by 2002:a05:6402:9:b0:419:3c6e:b0d5 with SMTP id
 d9-20020a056402000900b004193c6eb0d5mr22831988edu.216.1648844444241; Fri, 01
 Apr 2022 13:20:44 -0700 (PDT)
MIME-Version: 1.0
Sender: soniaavis.ibrahim01@gmail.com
Received: by 2002:a17:906:2ccc:0:0:0:0 with HTTP; Fri, 1 Apr 2022 13:20:43
 -0700 (PDT)
From:   Elizabeth Hoisington <elizabeth.hoisington1@gmail.com>
Date:   Fri, 1 Apr 2022 13:20:43 -0700
X-Google-Sender-Auth: bPBWXw9BzPLWpdC2Tt9CxtlFruo
Message-ID: <CABm5ZOAXmGr-duGwwpO3NT4GNLJW=MZLgeKMTd6Rxrs=_W20Yg@mail.gmail.com>
Subject: PLEASE REPLY URGENTLY.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:536 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5598]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [soniaavis.ibrahim01[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [elizabeth.hoisington1[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  3.1 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

My Sincere Greetings,

I am Mrs.Elizabeth. David. Hoisington, I decided to donate what I have
to you for investment towards the good work of charity organization,
and also to help the motherless and the less privileged ones and to
carry out a charitable works in your Country and around the World on
my Behalf.

I am diagnosing of throat Cancer, hospitalize for good 2 years and
some months now and quite obvious that I have few days to live, and I
am a Widow no child; I decided to will/donate the sum of $ 9. 5
million to you for the good work of God, and also to help the
motherless and less privilege and also forth assistance of the widows.
At the moment

I cannot take any telephone calls right now due to the fact that my
relatives (that have squandered the funds for this purpose before) are
around me and my health status also. I have adjusted my will and my
lawyer is aware.

I have willed those properties to you by quoting my Personal File
Routing and Account Information. And I have also notified the bank
that I am willing that properties to you for a good, effective and
prudent work.

It is right to say that I have been directed to do this by God.
I will be going in for a surgery soon and I want to make sure that I
make this donation before undergoing this surgery. I will need your
support to make this dream come through, could you let me know your
interest to enable me give you further information. And I hereby
advice to contact me by this email address (
elizabeth.hoisington1@gmail.com  )

Looking forward to hearing from you soon,
Yours sincerely,
Mrs, Elizabeth. D .Hoisington
