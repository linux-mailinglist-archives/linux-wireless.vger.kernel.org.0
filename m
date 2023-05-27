Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23640713530
	for <lists+linux-wireless@lfdr.de>; Sat, 27 May 2023 16:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjE0Ope (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 May 2023 10:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjE0Opd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 May 2023 10:45:33 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2105.outbound.protection.outlook.com [40.107.243.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E81EB
        for <linux-wireless@vger.kernel.org>; Sat, 27 May 2023 07:45:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDqV4Beh3LunfGe7dzCXPzoBmedfdtbsDSu5r129KQ6SDSOSqDrXUh4YTVFjyo4uT/XE+3h4fPaLLutRDdmuKwEgdAboxyA8TcyexvkFbFCDrrDudsdNFDrp3n7u7nHyNLTZz+0ax6NdLA/5rmcY5ND2ht6ngw4UienBTnj7QilEtUloPjt+IfiWTCd6xfQPbySXOJbhrWk7Io9HjjiM7JiL74fIvFGMkwlMfpnNWiMiDsvd9OuNsawdd9EGUtsmF+bkk5qEJWRRDMNfeoRspfO6Vn8nJ8bJ4quSTZKW+9sckxfhpxTDlXqSQyzb2zJG/HuCSoadMBS0k9+XecxDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOsT6PmpYTSMHngqto6q1bxNhUqlvkPh7F4B28JtRAI=;
 b=ZkjcXQ0UIn+zaO0OgCSgXK3dp4sfJycH52rWU1PW8QIMPKJZ9dqEz9T61rGiLjraRGOspfMjtBLKLBQNWM5Dx2nSpL5NhgQOk4mkkY/EqKV/2oEqKPRK5ZTVWXQnTXi2lD+zv/31qZ0M30Y4kb6g7AnYDv1msAvoP4qgyL7qBgmVoJzXIuUeWDkt4YvPRXE8vh1hD/xKF1orX+oQYf9POyw7SW6HXpDxmUODtUw88X60hCKWT/MepcgVvMe6YkK+ZDvbiiZBtkih5puq4MfmmO1HUiIckT79NsIA4YmmkzOwJEZFd+2QadQpxjAjAN2WqMF12qrCWCtXFWGrSBvaaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOsT6PmpYTSMHngqto6q1bxNhUqlvkPh7F4B28JtRAI=;
 b=PzH9F3wF7duqWH4mJbCDvIAeeVd0iyRWykuTtYhZi9XDAo4HljVoSbMwbd780vfV2mzb40ZBq8+SI4F81dvUmbShywVHK1mHe645RmqC1gQBM4FjGvIFkXNibcCcXzllnWtk4FpwI4hoXr6zOZ2FqtdC23w0L3JxfBoK7bB5b+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BN0PR13MB4741.namprd13.prod.outlook.com (2603:10b6:408:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Sat, 27 May
 2023 14:45:28 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::5e55:9a39:751f:55f6]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::5e55:9a39:751f:55f6%3]) with mapi id 15.20.6433.018; Sat, 27 May 2023
 14:45:28 +0000
Date:   Sat, 27 May 2023 16:45:21 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Amisha.Patel@microchip.com
Cc:     linux-wireless@vger.kernel.org, Ajay.Kathat@microchip.com,
        Claudiu.Beznea@microchip.com
