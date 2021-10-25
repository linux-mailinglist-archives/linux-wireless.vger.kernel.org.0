Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41488439B5B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 18:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbhJYQUf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 12:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbhJYQUe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 12:20:34 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91078C061745
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 09:18:12 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id o12so23347123ybk.1
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 09:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=c7r+iG0WMd7AWl7dPkc5EUVopsJJp5wZ17J25Xe2Rt4=;
        b=TAu2bvYKnLhssXNWX+DNT7gCYf8oltlM2c7TkLUeX+EIW2l5KTaaaufpJenv05CSXB
         FbHq+G/6y7rwKaBYHE0awwhft9ZG2aGD/1D9QIdoo8pThN3g0ujZlAZZkIIIRYhiT/+2
         OvtTmgdzHktEAd9LYwFInVJMaIWa5FEh3mnyYI0uVUx1uR7OWurFr5nnE+pB+qzsjE1s
         8Zu7MVr/epZJ4m12Zrm55S83NUCF6F+1hgusdlumphxx4MeSQh/Nb6gDgXFpjJzX/cxk
         mB0l+8UNkzsVScvJVYU9fkXCSConsEzvX0VckaNz9Wkru1EtWJ0nfM8Rp/qMWCU853Qi
         AzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=c7r+iG0WMd7AWl7dPkc5EUVopsJJp5wZ17J25Xe2Rt4=;
        b=l4OeiRQBHioc6TDgujrmVCtv/TgR4JJDLk2UamhU6dvhxfM54G3N8Ywls4YILMw5RH
         ei0afz+e+clg7bG2zCdsIpKp0nGvNRHyb9/qSMmh6c5fgaajEYtHnKo9L+c+zfwg3TEp
         UKwH5jlN/p74ajZj17RM3Y3/6kE/qs5bTtm+XrmWAlNvw7q4cm37rkP7sQLqJytEh80V
         xk8qzzcnV/4uHfSfvK+cJW06/RTTfDk7TuTMgz+dMe6Zz1ZPs+GRJVDreKX9QxyhcerP
         NrZ/Dd5rBuWJnAx8S/Q3fKZaSrfEx+fg+mNtny222mRfwXelJzR8GC6e0Bq6fP/T7YF9
         RrLQ==
X-Gm-Message-State: AOAM531mU2k8ZImJoZb00deo2Q0pJpTr+Lff21ozgNCCvH9WfmWHW2dk
        hnN5CkxzfT2U/Ld9TevxUFaJZHLmEQyjKC2MFxPG3Hur22Q=
X-Google-Smtp-Source: ABdhPJzQ3ht3i7xq48MHJTwyr2E/+azpnxTdke4EELf4Axb98jCWDo/MSMgZBorGaHFLnXpwSyydUWoRRXYVv4aHHWE=
X-Received: by 2002:a25:ac56:: with SMTP id r22mr20065432ybd.485.1635178691823;
 Mon, 25 Oct 2021 09:18:11 -0700 (PDT)
MIME-Version: 1.0
From:   Sipos Csaba <dchardware@gmail.com>
Date:   Mon, 25 Oct 2021 18:17:35 +0200
Message-ID: <CALQr=E_0srRWo=N0Rt8kieyW2ufaWT1CLhkZDsC6mDuDFxEfVQ@mail.gmail.com>
Subject: ath11k: regulatory issues with ETSI countries
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org, robimarko@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear Kalle,

I tried to draw your attention to a regdb issue via your github page
(https://github.com/kvalo/ath11k-firmware/issues/8), and as that did
not yield any response, I decided to try it here as well.

With Robert Marko we are investigating a regdb issue, where the regdb
rules are applied incorrectly for the ETSI countries.

First we checked the BDFs for our test devices to make sure this issue
is not an OEM fault, like a vendor failing to produce a proper BDF
file with correct regdb in it.
As it turns out, the BDFs contain a completley outdated and grossly
incorrect regdb, which is an OEM fault.

But we also found out, that even if the corecct regualtroy data is
present in the BDF for a specific country, if the "regDbRegDomains5g"
rule is marked as an ETSI country ("regDbRegDomains5g[].dfs_region
2"), then the WLAN-firmware overrides the BDF rules and applies an
incorrect set of rules to the wireless interface.

We tested this theory by changing the "regDbRegDomains5g[].dfs_region
1", and converted a single ETSI country to an FCC country. And voila:
the BDF rules are applied correctly.

Example country: Hungary:

country HU: DFS-ETSI
        (2402 - 2482 @ 40), (N/A, 23), (N/A)
        (5150 - 5250 @ 80), (N/A, 24), (N/A), AUTO-BW
        (5250 - 5350 @ 80), (N/A, 24), (0 ms), DFS, AUTO-BW
        (5470 - 5590 @ 80), (N/A, 27), (0 ms), DFS, AUTO-BW
        (5590 - 5650 @ 40), (N/A, 27), (600000 ms), DFS, AUTO-BW
        (5650 - 5725 @ 40), (N/A, 27), (0 ms), DFS, AUTO-BW

Please note that the last two rules are not in the BDF file at all,
the ath11k driver is not sending it to the firmware core, yet somehow
it gets applied by the firmware.
Please also note, that the BDF does contain a 160MHz rule for this
country, which does not get applied.

So even when the BDF entry is correct for an ETSI country, the
firmware apparently adds incorrect rules, and deletes rules present in
the BDF.
And the result is incorrect and non-compliant rules for ETSI countries.

This issue is tested and present with IPQ8074 and QCN9074 for sure,
maybe others as well.
In both cases, tests were conducted agains
WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1.
ath11k version is 5.15

This is how far we are managed to get.

Please let us know, if you need any more information, or you want us
to test anything. Happy to help.

Regards,

Robert Marko
Csaba Sipos
