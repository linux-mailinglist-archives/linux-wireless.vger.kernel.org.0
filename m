Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D384E703A
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 10:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348127AbiCYJuW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 05:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243192AbiCYJuU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 05:50:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB96251314
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 02:48:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B51360BC8
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 09:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8720C340E9;
        Fri, 25 Mar 2022 09:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648201724;
        bh=tyFPuBZdQzahVRT8oKGAhP1UiQ3ydMO+7g2vOclZClw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=F4oposrp218RAu8qOecJsUNdzyMQOqnysS1bK1fVuhko7B1m+UMLf3X1q/MsQ/13W
         7KQamQMmBJqoXm7wHs3uRvjddQmtilzwdEV5SVQ5HKkq6017bXnxndf1ZYZ0QeaqSH
         /ZqsnJtU0CX5FegX2C/YawtWRrpbxcWE1HCZJ5nszU8NWaWD8/XYdPojoZ5Ed/mL2m
         R9xb2X+NsWDlIRnJe8oHiqGCm9zw74YP5KCULqUIWJmc/0HDYTSlQJO6kWYwX7CjyN
         BMx5renh958yDO+zvrlJ+GWm/7K5eWkfuU2P4+dFFcvdONHD47oIbThHwFjGygkPUr
         +l7b3bFWa8C7g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: MAINTAINERS: update Lorenzo's email address
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <e98fcf759f8c23a9736f1c4d20ca0437e4b145de.1648120046.git.lorenzo@kernel.org>
References: <e98fcf759f8c23a9736f1c4d20ca0437e4b145de.1648120046.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        nbd@nbd.name
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164820172015.21419.17052973104472568029.kvalo@kernel.org>
Date:   Fri, 25 Mar 2022 09:48:43 +0000 (UTC)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Using my kernel.org email.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless.git, thanks.

24b488061b97 MAINTAINERS: update Lorenzo's email address

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/e98fcf759f8c23a9736f1c4d20ca0437e4b145de.1648120046.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

