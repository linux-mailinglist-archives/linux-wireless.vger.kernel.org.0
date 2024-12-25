Return-Path: <linux-wireless+bounces-16792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 249369FC448
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Dec 2024 09:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483AD1883D1C
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Dec 2024 08:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FDE14F125;
	Wed, 25 Dec 2024 08:53:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A84B1494B2;
	Wed, 25 Dec 2024 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735116816; cv=none; b=ray+Usp6uUgRYHSjTKM7roN9O/3RztV/PfII+uOYIYjmQTLJ8mVYl5OrBAe3u0l8ZijN7Vp1Y+tId1MEbkF/4Bk4LLEjMrK9R2IDs2+LW2ldnba96A4kOcfQRpAJiWM5CdC+FtF8SehLRU3PbgP2aK2/XnewlE+4HaDwPg3hu7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735116816; c=relaxed/simple;
	bh=ljKmAB0VT2J1XoUx9siQ779m5CZ8tdsK068WTcuBiOY=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=u+YZ5S1LyTXz3ofNDV/pwsSC7WeJ+tERJlIAgHnSxj7sdo8PWWQvtuTivevfW+M7HWwyYLPFkxuOTM+fqmTE7XF2eD9xAb17odEmQtX5iauD5Hcf6KimUSuB3txwxLWT+BFSCrzTzBJZnL4Bm6nyA1euLGvBSTHWyJmt7V9c5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YJ5BG5FtJz1JGH9;
	Wed, 25 Dec 2024 16:52:54 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id D7E341A0188;
	Wed, 25 Dec 2024 16:53:24 +0800 (CST)
Received: from [10.67.111.53] (10.67.111.53) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Dec
 2024 16:53:24 +0800
Message-ID: <7e456e10-23a0-412b-8bf8-8860aef436dd@huawei.com>
Date: Wed, 25 Dec 2024 16:53:23 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <zhangkunbo@huawei.com>
CC: <angelogioacchino.delregno@collabora.com>, <chris.zjh@huawei.com>,
	<deren.wu@mediatek.com>, <kvalo@kernel.org>, <liaochang1@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
	<lorenzo@kernel.org>, <matthias.bgg@gmail.com>, <mingyen.hsieh@mediatek.com>,
	<nbd@nbd.name>, <ryder.lee@mediatek.com>, <sean.wang@mediatek.com>,
	<shayne.chen@mediatek.com>
References: <20241218074552.3271542-1-zhangkunbo@huawei.com>
Subject: Re: [PATCH -next] wifi: mt76: mt7925:: replace zero-length array with
 flexible-array member
From: zhangkunbo <zhangkunbo@huawei.com>
In-Reply-To: <20241218074552.3271542-1-zhangkunbo@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh100007.china.huawei.com (7.202.181.92)

ping gently.