Subject: Re: [PATCH] wifi: wilc1000: add SPI commands retry mechanism
Message-ID: <ZHIXgbSw0kx+YnXG@corigine.com>
References: <20230525181739.30063-1-amisha.patel@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525181739.30063-1-amisha.patel@microchip.com>
X-ClientProxiedBy: AS4P191CA0039.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::24) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BN0PR13MB4741:EE_
X-MS-Office365-Filtering-Correlation-Id: 8408cc22-5331-40d9-7f66-08db5ec1034d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bYt1Zn3njcuzIgNrgX4VtNQl5qKZCrNe6YTw+NrW+5dII4WkL6vE8KSKwRI8u0Ci44dk2pBd6diaTD3ACj1dosyYJ5Tck5olbqm+8tWKz7J9Z8VA//T0eaJ1l7C1OsHb65infnWhqFxczihK4HXOr10K5LSlXJ70N3A0jypJYjXWpy8zePcRypi7JKvpnqVE2bGEOMSOr00GSvkDOvtsqLMEvRDARX82wrsG+QRckW3ybyELNius8mEu09h2bAr1ucMhfO7rFDOEUV9jV5h+q+Vu3ysIFgQe9pR2W/kourNcOl6q8T7WNsu5EmtuQmqoNJopFeSPWv7T2GUy5LmnxllyVyrNfY+uL/ztmlwF4TH1KDhprZz9BfnnJCYPUsKN/DlTg2U/5t+JmV45ZL936ADQfFYUdCngoO9YQU4lJAOKMNdAobvCaCz0pqJc6cvQ7xM5+YX987P7azcJyCIvRlosqqCRoxaYCTnapHbplJoxKwb5Dl/8in6YCkuLXST+zHi31SM59nE17CDWlwATZZUPMO9qIQYMBpoi65fkfXg0mi6cfzEYjIpO4RSj8nv/qS0wem1pgqaTtTKyQQfkKAZ6/qiS+w7PMxi8oMU9EQM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39830400003)(396003)(136003)(451199021)(316002)(86362001)(36756003)(478600001)(4326008)(6916009)(66946007)(66556008)(66476007)(6486002)(6666004)(8676002)(8936002)(5660300002)(41300700001)(2906002)(44832011)(38100700002)(6512007)(6506007)(186003)(2616005)(83380400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jwDoiD3iF2CUQQKJB9FyYs0P0DYeoYrm2G9xVxIISALjOq8c1YxAAwBWtwMF?=
 =?us-ascii?Q?/4c0hvhAOUMKYoOTXrAlo4VWxjhWDBQ2cRGLAqyPsN/252XOI8eCReoKRFlk?=
 =?us-ascii?Q?lu/yHuDG5uwR82urxQ30O48DRHbfJwEE31ymEsnWnnAd6uyw9BYMOXxm45xz?=
 =?us-ascii?Q?efrbHupHr3jWG/suPyQyJogAZ9RqiysVIAiaZhw+Pzsf+sK+XbUP5LlLCWTo?=
 =?us-ascii?Q?CXEmUibDeinLA+L+eo8v1+trD4iwgL5Dhlh6OU/faxznbNimt3MiC/i1GGB/?=
 =?us-ascii?Q?FKjE8d2QPe8hk/9rYvNoRNZ7rBJZ9ZXSo7gxSoZkkNtOqIlg7MFNFllu7U5Y?=
 =?us-ascii?Q?DEcH5FFrQNxSecYTHnkW2aXSjsbRaXl7xzuqtjIRn13/1bcxkSmbQLI/1QdN?=
 =?us-ascii?Q?Q0sYYraCE/fMOK4hR8hgxbCfQ0oof4K7eEyMpI96bDWBI891bK30CNwVm7Ha?=
 =?us-ascii?Q?QtvuPOi6EU4WQzYvabnkyREBOR8MnQOwnDBteYraR4qKz67LQiLWcRIKgFTq?=
 =?us-ascii?Q?mT42dxXgSRtdpOAYmZ84uBCBV6n3XvBK8q0RMd7NWjnVJOkllGqGT6HLG5AL?=
 =?us-ascii?Q?FB1Vc+klF/rXDRHM7qLwmL0JEMbTOHVAKDfZwtCMKWrQDOyFYtr4DhlsXLv5?=
 =?us-ascii?Q?BY46q71jDGQrbHoZpN4htzYk4HzoPIztBr8sSEnBCOSIQpfIMQ9vUVz+C3+p?=
 =?us-ascii?Q?s36VBAB2auRHte+pY9YHIEJ9P2bYspkqsNTs+5lZkozh25Ik69t4bGncrbIZ?=
 =?us-ascii?Q?9CtFwewbhBs4xI+6wN0MKrDO4dtFqif6n8W8BMsOIhonBURC4bMAGs3cr+MG?=
 =?us-ascii?Q?Wp37o0kW6Zpd4rAJCUML9LH6u85zbxP0aqObzzeNLxVU8/McdFAkXiCiAuzV?=
 =?us-ascii?Q?aWpIJFXuXd1UYaMfr9Ym5D7hfGYJWV4mBFe5duIWHKPYqP5gRJLAaFjc+xXT?=
 =?us-ascii?Q?mBYdCGj/Qz15Po6gJn5/HcDhFcrLafxX0cfyK6nr8nD175OE+0pw8NLP9lac?=
 =?us-ascii?Q?H+nvsZCV0HuczhdidH1j6mc0zZQYV2byv1x37PkB26sxY8/KgGJOkWlRzd0B?=
 =?us-ascii?Q?qJeLkw2B1J6xWnHQDr2629gOxkL17ZO33SS2VoyRe+JJxPKdTc5FySeE4bg9?=
 =?us-ascii?Q?q5jNGX5mn/cEefSPaOSmVY4rAtu61UWz4l1jO5Du2XwWkKRMV3fYH3SEabmx?=
 =?us-ascii?Q?A+8JDpFB58F2rua4FwTM21XHFVPdYaFl0zRvs1USQ3O/SNLQeDnPknwnE9PT?=
 =?us-ascii?Q?iMxW92LZMivqftWQzgavq6S7Q36V2kwI6YnagnXz9JULe4sFGoisGgT9OsHS?=
 =?us-ascii?Q?IJx3CsN1mjufT5qwMlu9IV6D3bcmVKDjvYMDwUOoz4M1oYKnkPAvpW02z3SL?=
 =?us-ascii?Q?rQOfAmniR0n4Qar9AE8k6Mp626gcBFqNt5In7lnARc0/CHdaV7kTC6alPXxb?=
 =?us-ascii?Q?6kMl2r8FYUQvj8yo6NqXwQ8rTUUUX7+6DcIGHWJ9R5isPAQoJbb5A6d3X3RZ?=
 =?us-ascii?Q?2rUhRjKZbZszdmf4if2n/qU+OmPul2BhqnNWMLAW1RzGT6qj9aVTUedlT0Sz?=
 =?us-ascii?Q?dYOsTH5/5b+6QFmgRuQPHWbjJd08qCSkXyZXyFLsrbveIbYpUWWZT9943SPn?=
 =?us-ascii?Q?7YCqmMqtJZ4YpSHAPpOkKL86P2X4zDoIPr9M8X/TqPV2EF6C1RgJK8ACj0xV?=
 =?us-ascii?Q?NKVcTA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8408cc22-5331-40d9-7f66-08db5ec1034d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 14:45:28.3157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zj0x31lx0wgG1kznleB9ta5ab18Rvb0Gt8T0F00m8CnwWpKWhZm/ys/BGN22ugtcQVpDx7KJrCq8k5AOo2ijD2LonA23pu5O5sFTj5hyjwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4741
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 25, 2023 at 06:17:48PM +0000, Amisha.Patel@microchip.com wrote:
> From: Amisha Patel <amisha.patel@microchip.com>
> 
> In some situations like, chip wake-up with powersave enabled, SPI
> commands are failing temporarily. Reissuing commands after reset helps
> to overcome the failure. So, add the retry limit and reset command
> sequence API for read/write SPI commands.
> 
> Signed-off-by: Amisha Patel <amisha.patel@microchip.com>

