Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D8B4A778F
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Feb 2022 19:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbiBBSMd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Feb 2022 13:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiBBSMd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Feb 2022 13:12:33 -0500
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Feb 2022 10:12:32 PST
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33FAC061714
        for <linux-wireless@vger.kernel.org>; Wed,  2 Feb 2022 10:12:32 -0800 (PST)
Received: from ziongate (localhost [127.0.0.1])
        by ziongate (OpenSMTPD) with ESMTP id df8d241d;
        Wed, 2 Feb 2022 18:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=simple; d=kernel-space.org; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; s=
        default; bh=V5lOi69avKTZE/pmswysAK7qexs=; b=thfO47zVTuHc7aPBOszb
        oladg8h4d4HN+uFwp1hOraO/Ase2vMUh4zZQz+MW8ftt/+0ZJEsAYr0X9tms4MAu
        R6qMvxHb+CaBDCqENSXVAQg5nbYaAm3T6NP0bfM8q6kPzISMTc1ex3dMzKsV/f/F
        J/i2+6okUboe1g+rz4iIGa4=
DomainKey-Signature: a=rsa-sha1; c=simple; d=kernel-space.org; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; q=dns;
         s=default; b=i5byNbvLoQaX1EywcOfaEQbzamiolWY3vnQMS5U+llQ2ELlD1D
        VBF48go2t4wefMrGQdmUfM9wCC4tUTUfJ1fP4/dCh9e7ym4eCGrOSO3VDPH0eR4m
        Fc7JrgMSbScnn9JBBRCW0QBHgriQ8Ppq20HqZkuW608XbXIdstR4Jl5Ko=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1643825150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=MyJmA3zbFNf8n4a8M/qmGe1K/3qHCzpXrKf1NxmPiH8=;
        b=VhSlBOOa7RbsnYkBDbCT6I+kq5EUJUgBMBsIxkDCkVVfGhq63288JAe6tbvgx7YCApG3VW
        m3HIySk49T87g3ZcJ7uTTVyVzT2/8qfqaS2UzFCdF3Hczb1m6SPF22gAYE87gSOGvTmhDG
        kI/Xj4QuRTEB4kAopv4MA1fkU4Q0l0Q=
Received: from dfj (host-79-25-62-48.retail.telecomitalia.it [79.25.62.48])
        by ziongate (OpenSMTPD) with ESMTPSA id 11138c7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 2 Feb 2022 18:05:49 +0000 (UTC)
Date:   Wed, 2 Feb 2022 19:05:43 +0100 (CET)
From:   Angelo Dureghello <angelo@kernel-space.org>
To:     linux-wireless@vger.kernel.org
cc:     luciano.coelho@intel.com, tf_xl@wp.pl
Subject: u-blox lily w132
Message-ID: <d94c986-8a6c-e75b-e437-322ef9ed5855@kernel-space.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all,

trying to figure out if a mainline driver for this
module is existing. The module offers USB and SDIO.

If the only driver is the one provided from u-blox,
is there some work in progress for a mainline driver ?

If there is no work in progress, and no blocking reasons,
i would try to mainline it in case.

Regards,
angelo
