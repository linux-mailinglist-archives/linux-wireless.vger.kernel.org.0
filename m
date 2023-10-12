Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C024D7C7207
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 18:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbjJLQGX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 12:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347322AbjJLQGE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 12:06:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735A5CA
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 09:05:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11669C433C9;
        Thu, 12 Oct 2023 16:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697126759;
        bh=0TlcdU2OQsnqZNwSF/TbmRxff0z5OtOe3PDAchLyUY4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=bBIgfYGLCrKFDDZeCFrPxO3rDG2w/1HHKNdYeWv0d5c1Wtr8B41YTW5jKLK+jXaGS
         dDYALoQe2a5f9pGkLGA3OHQ5EU9sva2gXLx4QIOd18Vun8dfxs9bkwlgUtGlLQadcL
         iECsoPWAmhefL00EK+n88EebxOHLEafK3nDnsgLGSyIoD6lqpVxGX9kC7OdqhXIYbG
         DzEzsje5C3S/C6HcuFCg28RXi3R4HEyn3ycxkOg85kfKSqC8OGfdz88oEegtaCRoK/
         p4UGhgZo+h5VSgtdFUJDOICjcN6zY2KZn/zevrfvvpK0cM0XV9c91JSg9SQOyQ7KxO
         lKhB4gp7u55vg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: add parsing of phy bitmap for reg rules
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231004092818.25130-1-quic_adisi@quicinc.com>
References: <20231004092818.25130-1-quic_adisi@quicinc.com>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169712675583.3501995.11017953895035699214.kvalo@kernel.org>
Date:   Thu, 12 Oct 2023 16:05:57 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aditya Kumar Singh <quic_adisi@quicinc.com> wrote:

> Certain regulatory domains could put restrictions on phy mode operation.
> For example, in a few countries HE/EHT Operation is not allowed. For such
> countries, firmware indicates this via phy bitmap in each reg rule.
> 
> Currently, there is no logic to parse this info and then pass it on to the
> cfg80211/regulatory.
> 
> Add parsing of this phy bitmap from the regulatory channel change event and
> then accordingly map it to cfg80211/regulatory flags and pass it on to it.
> 
> While at it, correct typo in debug print: s/dsf/dfs.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

29ea0d409103 wifi: ath12k: add parsing of phy bitmap for reg rules

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231004092818.25130-1-quic_adisi@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

