Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D912403C6
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Aug 2020 11:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHJJB3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Aug 2020 05:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbgHJJB3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Aug 2020 05:01:29 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA762206B5;
        Mon, 10 Aug 2020 09:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597050088;
        bh=iGz664uJ2hWyo6/xsAJ3SeQmQmS8Fq5niSP2WTDZaY8=;
        h=Date:From:To:Subject:From;
        b=iTOe/o+tUrENJ3DYTSR5GCfRZhSGku2sb26nMXFZQIAeYrcsZkakeOzubEXeJND9z
         H346ID4DQ8Bo7N9sJM2YGPalyoJQMxwsOmelR/iV7m3wTyvLVNbCjyz+T4zZbym7Ua
         U7CbyQos44ofwm1qxknlhxoPU7iHtaTGtOpVxLPw=
Received: by pali.im (Postfix)
        id 635057C9; Mon, 10 Aug 2020 11:01:26 +0200 (CEST)
Date:   Mon, 10 Aug 2020 11:01:26 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     ath10k@lists.infradead.org, ath9k-devel@qca.qualcomm.com,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: CVE-2020-3702: Firmware updates for ath9k and ath10k chips
Message-ID: <20200810090126.mtu3uocpcjg5se5e@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello!

ESET engineers on their blog published some information about new
security vulnerability CVE-2020-3702 in ath9k wifi cards:
https://www.welivesecurity.com/2020/08/06/beyond-kr00k-even-more-wifi-chips-vulnerable-eavesdropping/

According to Qualcomm security bulletin this CVE-2020-3702 affects also
some Qualcomm IPQ chips which are handled by ath10k driver:
https://www.qualcomm.com/company/product-security/bulletins/august-2020-security-bulletin#_cve-2020-3702

Kalle, could you or other people from Qualcomm provide updated and fixed
version of ath9k and ath10k firmwares in linux-firmware git repository?

According to Qualcomm security bulletin this issue has Critical security
rating, so I think fixed firmware files should be updated also in stable
releases of linux distributions.
