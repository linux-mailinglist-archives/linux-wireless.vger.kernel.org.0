Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76726DE62D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 23:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjDKVI5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 17:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDKVI5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 17:08:57 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973EF40C1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 14:08:55 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b25so311182ioc.7
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 14:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google; t=1681247335; x=1683839335;
        h=mime-version:user-agent:content-transfer-encoding:organization:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnWwfaTmj/AdrfC3bSbt+3Qvi9EwEtASP7Vxc60qFwQ=;
        b=qabpwg6GuH/Zhx7R/BnbqfPabOFSawUngoe/ByEsT3I8IO7VWYkIeDdAB6kheXiSQt
         pt8rr4X1yMsivZFmtPmVsgQ+zraL88Fq1kOZav8gAF/mbG4BoB1u7UkrRXWDqA8S+KA4
         vCmUB97CjBDv5xYAtPqj7Kjusr72JXQCiYMor358qF5ajKirIhsTGRvk73MUy3Ei4kxC
         ekpv2EOUsBHO/iE8R2luCGsGDQA5HIbsG1rFn+Z/ygPo/LLT5jCdqcX+b1VlOZaKIeGu
         OfDcbxNrMQFagtJDb4DGbHPlcxNVIMSrQtJ96ycTNIebzOQlXUQ3lGO222Mc+Bz/B8rG
         v9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681247335; x=1683839335;
        h=mime-version:user-agent:content-transfer-encoding:organization:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pnWwfaTmj/AdrfC3bSbt+3Qvi9EwEtASP7Vxc60qFwQ=;
        b=M9OdEKVDLu0KWkR4h95VGkSqzq+4nQtC2yy/5lFwt212S0r65RYmf5uwxRZxSyhK/8
         UOhSbm4po2ByPXjF3hRRmqgU5gGDkbURj5X2O4qSDweZD9xnV8/5KRtdwLcxJE2wAQFx
         wUn70uVooorsCU4rx62WYlVcrCqahnha7NyI0/s1uxJm4kBDnkxAWSN7QEaLynt2IKeQ
         A9uJbSfW7ndghd3LfPXIfsUeQjFHY+za14MNglDzbXFI3jDzpG+W1BL+UPX+IkbnDlv1
         8TScxhVmPWtxCPZxqRQQ62Qi4hiCHbtng2jQ5WsMICNBd1MHNwPedrpWBpaap8peOEWb
         awIg==
X-Gm-Message-State: AAQBX9d5DZ9iLnRxxhPk+9Y2840w81g9nQqlBP15Vsvs9UEV82W35Ye3
        OxRrcGRCVYjrCMe54uCJRM2D6gPkpR4Hc9CAww==
X-Google-Smtp-Source: AKy350YkqKvVyJoVqRaChPYHNsHre/XheY7/hYRwhRJa8p53G/a9Bid3DaFqBXesHgnkMKoM5vEuoQ==
X-Received: by 2002:a6b:f40f:0:b0:74c:bc54:def6 with SMTP id i15-20020a6bf40f000000b0074cbc54def6mr9862272iog.16.1681247334879;
        Tue, 11 Apr 2023 14:08:54 -0700 (PDT)
Received: from [10.1.100.16] ([76.130.90.80])
        by smtp.gmail.com with ESMTPSA id c95-20020a029668000000b003afc548c3cdsm2254614jai.166.2023.04.11.14.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 14:08:54 -0700 (PDT)
Message-ID: <e4cece9076cc9a5a4e4dbfa258a828eaec97e1af.camel@egauge.net>
Subject: wilc1000: AP mode issue
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Ajay Singh <ajay.kathat@microchip.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 11 Apr 2023 15:08:53 -0600
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ajay,

I'm just starting to investigate an issue with the wilc1000 driver that occ=
urs
when it is operating as an access point.  I came across this thread:

  https://lore.kernel.org/linux-wireless/87pmkmylex.fsf@kernel.org/

and was wondering if there has been progress towards converting the driver =
to
use the nl80211-based TX/RX interface.  If so, is this something that's
available somewhere or could be shared?

Thanks and best regards,

  --david

