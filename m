Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19367CD6A6
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Oct 2023 10:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344703AbjJRIeO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Oct 2023 04:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344691AbjJRIeN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Oct 2023 04:34:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE92AC6
        for <linux-wireless@vger.kernel.org>; Wed, 18 Oct 2023 01:34:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5DFC433C8;
        Wed, 18 Oct 2023 08:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697618051;
        bh=ItZbsx5rjZBBJaips/za6Qp1TpT1tQ6Gk+GqI7+4Qyc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=C7N6mjYPnSzXbJuLTvu34JS8I1dAhDXlI8DFnQ8NVEXru3dLfK95GlRV6fV259JRR
         wcCZ2Tw1zXxOcqzMXrpjykpDFl1olNuzWtDzJYEkYCBL78X0v367vGI7R5OIHx5o8g
         Bowj8/gTtS+3ynbxurwhVVybRjpUAEyFASWLUsaKlBXYgKd2fmdb8GVKul3cqR/4Dl
         5id321FZ4fp9P72w+E7y1LcjLJ3FVO+JzL9DeLHyLYRMpUlzpVoRLfPe1VyKb1XhVc
         bG6uJ4Ob2B42vFenE7nTiU+tw7zI1I1u4gBGqTR5pWpkC8u+PB20pjZg+m/Tzr0PZa
         2SPAJ0yob0WSA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath11k: rename the wmi_sc naming convention to
 wmi_ab
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231014032650.32605-2-quic_periyasa@quicinc.com>
References: <20231014032650.32605-2-quic_periyasa@quicinc.com>
To:     Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169761804880.48072.5715328837742123686.kvalo@kernel.org>
Date:   Wed, 18 Oct 2023 08:34:10 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> In WMI layer module, the identifier wmi_sc is used to represent
> an instance of ath11k_wmi_base structure. However, within ath11k,
> the convention is to use "ab" to represent an SoC "base" struct.
> So change the all instances of wmi_sc to wmi_ab.
> 
> Compile tested only.
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

265c038ac9c2 wifi: ath11k: rename the wmi_sc naming convention to wmi_ab
2e66190e0d87 wifi: ath11k: rename the sc naming convention to ab

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231014032650.32605-2-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

