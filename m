Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B85B71580D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 May 2023 10:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjE3IK1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 May 2023 04:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjE3IKZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 May 2023 04:10:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5EEA1
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 01:10:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-970028cfb6cso810326066b.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 01:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh.com; s=google; t=1685434222; x=1688026222;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F9gJK6nB5+iLowZowoZRoup6Cy3QKyEMYy8JBOQnARk=;
        b=WELSbhQJ3KVN/NbDTJiuG0iRdyi7ljHKYCVmMz1dNfHdVlc6zpjF3+N6iylGW4ko/e
         qxzkRaay+wDL7Zk99Fa7JLEurqnbRvE6gYAOL9gdxRwEQQOJ+uSDcdZTJOb6F3b6/y6i
         tYaZ8vPbHT0alTABiD0OrPbVrHR/qyGFk7f6/kDM0IAQB0gRM9QhzV3BhvbUQFanVw6i
         zZ5MWNKqZrdvn+PqfEONDthDL9bDgxOUap4dGCATbz3nr5O0J53OJfR2VqVsFh9HDR3a
         MVFa6fn/uW8G/f3XMYimDE7j9YGx+lCd8AI9HZsbUKLryC+zWyF2nbbuCwkHotsMEcrq
         dseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685434222; x=1688026222;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F9gJK6nB5+iLowZowoZRoup6Cy3QKyEMYy8JBOQnARk=;
        b=MLeRiTLkTyeONdmj/UovuPsIDFE5QOeb4qRqWoxCXG6o8KmYXWMk3M/gyXI8ybhrIa
         IQ/FUxgKAzytPwfsXL7wszS2MRzGXPntf/D225Nc1KbeLsbARo7v1a1x0Aun8m7FlJXx
         uErij1yxVbWIiiuuV9goSQywCDuCYmJ7hN6RR5aWKr7Wr0JxQn2EsJYbmDhUtb++qQbg
         CEQPFymzk0NWzFeoA5FFUS/w5EeiEKO2OBwoyVhI7C/BjF+MnUMHA31TPd6XYjAci/kG
         KeUYZCHHs97xQn4VI2OT5KMKtkfe9EQUWU9sETvnrCaCilIJySqlNDQfl1f0IqBNHK5E
         6lJg==
X-Gm-Message-State: AC+VfDw5/ALlxsamY5k0qxdaqzEwl6e7DYfyKjBe1rQG/cZQcTb0gYd1
        0BjKqbz/ASADljV5I5+8EgqLdBYeB7IvmjC4tc418Qv/pbTGTKX29pk=
X-Google-Smtp-Source: ACHHUZ7I+o/MqxB64tKWDUoaVVH2m5ZfG6ZymgkKGuI6+hpc2fU59JzNKln2HH12HsT6G/T5d+R+kaWKKRiE9NwgB3A=
X-Received: by 2002:a17:907:3f14:b0:96a:4ea0:a1e7 with SMTP id
 hq20-20020a1709073f1400b0096a4ea0a1e7mr1721162ejc.50.1685434222346; Tue, 30
 May 2023 01:10:22 -0700 (PDT)
MIME-Version: 1.0
From:   Koen Vandeputte <koen.vandeputte@citymesh.com>
Date:   Tue, 30 May 2023 10:10:11 +0200
Message-ID: <CAPh3n823v205C-_JAYz84MqUiEVPe8rsAy2Cpc39f_MsJrsnYA@mail.gmail.com>
Subject: ipq4019 - Coverage Class not supported??
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Ben Greear <greearb@candelatech.com>,
        Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all,

To my surprise I noticed that IPQ4019 wireless (802.11 AC Wave 2)
does not seem to support setting coverage class.

According to Ben Greear, the qca firmware seems to support the
PDEV_PARAM_TX_ACK_TIMEOUT wmi command.

Does anyone have a patchset hidden somewhere that adds support for
this WMI command?

Thanks!

Koen
