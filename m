Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1F76FDD68
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 14:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbjEJMDc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 08:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbjEJMDb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 08:03:31 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621055FC2
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 05:03:24 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b9d7659d89fso9210042276.1
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 05:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1683720203; x=1686312203;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uCim+bkRSF5TeAVtzxeNUFktZnXXPuGjUTKfTMY/2Zw=;
        b=hngiIEi69KPKqZgfHKZ/ulUvZQKAnVcBbnckq1EvJ/1mSnqfuuToaM0vXAxZ7R0uTg
         Q8lUEWD0zaY+yeLkR7PgImLYRvGp66qjGiWb3q3xWdWoua7YhgIo53s3B80rcLQm+Hob
         OHkH/5CX6nmqRAk9atkUC8OmBmSZbC2rWo0u9YA76Ea+VtcUIk9yrlcGMA90zbiwbtZz
         305ZKd0sUQXlnvt7EiAfBdm/jFq0bfgOt2diaZA3ykgTyNLJfQhipLbN/Y/ekImi0grm
         hSz9a6jcUhe3Z1xjzLS94px2bQyl7ULTgJTTXMF0ameajZ8TRD9MSDbv028DAARzva2K
         WN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683720203; x=1686312203;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uCim+bkRSF5TeAVtzxeNUFktZnXXPuGjUTKfTMY/2Zw=;
        b=K2dwiEymQaL2TSZTArVPDlj6dM9w3Wpe8GUqEXXDgEgUqdvZsOJcQh41kvN9VRXlwI
         P9gTFt+xcFfGMkdr+f8svO9l0j3FNduxLrd3zKi58JfZNMfYPUDfXSL1hYhuu9I/KGT/
         +hmsfXH0hBFCKz0LU+6zFFO8nEhnjJyBHlHl+5/c/Am5yJG9ez/NMKCN8X1EEN/OuLxT
         t+QZZVxGBkUNJfarM/rjwV06Hkrvnc3w8uPj10Px77rrzBditWVcDt5r42JwqUNnczZF
         YDRtX7C+3uqTqCuq5AnVCbbdtIlDLaBUuPfS+t71uqBTrwTyBqICpbauCWO+8g/zvNhD
         vT9Q==
X-Gm-Message-State: AC+VfDxi7onZQ+O45F0XuVlOtWdIBwYCsTHhi+kEh8Xprm4q4VXTpgfM
        w/NmoQSrOxn2ZQpOcyVYHzg0IFkj3hwJG5T3YJEZPA==
X-Google-Smtp-Source: ACHHUZ4DynBs8EVJ3L4HnyeLVH08l/L//dmkuGhVuP6Mi4in/UDseRJCC7BoEc8Bms3kweOiDVlhdDtglocsYXjiisE=
X-Received: by 2002:a25:2612:0:b0:b9e:3bea:ebbb with SMTP id
 m18-20020a252612000000b00b9e3beaebbbmr16897621ybm.60.1683720203247; Wed, 10
 May 2023 05:03:23 -0700 (PDT)
MIME-Version: 1.0
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Wed, 10 May 2023 08:03:12 -0400
Message-ID: <CAM0EoMktXKNL5YejPOuUqVW_kLudzy5t5R0MvB=H6RKzLwV8dw@mail.gmail.com>
Subject: Anouncement: Netdevconf 0x17
To:     people <people@netdevconf.info>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, lartc@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>, lwn@lwn.net,
        Christie Geldart <christie@ambedia.com>,
        Kimberley Jeffries <kimberleyjeffries@gmail.com>,
        Jeremy Carter <jeremy@jeremycarter.ca>,
        Felipe Magno de Almeida <felipe@expertise.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

This is a pre-announcement on behalf of the NetDev Society so folks can plan
travel etc. Netdev conf 0x17 is going to be a hybrid conference.
We will be updating you with more details in the near future.

Date : Oct 30th to Nov 3rd
Location : Vancouver, British Columbia, Canada

Be ready to share your work with the community. CFP coming soon.

sincerely,

Netdev Society Board:
Roopa Prabhu,
Shrijeet Mukherjee,
Tom Herbert,
Jamal Hadi Salim
