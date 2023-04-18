Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B58D6E5D0F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjDRJLS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjDRJLN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:11:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7555FEC
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:11:09 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-24704a7bf34so1754089a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1681809068; x=1684401068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KJp5Fs4I3X3Lrnwpv87MvZSqBNI8Q21ROLa2nrRB3jM=;
        b=liz70RhSEvUJBQDlQJMNJJgwY1MWaLTzc/8x03i1tcoTUCi8meUXBI0A5bk8Yz7Mb8
         i1WfhofrtvM9Z67JA0aGjPW2bLpki2kC/sQaw/rNu/CMNm6W2441/uRkUIS5rzb26xjq
         TCu+Tnvi478FcDxqw9ghMYZv74s5S3Q4f9hiD9QblK12BB2LkDSc4+KiRx+6c90qTpmW
         lOV9DISfeWmh+K4NUivEDAdQSEre/p2VnLy8JkUJ8Xgg4iTLcumq2f3uqnjiBVIcCVlh
         arscxd8SAmF11hilDiZTbySotfDeMwsaPD99Ktoep7pB9dtoLJee6ibCZ1sGtHO0o4Md
         XJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681809068; x=1684401068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJp5Fs4I3X3Lrnwpv87MvZSqBNI8Q21ROLa2nrRB3jM=;
        b=KkEWY0QHd0zIu956QEtMIuY/lLhmYoziw6wMV1mm1G7x+7PWfPoBgVDhkjN7TBGJVm
         zDR/ugUl8PzKl+MpYCtTDWULyo73PxEeLDxNaL51iw9ZPG/uxTg5S2YeGA6vFZWeT19w
         3t0SALT2RwZU5HbcpZ8qo1NYzuDXf/cY5QtTCsXofS7SvedY+nZVZj55LxQIa1AnjE+r
         0v5VHQikAqqYwR5seEO2lLf9BONLoVsLIt8vnvzfJzax3/QHbebqXgLDNmbUbG256sCp
         29M4bJng/daapzj41rB8JKXSo7uXrhAoqliIuF7064iDTbbxtAtBz93USE2yW9VKa8Xz
         8PrQ==
X-Gm-Message-State: AAQBX9fqaEX+utSPhuKsZE/sDjwbxQ2jCynQXDr8TBDrhX8ecsOgpGOJ
        +/BrutLHM5iGE2PADF3ucgJ02hrZFqqyB2VHNSx81A==
X-Google-Smtp-Source: AKy350ax1Ty7pe1kRJRSklKhtb/9FVN3xE/4WR/MxW30SOZ5Db75pzvm/9eQ/URjR+jDmCyyRgfPd1+ankwBBk8D29g=
X-Received: by 2002:a17:90b:1887:b0:247:afed:6d62 with SMTP id
 mn7-20020a17090b188700b00247afed6d62mr1302455pjb.46.1681809068563; Tue, 18
 Apr 2023 02:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <1666128501-12364-1-git-send-email-quic_msinada@quicinc.com>
 <1666128501-12364-3-git-send-email-quic_msinada@quicinc.com>
 <CA+HBbNHw-0+Ty_-masxGKwT6ju_EBxT3n5B0Ygcn3XzQi_CzWg@mail.gmail.com>
 <87fs9ndh6s.fsf@kernel.org> <CA+HBbNEaNTkUv_UPgQievxaLya0XC6=AVj0=GWiH+qB9=vRZHg@mail.gmail.com>
 <87bkkbdcfu.fsf@kernel.org> <87pm8iaggt.fsf@kernel.org> <BY5PR02MB6164BAC2A418B3C5462C2C348F9B9@BY5PR02MB6164.namprd02.prod.outlook.com>
 <87mt3b6nz6.fsf@kernel.org> <874jpdwo90.fsf@kernel.org>
In-Reply-To: <874jpdwo90.fsf@kernel.org>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 18 Apr 2023 11:10:57 +0200
Message-ID: <CA+HBbNFTfAXWw-39F=ov8Omg6qKWvVJtWMC00+N8a9GP8Jo06g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] wifi: ath11k: push MU-MIMO params from hostapd to hardware
To:     Kalle Valo <kvalo@kernel.org>
Cc:     "Muna Sinada (QUIC)" <quic_msinada@quicinc.com>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Anilkumar Kolli (QUIC)" <quic_akolli@quicinc.com>
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

> Muna now submitted a fix:
>
> https://patchwork.kernel.org/project/linux-wireless/patch/1681762947-13882-1-git-send-email-quic_msinada@quicinc.com/
>
> Robert, can you please check it? And if it works a Tested-by would be
> nice.

Hi,
I already saw it and gave it a quick test, for me it brings up 160MHz
and I have requested some more testing from other community members.
I will reply with my Tested-by tag.

Thanks for fixing the issue.
Regards,
Robert
-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
