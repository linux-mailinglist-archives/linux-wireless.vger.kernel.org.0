Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77139736AD8
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 13:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjFTLV5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 07:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjFTLVy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 07:21:54 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC6710C
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 04:21:53 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-56d304e5f83so51339247b3.2
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 04:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1687260112; x=1689852112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dfQ3niVaGcWe3CQjn+06HwWkagYAmvQ0PFrIW9MH5sY=;
        b=dkZagKoNk7qH5HItxayVJ/GdY8MxAM1NWs2uOqaIEU0KBEA4ZvG02Iyzb4jdgA1Ymh
         tRvjCK5fN8vMVJreaWUK+oUanOhNaeJWvZQQJ/E1JG9mJCT64BX936ZXD3JmQnh26UI9
         fSad1kK7noc1ZRymZ6XGpRFZVB9wgdSsG4jLocnQ8AAlkgTvKGI/cVk/Ur4A0ARCJGXY
         /RR/EDpz6f3ESTHM/vH/FGVC89W65hHxFC8i37WAkxpKDaEMViAmrrxPdtw2hpote2uj
         wjJ2/gBzCFFZZJvDTcaEQBhavPfAuElJA8+oaUN81Qdkkh6RasH6aFadI2b3CymoqXIh
         9cBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687260112; x=1689852112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dfQ3niVaGcWe3CQjn+06HwWkagYAmvQ0PFrIW9MH5sY=;
        b=hLPdo8nkpIbHMLe67XERqxD84XbdGYB1zzaDB06AeAlOJ+7IKcAMbymHvtMxT3OfKN
         okX2z5K188UeQMuXe0ux2ZKdtkebkRgAEoKZMsF8my2zZ6hAb6ZvINtQJAGXljZFvw/h
         Z33JVrQJUB8U+eGBy0JnMWxsvSZW6Eq47qLJ6kjKxnw5ToFFruzwGoc5bCwURBvD00q9
         q0sivYYmj/uIpXlX4m7N3HqB9My6/SUPfklBcBsl5z3YyZrVm5o7kfxsnXZQMqjMWFdr
         7bN44JiwTaqTaayEqP6MPo0DkBS6nd0Aitftbmdke4hAzZAwV1vmvnATqkUvat70vWN8
         4dLg==
X-Gm-Message-State: AC+VfDwk6N4DG1M/vE4WxnHCS2tj1+wHIJX9hkAA7mDqCb47HWh0HMMd
        ZBt7Uy9dXqaL1ndJQAIkU2awuQHoiK5sqMADHvpo0g==
X-Google-Smtp-Source: ACHHUZ6TCTiLciePb3TWcbuXpNxVdq9lpTes2TguKKkhNfh9aJZUMfKfX2271vdu+AWYQFS5WibYMmGGFZ3+CKKmj3Q=
X-Received: by 2002:a81:c201:0:b0:569:e7cb:cd4e with SMTP id
 z1-20020a81c201000000b00569e7cbcd4emr12722225ywc.48.1687260112492; Tue, 20
 Jun 2023 04:21:52 -0700 (PDT)
MIME-Version: 1.0
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Tue, 20 Jun 2023 07:21:41 -0400
Message-ID: <CAM0EoMkRZE2XQcgzxt63jke1q4RVqrHBuw5rc5Pu0rGtW+Vz3A@mail.gmail.com>
Subject: CFS for Netdev 0x17 open!    
To:     people <people@netdevconf.info>
Cc:     "board@netdevconf.org" <board@netdevconf.info>,
        Christie Geldart <christie@ambedia.com>,
        Kimberley Jeffries <kimberleyjeffries@gmail.com>,
        Jeremy Carter <jeremy@jeremycarter.ca>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        lwn@lwn.net, netfilter-devel@vger.kernel.org,
        Lael Santos <lael.santos@expertisesolutions.com.br>,
        Felipe Magno de Almeida <felipe@expertise.dev>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We are pleased to announce the opening of Call For Submissions(CFS)
for Netdev 0x17.
This session will happen in beautiful Vancouver, British Columbia

For overview of topics, submissions and requirements please visit:
https://netdevconf.info/0x17/pages/submit-proposal.html

For all submitted sessions, we employ a blind review process carried
out by the Program Committee. Please refer to:
https://netdevconf.info/0x17/pages/about-us.html#committees

Important dates:
Closing of CFS Sunday, August 27, 2023
Notification by Friday, Sept. 15, 2023
Conference dates Oct 30th - Nov, 2023

cheers,
jamal (on behalf of the Netdev Society)