Hi Amisha,

thanks for your patch.
Some minor nits from my side.

...

>  static int wilc_spi_read_reg(struct wilc *wilc, u32 addr, u32 *data)
>  {
>  	struct spi_device *spi = to_spi_device(wilc->dev);
>  	int result;
>  	u8 cmd = CMD_SINGLE_READ;
>  	u8 clockless = 0;
> +	u8 retry_limit = SPI_RETRY_MAX_LIMIT;
>  
> -	if (addr < WILC_SPI_CLOCKLESS_ADDR_LIMIT) {
> +	if (addr <= WILC_SPI_CLOCKLESS_ADDR_LIMIT) {
>  		/* Clockless register */
>  		cmd = CMD_INTERNAL_READ;
>  		clockless = 1;
>  	}
> -
> +	

nit: trailing tabs on the line above

> +retry:
>  	result = wilc_spi_single_read(wilc, cmd, addr, data, clockless);
>  	if (result) {
>  		dev_err(&spi->dev, "Failed cmd, read reg (%08x)...\n", addr);
> -		return result;
> +		

Ditto

> +		/* retry is not applicable for clockless registers */
> +		if (clockless || !retry_limit)
> +			return result;
> +
> +		wilc_spi_reset_cmd_sequence(wilc, retry_limit, addr);
> +		retry_limit--;
> +		goto retry;
>  	}
>  
>  	le32_to_cpus(data);
> @@ -858,14 +881,22 @@ static int wilc_spi_read(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
>  {
>  	struct spi_device *spi = to_spi_device(wilc->dev);
>  	int result;
> +	u8 retry_limit = SPI_RETRY_MAX_LIMIT;
>  
>  	if (size <= 4)
>  		return -EINVAL;
>  
> +retry:
>  	result = wilc_spi_dma_rw(wilc, CMD_DMA_EXT_READ, addr, buf, size);
>  	if (result) {
>  		dev_err(&spi->dev, "Failed cmd, read block (%08x)...\n", addr);
> -		return result;
> +		

Ditto

> +		if (!retry_limit)
> +			return result;
> +
> +		wilc_spi_reset_cmd_sequence(wilc, retry_limit, addr);
> +		retry_limit--;
> +		goto retry;
>  	}
>  
>  	return 0;
> @@ -875,11 +906,19 @@ static int spi_internal_write(struct wilc *wilc, u32 adr, u32 dat)
>  {
>  	struct spi_device *spi = to_spi_device(wilc->dev);
>  	int result;
> +	u8 retry_limit = SPI_RETRY_MAX_LIMIT;
>  
> +retry:
>  	result = wilc_spi_write_cmd(wilc, CMD_INTERNAL_WRITE, adr, dat, 0);
>  	if (result) {
>  		dev_err(&spi->dev, "Failed internal write cmd...\n");
> -		return result;
> +		

Ditto

> +		if (!retry_limit)
> +			return result;
> +
> +		wilc_spi_reset_cmd_sequence(wilc, retry_limit, adr);
> +		retry_limit--;
> +		goto retry;
>  	}
>  
>  	return 0;
> @@ -890,12 +929,20 @@ static int spi_internal_read(struct wilc *wilc, u32 adr, u32 *data)
>  	struct spi_device *spi = to_spi_device(wilc->dev);
>  	struct wilc_spi *spi_priv = wilc->bus_data;
>  	int result;
> +	u8 retry_limit = SPI_RETRY_MAX_LIMIT;
>  
> +retry:
>  	result = wilc_spi_single_read(wilc, CMD_INTERNAL_READ, adr, data, 0);
>  	if (result) {
>  		if (!spi_priv->probing_crc)
>  			dev_err(&spi->dev, "Failed internal read cmd...\n");
> -		return result;
> +			

Ditto

> +		if (!retry_limit)
> +			return result;
> +
> +		wilc_spi_reset_cmd_sequence(wilc, retry_limit, adr);
> +		retry_limit--;
> +		goto retry;
>  	}
>  
>  	le32_to_cpus(data);
> @@ -915,19 +962,26 @@ static int wilc_spi_write_reg(struct wilc *wilc, u32 addr, u32 data)
>  	int result;
>  	u8 cmd = CMD_SINGLE_WRITE;
>  	u8 clockless = 0;
> -
> -	if (addr < WILC_SPI_CLOCKLESS_ADDR_LIMIT) {
> +	u8 retry_limit = SPI_RETRY_MAX_LIMIT;
> +	

Ditto

> +	if (addr <= WILC_SPI_CLOCKLESS_ADDR_LIMIT) {
>  		/* Clockless register */
>  		cmd = CMD_INTERNAL_WRITE;
>  		clockless = 1;
>  	}
>  
> +retry:
>  	result = wilc_spi_write_cmd(wilc, cmd, addr, data, clockless);
>  	if (result) {
>  		dev_err(&spi->dev, "Failed cmd, write reg (%08x)...\n", addr);
> -		return result;
> -	}
> +		

Ditto

> +		if (clockless || !retry_limit)
> +			return result;
>  
> +		wilc_spi_reset_cmd_sequence(wilc, retry_limit, addr);
> +		retry_limit--;
> +		goto retry;
> +	}
>  	return 0;
>  }
>  
> @@ -981,6 +1035,7 @@ static int wilc_spi_write(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
>  {
>  	struct spi_device *spi = to_spi_device(wilc->dev);
>  	int result;
> +	u8 retry_limit = SPI_RETRY_MAX_LIMIT;
>  
>  	/*
>  	 * has to be greated than 4
> @@ -988,11 +1043,12 @@ static int wilc_spi_write(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
>  	if (size <= 4)
>  		return -EINVAL;
>  
> +retry:
>  	result = wilc_spi_dma_rw(wilc, CMD_DMA_EXT_WRITE, addr, NULL, size);
>  	if (result) {
>  		dev_err(&spi->dev,
>  			"Failed cmd, write block (%08x)...\n", addr);
> -		return result;
> +		goto fail;
>  	}
>  
>  	/*
> @@ -1001,13 +1057,27 @@ static int wilc_spi_write(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
>  	result = spi_data_write(wilc, buf, size);
>  	if (result) {
>  		dev_err(&spi->dev, "Failed block data write...\n");
> -		return result;
> +		goto fail;
>  	}
>  
>  	/*
>  	 * Data response
>  	 */
> -	return spi_data_rsp(wilc, CMD_DMA_EXT_WRITE);
> +	result = spi_data_rsp(wilc, CMD_DMA_EXT_WRITE);
> +	if (result) {
> +		dev_err(&spi->dev, "Failed block data rsp...\n");
> +		goto fail;
> +	}
> +
> +	return 0;
> +
> +fail:
> +	if (result && retry_limit) {

nit: is result always non-zero here?

> +		wilc_spi_reset_cmd_sequence(wilc, retry_limit, addr);
> +		retry_limit--;
> +		goto retry;
> +	}
> +	return result;
>  }
>  
>  /********************************************
