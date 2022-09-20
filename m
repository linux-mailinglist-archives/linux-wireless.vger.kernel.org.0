Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEAD5BECC4
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 20:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiITS2A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 14:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiITS15 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 14:27:57 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696CD5A897
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 11:27:55 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1225219ee46so5534287fac.2
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 11:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=VLHpTlUxZkt9kH53kYPMjLlddgmY+tOXvinX1a54hqY=;
        b=j5vcHW2VcYOUiIWQ0r+zRaE/yahILODLpVblijGtGGTv2vTtC/93URBCjUrOEgYAfc
         TIy5ahd1CZsdtzIeHEFa85wS1x2Xy8UPL+9gPwXZXFQBb6KWd6uuiuGFSmN7z6Z0j0rh
         jhl6vpWZezmA/EJmLlXQ4050EhxwYuNx9unqNMTkmsghBPtDJ3d04TGhnRvYmG30EjmQ
         vObq7ZrBwXVRjla4WYOfREcxAqhGFUScAEc6SMAPhyNFDXLNoDvh9wIg9AWMfxblCFx3
         YSa6oTIA9EUv305AahcgIlswvu1xFGcejchGmuQAJjm3bkalGGozmjU9KftRf6HyShg7
         Gz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=VLHpTlUxZkt9kH53kYPMjLlddgmY+tOXvinX1a54hqY=;
        b=W1cUAsoMR6TG6isnF5XP35MlwrnHn2/4RVqbh73LYdmmXf8OovKNHH2bzaV0eESXfc
         cas0lG7YsJhM+I2/H80eBHMPUf7xyxb4wGwNMYEk5ottV9LRCvPwyGI2G23S5F41LiQW
         4YnOufnQB3VzX6+72+LqzxX93ctecgM//2ufCDy/4gKxzUb4K5WhjTvu6U55++N+Ar4l
         Gf/RhJNeaGVDEufszz7Gd5yKuiY0jIeROQVKSLZy8Lksp6rBcnM/PsNRDv6epAShfcSa
         Roru29fqzsSslNr1L05g8r9bvzVP9sv5b5oAM3tl99V3Ai0PpjueCNpqQTDjxeQoIKDx
         5vbg==
X-Gm-Message-State: ACrzQf1VIBIVGLoiPpPoxMTY1PfxNzhXP4nwaUYh60KM19L25hVh0VXz
        504mC6GS4umskz+FeqQ6MH1ZrwS+pHY1RLJCsj8=
X-Google-Smtp-Source: AMsMyM4JgBx0ZsBLOVrNJWK7/De+JaNpSuzFOZE3Fh6IitwvUc/4wC+hT4OQceg/dAfMdf5ey86tIMHM2SXDfGKm9sM=
X-Received: by 2002:a05:6870:c0c3:b0:127:f467:b2b0 with SMTP id
 e3-20020a056870c0c300b00127f467b2b0mr2893473oad.110.1663698474716; Tue, 20
 Sep 2022 11:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220915043527.737133-1-venkatch@gmail.com> <238a21a8-c97b-5a38-6c08-9057055bf73f@nbd.name>
 <CABHL29H75U-0dBP14d-6ds-xMPt1eqrvQPuMp3oY8qQS8Y3Dbw@mail.gmail.com> <9acc4159-8223-bbca-a83f-d075660ac6db@nbd.name>
In-Reply-To: <9acc4159-8223-bbca-a83f-d075660ac6db@nbd.name>
From:   Venkat Ch <venkatch@gmail.com>
Date:   Tue, 20 Sep 2022 23:57:43 +0530
Message-ID: <CABHL29GB6DCrdu4FzRfBDSj9A7pwqnWE+wgH2xfkBMLjT3bAxA@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mac80211: Fix performance issue with mutex_lock
To:     Felix Fietkau <nbd@nbd.name>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        Venkat Chimata <venkata@shasta.cloud>
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

Hi Felix,

 Thank you. I browsed through the code. There seems to be sleep
operations wcn36xx platform.ath11k  does n't seem to have the sleep
operations in sta_statistics. We are using ath11k based chipset. Will
it impact things if we apply this patch for ath11k boards only as a
platform specific patch?

Thanks & Regards
Venkat

Venkat

On Tue, 20 Sept 2022 at 14:40, Felix Fietkau <nbd@nbd.name> wrote:
>
>
> On 20.09.22 11:05, Venkat Ch wrote:
> > Hi Felix,
> > Thanks for the comments. What part of  drv_sta_statistics could make it
> > sleep? I might be missing something. Please explain.
> It's just a wrapper around the driver .sta_statistics op.
> The documentation in include/net/mac80211.h states that this callback is
> allowed to sleep, and it does so in a few drivers.
>
> - Felix



--
If you rest, you rust
