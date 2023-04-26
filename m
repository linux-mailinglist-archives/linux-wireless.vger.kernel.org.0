Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F74E6EF671
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Apr 2023 16:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241407AbjDZObM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Apr 2023 10:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240643AbjDZObL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Apr 2023 10:31:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13BB5BBA
        for <linux-wireless@vger.kernel.org>; Wed, 26 Apr 2023 07:31:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E2A362ED7
        for <linux-wireless@vger.kernel.org>; Wed, 26 Apr 2023 14:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE24C433D2;
        Wed, 26 Apr 2023 14:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682519468;
        bh=1NdLuMS9alzONX0oYC1+o9aETwJMhrHT3EO+VwNaCSI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LsfOuBaVwF6xb/MRn8GWx58A1ilhUD0RM5PDwxMXbYowbz1+ZJgMCDzxVQBGf04NE
         RXOls1za0XpZZ/SSOSiwdBBxTzAWt3qAFmqEz2+9sxFi4g+bo/mC4KOFt7lBMbFlhq
         JoeEnHpY1uNocWu/LW5ELGujxcLkOgvhV1xzKmDbj5d7NRKKliWFQmbDd7df1DMy16
         W9VMve4xPFM/2SD2GTULGPjljC2YyWoDlfOwaA66L4M8GletTLUQtPfkK5d5J2OMl3
         E9BjSc82S/PLukdwl9C3XS+s0nfXOr9lYNGTrOsT4rhD3Esx/NOxgheAI9+c58ofZC
         9QcczyhMLxuRA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: send WMI_PEER_REORDER_QUEUE_SETUP_CMDID
 when
 ADDBA session starts
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230404070158.3368530-1-quic_cjhuang@quicinc.com>
References: <20230404070158.3368530-1-quic_cjhuang@quicinc.com>
To:     Carl Huang <quic_cjhuang@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_cjhuang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168251946566.11960.7919131610396931780.kvalo@kernel.org>
Date:   Wed, 26 Apr 2023 14:31:07 +0000 (UTC)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <quic_cjhuang@quicinc.com> wrote:

> Low receive throughput is seen on WCN7850 because ADDBA related
> parameters are not updated to firmware when receive ADDBA session starts.
> 
> Fix it by sending WMI_PEER_REORDER_QUEUE_SETUP_CMDID again to firmware
> to update the ADDBA related parameters for chips which have false
> reoq_lut_support in hw_params. For chips which have true reoq_lut_support
> in hw_params don't need this command to send to firmware.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

e671fb86ecc0 wifi: ath12k: send WMI_PEER_REORDER_QUEUE_SETUP_CMDID when ADDBA session starts

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230404070158.3368530-1-quic_cjhuang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

