Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E267465E9DA
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jan 2023 12:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjAELZS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Jan 2023 06:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjAELZF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Jan 2023 06:25:05 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18D4551F9
        for <linux-wireless@vger.kernel.org>; Thu,  5 Jan 2023 03:25:03 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id kw15so89208393ejc.10
        for <linux-wireless@vger.kernel.org>; Thu, 05 Jan 2023 03:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FocuR5aXn3z28LzYD0rCmA/t4By4lcIW0G986gs+i74=;
        b=EA4bh1/7XUr8fVUZmzN5CPy2iIpBdrJ9NKg4tTWcJXIDJaIx6HAttP9+dh708fWwkq
         Aa/0e2EDPoDwKzWN63ldOuTmgvyljrdb6yLOhsqBdTeGN5MjOET5AmmjhWKuKKCactVY
         MmqcIAgkicQmRUKROuaMIttTYyhrqIwj707zDR1jMB2T26rjpCNKok5aQPDmMK0+FYyi
         g5T3PNsMzYkgrMmk/SkpzN9UfVbQQR+IYr7XyQk858k5H7xP9RVJOomQJR9vqqAytmke
         F6xrGSDYUQuN1eEgqfyfIE8Y2Jl5PkXbpjw523MHdkVgIoXZwGJiZeVmv7yYEbEswM5+
         npog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FocuR5aXn3z28LzYD0rCmA/t4By4lcIW0G986gs+i74=;
        b=m1b0UwJaqRL1oEnVkp8L2suoFSX5ZpUBP5/vBz+1o8IxFEk2gjhJ9XxWFwLdtA2IyP
         FlDMJAbKA/LvREo23ANM0kd1Be9HMFMulKscbNtGGljYJ9SjWdnKwqO1ryPK9hyK9FdK
         qZuuhXxviSogxZJtPfBHaH3TOXTvZpvbH1D2AFC5b8A67KzH7JiayeSwsYIgypdLSPbP
         VNYow4h4XIDm70W1PU/7jRsJ/kL4j6o3snKSGCJvU24JYi2EcIJstRWnfBboJh8j7334
         7bcLV8uzYEiAN6oH9SL+VB85O7pSPkTQBhoaK6ObJmR/ilyeEoggWLMj+9OoVJ/eK8Ce
         ihGw==
X-Gm-Message-State: AFqh2krPq2oFEi7qS9+tA2Zbnq/t00+jKVv+zKs97Dc/DkODNNFsTNnt
        apuDEWPa4b09yJt4tP/8zcG2WQRY75CD+KT+0ws=
X-Google-Smtp-Source: AMrXdXvl99BA1XnyVDoSZJEcUEg43AJm5Qi9oxriJqQiOdKTBD2JFHf5Rcqw3HZdzxRIJfxA8q0oiAw3N/iPeGYaF/s=
X-Received: by 2002:a17:906:6845:b0:7c0:ea28:6976 with SMTP id
 a5-20020a170906684500b007c0ea286976mr3041175ejs.418.1672917901927; Thu, 05
 Jan 2023 03:25:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a98:c58f:0:b0:190:b6df:8a2e with HTTP; Thu, 5 Jan 2023
 03:25:01 -0800 (PST)
Reply-To: khalil588577@gmail.com
From:   Abdul Latif <anthoniushermanus1969@gmail.com>
Date:   Thu, 5 Jan 2023 11:25:01 +0000
Message-ID: <CAA=Ewk+Ygwr45TP+zf15xbVWS1jVS2J1R_9OzDGt9Wb_Ua3REA@mail.gmail.com>
Subject: GET BACK TO ME
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4995]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [anthoniushermanus1969[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [khalil588577[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [anthoniushermanus1969[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I am Mr.Abdul Latif i have something to discuss with you
