Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253986DAA5F
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Apr 2023 10:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbjDGIq3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Apr 2023 04:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjDGIq2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Apr 2023 04:46:28 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702938A79
        for <linux-wireless@vger.kernel.org>; Fri,  7 Apr 2023 01:46:24 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 60-20020a17090a09c200b0023fcc8ce113so816867pjo.4
        for <linux-wireless@vger.kernel.org>; Fri, 07 Apr 2023 01:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1680857184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPTOv+DM05W9cwzt4Rn6d40o6lDSVUKnb5CZXf5ma68=;
        b=t0xrc+Cp6MW2p4iU5zgQemwCYxUNSfY4cv7WDB6gf07DuFGCYh93zENZwbrnLo9dsC
         r+eS7uQ1aBMsyM0yhyeybMgGqjsn/Ael3qahzCXv7eBC5qVEkKL53LDvPsiVlT7IUyB+
         GFVl8A/z5mX1ArxYqS22J1WauUpJeskPBmenfIbr4TVWHKpC4LRTyfWhZ44H4l+Ahq/6
         dXl3F8J7Sgw9wchV/dEf7Dn31rV9fttzosi9R6WRlZngAjQMfvlOp9bYWavXN5OhQZQj
         R1fZ7U6AWUHactCojlLjvXndsnZq0SWairDbmkRAOTWlaIB3VZUAp2o87CaR0TJZa/LN
         mleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680857184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPTOv+DM05W9cwzt4Rn6d40o6lDSVUKnb5CZXf5ma68=;
        b=1Yggrkt1jxliYY+H6JeRAnjSRHreYVrAWoYfDOyGNrXfBjnNaPHo+3/nPoCokUNlan
         kHvjJsI44HqzY77TXDBSGbdxf9wbKGXd0CLqRAX4llwz/K3Rd9C95DFs884qCNJDbIPA
         9BOOTSLnNm7P8I7QXILdY/TNbuuCPTwLvcEDbHdr107lRrErC3HrJnEpJCdK8pf6v/ab
         LsLJh4XlwpC0VlCEVaHeGvgzv2/Xq6rmq6A6OuWjGvUb/Q5uq6AFdp879/QCI/k8kvyT
         XkIxDxASIbbnggN7oPHr9FwwUkzhmmOFIGeH8TGLw6rz4WME94o2qwAYHKfw6lof2VRu
         E/pA==
X-Gm-Message-State: AAQBX9fMRKzFWdm8vJzFXOBcdqF6qp6OaxmT+4rA7flqKhTG10/xdlSH
        pGO7wgUUUAT0AKkcBohXoa+fICMMcVcAQz9bBGXKyg==
X-Google-Smtp-Source: AKy350YK3svQRM/ARq1iX1PPvnHdA4GcRtLaWISk+R+u99hfTCEmNf92dd6JNrVwxifscGK4ozIUeOezNPqlnwg4ciY=
X-Received: by 2002:a17:902:e5c4:b0:1a2:87a2:c932 with SMTP id
 u4-20020a170902e5c400b001a287a2c932mr680426plf.10.1680857183942; Fri, 07 Apr
 2023 01:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230320133840.30162-1-quic_nmaran@quicinc.com>
In-Reply-To: <20230320133840.30162-1-quic_nmaran@quicinc.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Fri, 7 Apr 2023 10:46:13 +0200
Message-ID: <CA+HBbNFXkOqFr9cKmB+Me3q4pbR31u5d21EuCCUnos7hGQi9RQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath11k: Fix invalid management rx frame length issue
To:     Nagarajan Maran <quic_nmaran@quicinc.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Bhagavathi Perumal S <quic_bperumal@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Mar 20, 2023 at 2:39=E2=80=AFPM Nagarajan Maran <quic_nmaran@quicin=
c.com> wrote:
>
> From: Bhagavathi Perumal S <quic_bperumal@quicinc.com>
>
> The WMI management rx event has multiple arrays of TLVs, however the comm=
on
> WMI TLV parser won't handle multiple TLV tags of same type.
> So the multiple array tags of WMI management rx TLV is parsed incorrectly
> and the length calculated becomes wrong when the target sends multiple
> array tags.
>
> Add separate TLV parser to handle multiple arrays for WMI management rx
> TLV. This fixes invalid length issue when the target sends multiple array
> tags.
>
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Bhagavathi Perumal S <quic_bperumal@quicinc.com>
> Co-developed-by: Nagarajan Maran <quic_nmaran@quicinc.com>
> Signed-off-by: Nagarajan Maran <quic_nmaran@quicinc.com>
>
> ---

We hit the exact error that this patch fixes while updating to FW
2.9.0.1 on IPQ8074 and
it fixed it so:
Tested-by: Robert Marko <robert.marko@sartura.hr>

Regards,
Robert
--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
