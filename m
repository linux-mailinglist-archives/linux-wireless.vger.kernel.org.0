Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B8D7AA0D9
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 22:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjIUUtD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 16:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjIUUs3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 16:48:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB19979E11
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:34:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A873C116A8;
        Thu, 21 Sep 2023 08:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695283335;
        bh=A2wDMxQ/CgRduFurU/x5XEPPz5f7IpyK+/xPd1NPnFc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=r+BLK+3dG66LnrsnSmxtrxbszEVM4dLwRjhjhKeCDWX9JLeX4NFVcgtySnK47744q
         yuVT+mVv9ibi9BfXbeuiOeu1EGabqueReEIdUBs9EdYScxKmUnMS5OkQFZlsw4PxDe
         a78RE+8RqqSbNXyFExTIIYyrmzQ3il0C5zFsN8Bma+to/ZsGHX2eGbyoBduwwnKu1W
         PUrZYfqQyLm/iEVB0WNNWQGLU+LBWJzUJTJDuxrTbRcA0hyuodR3w9UM2P7p0lDK4H
         xVAiXXiGZ3Es9c+BIjud5wBI1hhsA1ILTktGLfBc89SFj8HZtdE0Yyo+AY/3KzWIiN
         9GKQ2Zzyf02qA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix possible out-of-bound write in
 ath12k_wmi_ext_hal_reg_caps()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230830020716.5420-1-quic_bqiang@quicinc.com>
References: <20230830020716.5420-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169528333260.1539628.5137606082787828430.kvalo@kernel.org>
Date:   Thu, 21 Sep 2023 08:02:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> reg_cap.phy_id is extracted from WMI event and could be an unexpected value
> in case some errors happen. As a result out-of-bound write may occur to
> soc->hal_reg_cap. Fix it by validating reg_cap.phy_id before using it.
> 
> This is found during code review.
> 
> Compile tested only.
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

b302dce3d9ed wifi: ath12k: fix possible out-of-bound write in ath12k_wmi_ext_hal_reg_caps()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230830020716.5420-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

