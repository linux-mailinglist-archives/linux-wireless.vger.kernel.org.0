Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A2F75810B
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jul 2023 17:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjGRPgJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jul 2023 11:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjGRPgI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jul 2023 11:36:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9451DD
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jul 2023 08:36:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b9ecf0cb4cso35540395ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jul 2023 08:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689694567; x=1692286567;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46Qd00mqgwhkkW6amCqEXLEzCc/q28cqM0GW7xvshDA=;
        b=R3hbh38cuvLrCtUSLTR8JtErKRR2fIVcj0bNVFoonKuYB5n1xZZZtY7CEtR8Knq6bl
         3E1oRZqQmYUTb3/1sn6602gtx5WKMdwcJBOgpAXQGyxH/edIMT5jttMRZbparBoGuM/D
         tuUDwFd61p72vbN84OUfQusb6mzJDYBroRqhc/PBBjHwBrb+esKDN5fNcOaSwPC9B5ix
         07BEUVvZiEkpTYxkONld9frmC1wWwnw3Ns/1cDuli3Kpq/D8blNUoVVy7D5V62Txkvmy
         GN+weOBd6h445+iWh2JjSorEvVdpGdR86Jqy7NXmpOyGN47svUPdkdS/uJcBatZVApk3
         XO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689694567; x=1692286567;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46Qd00mqgwhkkW6amCqEXLEzCc/q28cqM0GW7xvshDA=;
        b=aKH6dF1nrvTlrzujxS+bc1l5iruhtumCD9/W4wM8rKsRFO87a4ivgbhcUtV5e/tA6j
         wjCQWMhDGJC12vcB+3llw8YPpgH7MqD49nhSASQbsFeDXnL8rn73oQ0RWKa+gXg8yDr2
         qrFTjj3vTn6rTgWD86QUkj93hlSWhKpY7L6QYnH9MAluRW70UYIbc2HQv3IcumvaCs8h
         mnVK9OmPfCgCOPXLYye6BBgtZDSumzfZtMNB9qFWR7Dv/mp2EotHQjjC4Bf3C5v9fo9F
         vh2iPTzB3kYe2oCyS0mmFEHlCiL9V3JbJtMhkwS09yepSUMHL3O4JHEmgYUNlHuWHzTa
         c5Fg==
X-Gm-Message-State: ABy/qLY0Tqdl2+zD6QdIm2h1NIz/nmLNsf0ZBlcS1Bd2QR7c5SJcIU6N
        qB4AcXmWDDjZOtgclgp1FoRXiM93tpZFqY93AnU=
X-Google-Smtp-Source: APBJJlFVeBZddoMAxnlve5aothXWcgQ+Zp1dXzWjsRzCMYKu50xCfZVVqDE7gn7Ea32g15qCtq+d6fsxanTkHhjNuzs=
X-Received: by 2002:a17:902:820f:b0:1b8:9551:a705 with SMTP id
 x15-20020a170902820f00b001b89551a705mr76367pln.55.1689694567192; Tue, 18 Jul
 2023 08:36:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:902:ce88:b0:1b9:db41:6e6b with HTTP; Tue, 18 Jul 2023
 08:36:06 -0700 (PDT)
Reply-To: lassounadage563@gmail.com
From:   Ms Nadage Lassou <nadagelassou@gmail.com>
Date:   Tue, 18 Jul 2023 16:36:06 +0100
Message-ID: <CAJ97MqTo9trhvvyyGL9OrYvbf44sgSAvZwM4QQ+_p7q2LkMnzg@mail.gmail.com>
Subject: IMMEDIATE REPLY FOR DETAILS
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:635 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5341]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lassounadage563[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nadagelassou[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Greetings.

I have something important to tell you.
i will send you the details once i hear from you.
Thanks,
Ms Nadage Lassou
