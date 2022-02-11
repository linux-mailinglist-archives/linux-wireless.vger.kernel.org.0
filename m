Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1AF4B2638
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 13:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350279AbiBKMtK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 07:49:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347452AbiBKMtJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 07:49:09 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4635CB3C
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 04:49:05 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id f41so9126619lfv.12
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 04:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=fFvC1/uFaw3Ncnny40z//EW0pxQDJo7y163ZRLt2svM=;
        b=XEENqCbBn6E6/yU3tS9pD/cDt+Xd8zcNTf6gJ4F4q4nrIyE68iUCkJ0iIdFxfqOtlt
         ZK+Blae/ipaBwk9do58BzvKvWyTp4YptLP4fqRkWxWXgJ3sR3OPjLe8C62KCT7pqI8NR
         aE/rIJ4kYiL+amNiSHMdtuyVVs3XbND/qQg1Qcl1i77NP1eUGqLbeNf3AJIe58KpXBKU
         7WF7Ck497MSl1X9sktbCJkuYAu+5jspkR4QVFrZMMDOC6+LPnor8phq6zotUlSpojHd7
         +sXpOfhQRUTB3N8wtRTWsNIbuy6dn1+8OIw8DBhqMXH1gC2zAiKzGtDnOMhaCskdbXGI
         j5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=fFvC1/uFaw3Ncnny40z//EW0pxQDJo7y163ZRLt2svM=;
        b=mNNuhn6ojAiOp+q6gUx6JUf4OK2EE3/Igvl7Ssdjz1rv3kDBXRcNEXJzcovYAqKJYn
         6d5VzfS99WgpjIB3353ob3dimX2fGxzuym1Won4AmlvVehlz5VjDL0UBtbLgfpCxpnQ5
         EtIYP2P0triBQN1tt5vyPcYmEneouF9FiAMPdkscQa+7xYlHDRUypNtL4vLARJQpKNz7
         bHZ3nBkcJkB3Zw67OVbZMMdlJ40RRWCsAC1AyvD09d9+XBC8m6ddeZE+Oq6hAWoiYOet
         RInMcZM2XT9BdXUZhx0+AzVvwY8JD5aQ2l3j2UVBBIrmMZnUsyDmFVYEpWzhuQWNG8Dx
         ZhgA==
X-Gm-Message-State: AOAM532l7DvOTDG3rIk9st1UoVGnY0uLddLrzIyJCODJmX2n8C9v6k3y
        ha5GNAo0uVyZf/QtpdVEkVlBruY1Xtn2Yg4HUyU=
X-Google-Smtp-Source: ABdhPJxE3Arc5pjfpNcAUn7+AcLJn7Tlv1E+K/7o121ulUJG6peD3BDpqsYUIe1l55+iBW3rhZHMbWkGg/awAoG20Io=
X-Received: by 2002:a05:6512:3ca9:: with SMTP id h41mr1097611lfv.503.1644583743604;
 Fri, 11 Feb 2022 04:49:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:a7c7:0:0:0:0:0 with HTTP; Fri, 11 Feb 2022 04:49:03
 -0800 (PST)
Reply-To: alexandercliff11@gmail.com
From:   Jeremy Graff <tchadjobowassika82@gmail.com>
Date:   Fri, 11 Feb 2022 12:49:03 +0000
Message-ID: <CAMThso3WUtgBsJ0oSa3xgt2jzysRHkobuKk5fXr76m9RFkOhBQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNCLAIMED_MONEY,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:129 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tchadjobowassika82[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tchadjobowassika82[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [alexandercliff11[at]gmail.com]
        *  2.4 UNCLAIMED_MONEY BODY: People just leave money laying around
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is our third notification.

UCAFF is  Unclaimed Assets and Forgotten Funds department in Nottingham
- England and our duty is to dispose unclaimed inheritance and other
claim cases. This is in accordance to laws of England and Wales. You
were listed in the last WILL of a deceased COVID-19 patient.

A British Attorney is required to process this inheritance in your
name. If you do not have a resident lawyer in England, you may contact
Alexander Cliff at (alexandercliff11@gmail.com ) He is a legal attorney
and capable of handling such claim cases.

Thank you.


Jeremy Graff
Managing Director
Land mark House,
Experian Way,
NG2 Business Park,
Nottingham NG80 1ZZ
United Kingdom
Telephone/Fax: 0709 288 4838 (UK)
http://www.unclaimedassets.co.uk
